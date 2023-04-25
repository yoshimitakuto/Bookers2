class BookComment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  validates :comment, presence: true
end
