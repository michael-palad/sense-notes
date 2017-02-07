require 'rails_helper'
require_relative '../support/home_page_form'

feature 'Home Page' do
  context 'A visitor should be able to' do
    let(:home_page_form) { HomePageForm.new }  
      
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
  
    scenario 'Log-in using an existing account' do
      user = FactoryGirl.create(:user)
      
      home_page_form.visit_page.click('Login')
        .fill('Email': user.email, 'Password': user.password)
        .click('Log in', 'form')
      
      expect(page).to(
          have_content("You haven't made any notes yet. Want to create one?")
      )
    end
    
    scenario 'Log-out once logged-in' do
      user = FactoryGirl.create(:user)
      
      home_page_form.visit_page.click('Login')
        .fill('Email': user.email, 'Password': user.password)
        .click('Log in', 'form').click('Logout')
      
      expect(page).to(
        have_content('Take notes so that you can recall things in your personal life.')
      )
    end
  end
end