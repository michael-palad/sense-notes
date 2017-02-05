class NotesController < ApplicationController
  before_action :find_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = current_user.notes.order('created_at DESC')
  end
  
  def show
  end
  
  def new
    @note = Note.new
  end
  
  def create
    if add_category?
      @note = Note.new(note_params)
      @category = Category.new(name: note_params[:new_category], user: current_user)
      if @category.save
        @note.category = @category
        render 'new'
      else
        flash.now[:alert] = @category.errors.first[1]
        render 'new'
      end
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
      @note = Note.new(note_params)
      @category = Category.new(name: note_params[:new_category], user: current_user)
      if @category.save
        @note.category = @category
        render 'edit'
      else
        flash.now[:alert] = @category.errors.first[1]
        render 'edit'
      end
      
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
end
