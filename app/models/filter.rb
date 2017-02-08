class Filter
  attr_accessor :category_id
  
  def initialize(category_id = "")
    self.category_id = category_id      
  end
end