require 'rails_helper'
require_relative '../support/page_form'

feature 'Home Page' do
  context 'A visitor should be able to' do
    let(:home_page_form) { PageForm.new }
      
    scenario 'See the Home Page' do
      home_page_form.visit_page
      
      expect(page).to(
        have_content('Take notes so that you can recall things in your personal life.')
      )
    end
  
    scenario 'Register an account' do
      home_page_form.visit_page.click('Sign Up')
        .fill('Email': 'sample@example.com', 'Password': 'sample_password',
          'Password confirmation': 'sample_password')
        .click('Sign up', 'form')
        
      expect(page).to(
          have_content("You haven't made any notes yet. Want to create one?")
      )
    end
   
  end
  
  context 'A registered user should be able to' do
    let(:home_page_form) { PageForm.new }
    
    scenario 'Log-in using an existing account' do
      user = FactoryGirl.create(:user)
      
      home_page_form.login_user(user)
      
      expect(page).to(
          have_content("You haven't made any notes yet. Want to create one?")
      )
    end
    
    scenario 'Log-out once logged-in' do
      user = FactoryGirl.create(:user)
      
      home_page_form.login_user(user).click('Logout')
      
      expect(page).to(
        have_content('Take notes so that you can recall things in your personal life.')
      )
    end
    
    scenario 'Edit his/her profile email' do
      user = FactoryGirl.create(:user)
      
      home_page_form.login_user(user)
        .click('Edit Profile')
        .fill('Email': 'another@email.com', 'Current password': user.password)
        .click('Update')
        .click('Logout')
        
      modified_user = user
      modified_user.email = 'another@email.com'
      home_page_form.login_user(modified_user)
      
      expect(page).to(
          have_content("You haven't made any notes yet. Want to create one?")
      )
    end
    
    scenario 'Edit his/her profile password' do
      user = FactoryGirl.create(:user)
      
      home_page_form.login_user(user)
        .click('Edit Profile')
        .fill('Password': 'another-password', 
              'Password confirmation': 'another-password',
              'Current password': user.password)
        .click('Update')
        .click('Logout')
        
      modified_user = user
      modified_user.password = 'another-password'
      home_page_form.login_user(modified_user)
      
      expect(page).to(
          have_content("You haven't made any notes yet. Want to create one?")
      )
    end
    
     scenario 'Should be to cancel his/her account' do
      user = FactoryGirl.create(:user)
      
      home_page_form.login_user(user)
        .click('Edit Profile')
        .click('Cancel my account')
      
      expect(page).to(
        have_content('Take notes so that you can recall things in your personal life.')
      )
    end
    
  end
end

