class Contact < ApplicationRecord
  belongs_to :portfolio

  validates :phone, :email, presence: true
end
