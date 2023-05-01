class Tag < ApplicationRecord
  has_many :book_tag_relations
  has_many :books, through: :book_tag_relations, dependent: :destroy 
end
