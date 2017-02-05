class Note < ApplicationRecord
  attr_accessor :new_category  # for creating categories
  
  belongs_to :user
  belongs_to :category
  
  validates :title, presence: true
  validates :content, presence: true
  validate :new_category_is_not_blank
  
  def new_category_is_not_blank
    logger.debug "DBG: HERE"
    if self.new_category.strip.blank?
      logger.debug "DBG: YET"
      errors.add(:new_category, "Category cannot be blank") 
    end
  end 
end
