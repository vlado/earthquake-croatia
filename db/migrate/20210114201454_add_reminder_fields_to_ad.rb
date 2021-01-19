class AddReminderFieldsToAd < ActiveRecord::Migration[6.1]
  def change
    add_column :ads, :reminder_sent_at, :datetime
  end
end
