class Note < ApplicationRecord
  attr_accessor :new_category  # for creating categories
  
  belongs_to :user
  belongs_to :category
end
