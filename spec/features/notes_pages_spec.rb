require 'rails_helper'
require_relative '../support/page_form'

feature 'Notes Pages' do
  context 'A logged-in user should be able to' do
    let(:notes_pages_form) { PageForm.new }
      
    scenario 'Create new notes' do
      user = FactoryGirl.create(:user)
      
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Sample Content')
        .click('Create', 'form')
        
      expect(page).to(
        have_content('Sample Title').and have_content('Sample Content')    
      )
    end
    
    scenario 'Edit an existing note' do
      user = FactoryGirl.create(:user)
      
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Sample Content')
        .click('Create', 'form')   
        .click('Edit Note')
        .fill('Title': 'Modified Title', 'Content': 'Modified Content')
        .click('Update', 'form')
        
      expect(page).to(
        have_content('Modified Title').and have_content('Modified Content')    
      )
    end
      
    scenario 'Create a category for a note' do
      user = FactoryGirl.create(:user)
      
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Sample Content')
        .fill('note_new_category': 'Some Category')
        .click('Add Category')
        .click('Create', 'form')
        
        
      expect(page).to have_content('Some Category')
    end
    
    scenario 'Delete an existing note' do
       user = FactoryGirl.create(:user)
      
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Sample Content')
        .click('Create', 'form')    
        .click('Delete Note')
        
      expect(page).to have_no_content('Sample Title')
    end
    
    scenario 'Search for an existing note by title' do
      user = FactoryGirl.create(:user)
      
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Searchable Title', 'Content': 'Sample Content')
        .click('Create', 'form')
        .click('Home')
        .fill('Search:': 'Searchable Title')
        .click('Search')
    
      expect(page).to have_css('a', text: 'Searchable Title')  
    end
    
    scenario 'Search for an existing note by content' do
      user = FactoryGirl.create(:user)
      
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Searchable Content')
        .click('Create', 'form')
        .click('Home')
        .fill('Search:': 'Searchable Content')
        .click('Search')
    
      expect(page).to have_css('td', text: 'Searchable Content')  
    end
  end
end