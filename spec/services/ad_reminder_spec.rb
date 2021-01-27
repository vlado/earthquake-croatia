# frozen_string_literal: true

require "rails_helper"

RSpec.describe AdReminder do
  subject(:reminder) { described_class.new }

  describe "#remind_oldest" do
    subject(:remind_oldest) { reminder.remind_oldest(batch_size) }

    let(:batch_size) { 1 }

    it "sends reminder for an ad that's older than 2 days that wasn't reminded" do
      ad = create(:ad, :with_email, created_at: 49.hours.ago)

      expect { remind_oldest }.to change { ActionMailer::Base.deliveries.size }.by(1)

      last_delivery = ActionMailer::Base.deliveries.last
      expect(last_delivery.to).to eq [ad.email]
      ad.reload
      expect(ad.token).to be_present
      expect(ad.reminder_sent_at).to be_present
      expect(last_delivery.body).to include("edit?t=#{ad.token}")
      expect(last_delivery.body).to include("delete/new?t=#{ad.token}")
    end

    it "doesn't send reminder for an ad that's newer than 2 days" do
      create(:ad, :with_email, created_at: 47.hours.ago)

      expect { remind_oldest }.not_to(change { ActionMailer::Base.deliveries.size })
    end

    it "doesn't send reminder for an ad that was reminded" do
      create(:ad, :with_email, created_at: 3.days.ago, reminder_sent_at: 1.day.ago)

      expect { remind_oldest }.not_to(change { ActionMailer::Base.deliveries.size })
    end

    it "doesn't try to send reminder for an ad without an email" do
      create(:ad, email: nil, created_at: 3.days.ago)

      expect { remind_oldest }.not_to(change { ActionMailer::Base.deliveries.size })
    end

    it "doesn't try to send reminder for an ad that was deleted" do
      create(:ad, :deleted, :with_email, created_at: 49.hours.ago)

      expect { remind_oldest }.not_to(change { ActionMailer::Base.deliveries.size })
    end
  end
end
