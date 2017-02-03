module ApplicationHelper
  def sign_up_text
    raw('<span class="glyphicon glyphicon-user"></span> Sign Up')
  end
  
  def login_text
    raw('<span class="glyphicon glyphicon-login"></span> Login')
  end
end
