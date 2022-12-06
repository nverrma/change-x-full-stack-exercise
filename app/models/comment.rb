class Comment < ApplicationRecord
  validates :body, :status_changed_from, :status_changed_to, presence: true

  belongs_to :applicant
end
