class Category < ApplicationRecord
  has_many :notes
  
  belongs_to :user
  
  validates :name, presence: true
  
  # Doesn't seem to work as it should (case-insensitve validation)
  # Else the custom validation category_unique_to_user isn't required
  #
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
    # the code below is shorter but fails the test because
    # of the use of associations
    # self.user.categories.where('lower(name) = lower(?)', self.name).empty?
    duplicates = self.class.where('lower(name) = lower(?)', self.name)
    unless duplicates.empty?
      duplicates.each do |duplicate|
        return false if duplicate.user == self.user
      end
    end
    
    return true
  end
  
end
