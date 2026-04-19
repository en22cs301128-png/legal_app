class Case < ApplicationRecord
  validates :title, presence: true
  validates :status, inclusion: { in: %w[open closed pending] }
  validates :client_name, presence: true

  scope :open_cases, -> { where(status: "open") }
  scope :closed_cases, -> { where(status: "closed") }
end
