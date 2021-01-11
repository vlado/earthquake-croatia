# frozen_string_literal: true

module SoftlyDeletable
  extend ActiveSupport::Concern

  included do
    scope :deleted, -> { where.not(deleted_at: nil) }
    scope :not_deleted, -> { where(deleted_at: nil) }
  end

  def soft_delete!(reason_code = nil, comment = nil)
    Reason.create(ad: self, code: reason_code, comment: comment) if reason_code || comment

    update!(deleted_at: Time.zone.now)
  end
end
