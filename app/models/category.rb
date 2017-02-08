class Category < ApplicationRecord
  has_many :notes
  
  belongs_to :user
  
  validates :name, presence: true
  
  # Doesn't seem to work as it should
  # validates :name, uniqueness: {
  #   scope: :user_id,
  #   message: 'category name must be unique to user',
  #   case_sensitive: true
  # }
  
  validate :category_unique_to_user
  
  def category_unique_to_user
    unless name_doesnt_exist_for_user?
      errors.add(:name, "That category already exists.")
    end
  end
  
  protected
  
  def name_doesnt_exist_for_user?
    self.user.categories.where('lower(name) = lower(?)', self.name).empty?
  end
  
end
