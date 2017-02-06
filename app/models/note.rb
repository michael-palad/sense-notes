class Note < ApplicationRecord
  attr_accessor :new_category  # for creating categories
  
  belongs_to :user
  belongs_to :category
  
  validates :title, presence: true
  validates :content, presence: true
end
