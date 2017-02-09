class NotesController < ApplicationController
  before_action :find_note, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:show, :edit, :update, :destroy]

  def index
    @notes_empty = current_user.notes.empty?
    if @notes_empty
      render :index and return  
    end
    
    @notes = nil
    category_id = ""
    if filter_by_category?
      category_id = params[:filter][:category_id]
      unless category_id.blank?
        @q = current_user.notes.ransack(category_id_eq: category_id) 
        @notes = @q.result
      end
    end
     
    if @notes.nil?
      @q = current_user.notes.ransack(params[:q])
      @notes = @q.result
    end
    
    @filter_shown = current_user.categories.any?
    @filter = Filter.new(category_id)
  end
  
  def show
  end
  
  def new
    @note = Note.new
  end
  
  def create
    if add_category?
     add_category_and_render('new')
    else
      @note = current_user.notes.build(note_params)
      if @note.save
        redirect_to @note
      else
        render 'new'
      end
    end
  end
  
  def edit
  end
  
  def update
    if add_category?
      add_category_and_render('edit')
    else
      if @note.update(note_params)
        redirect_to @note
      else
        render 'edit'
      end
    end
  end
  
  def destroy
    @note.destroy
    redirect_to notes_path
  end
  
  private
  
  def find_note
    @note = Note.find(params[:id])
  end
  
  def note_params
    params.require(:note).permit(:title, :content, :category_id, :new_category)
  end
  
  def add_category?
    params[:commit] == "Add Category"  
  end
  
  def filter_by_category?
    params[:commit] == "Filter by Category" 
  end
  
  def check_owner
    note = Note.find(params[:id])
    if current_user != note.user
      redirect_to notes_path 
    end
  end
  
  def add_category_and_render(template)
    @note = Note.new(note_params)
    @category = Category.new(name: note_params[:new_category], user: current_user)
    if @category.save
      @note.category = @category
      render template
    else
      @note.errors.add(:new_category, "can't be blank.")
      render template
    end  
  end
  
end
