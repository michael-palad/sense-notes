require 'rails_helper'
require_relative '../support/page_form'

feature 'Notes Pages' do
  context 'A logged-in user should be able to' do
    let(:notes_pages_form) { PageForm.new }
    let(:user) { FactoryGirl.create(:user) }

      
    scenario 'Create new notes' do
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Sample Content')
        .click('Create', 'form')
        
      expect(page).to(
        have_content('Sample Title').and have_content('Sample Content')    
      )
    end
    
    scenario 'Edit an existing note' do
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
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Sample Content')
        .fill('note_new_category': 'Some Category')
        .click('Add Category')
        .click('Create', 'form')
        
        
      expect(page).to have_content('Some Category')
    end
    
    scenario 'Delete an existing note' do
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Sample Content')
        .click('Create', 'form')    
        .click('Delete Note')
        
      expect(page).to have_no_content('Sample Title')
    end
    
    scenario 'Search for an existing note by title' do
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Searchable Title', 'Content': 'Sample Content')
        .click('Create', 'form')
        .click('Home')
        .fill('q_title_or_content_cont': 'Searchable Title')
        .click('Search')
    
      expect(page).to have_css('a', text: 'Searchable Title')  
    end
    
    scenario 'Search for an existing note by content' do
      notes_pages_form.visit_page.login_user(user)
        .click('New Note')
        .fill('Title': 'Sample Title', 'Content': 'Searchable Content')
        .click('Create', 'form')
        .click('Home')
        .fill('q_title_or_content_cont': 'Searchable Content')
        .click('Search')
    
      expect(page).to have_css('td', text: 'Searchable Content')  
    end
    
    scenario 'Filter notes by category' do
      category = FactoryGirl.create(:category, name: 'Some Category', user: user)
      FactoryGirl.create(:note, title: 'First Note', content: 'Content1',
                 user: user, category: category)
      FactoryGirl.create(:note, title: 'Second Note', content: 'Content2',
                 user: user, category: nil)
                 
      notes_pages_form.visit_page.login_user(user)
        .select_option('Some Category', 'filter_category_id')
        .click('Filter by Category')
      
      expect(page).to have_css('a', text: 'First Note')
      expect(page).not_to have_css('a', text: 'Second Note')
    end
  end
end