class NotesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :check_user_owns_note, only: :destroy

  def create
    note = Note.new(note_params)
    note.user_id = current_user.id
    if note.save
      flash[:success] = "Note created!"
    else
      flash[:errors] = note.errors.full_messages
    end

    redirect_to track_url(note.track_id)
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    flash[:success] = "Note deleted."
    
    redirect_to track_url(note.track_id)
  end

  def check_user_owns_note
    note = Note.find(params[:id])
    if current_user.id != note.user_id
      render :status => :forbidden, :text => "Can't Delete Other Users' Notes"
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id)
  end
end
