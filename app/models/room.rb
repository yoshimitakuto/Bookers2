class Room < ApplicationRecord
  #DM機能
has_many :entries, dependent: :destroy
has_many :messages, dependent: :destroy
end
