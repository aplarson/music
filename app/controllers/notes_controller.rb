class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.track_id = params[:track_id]
    unless @note.save
      flash.now[:errors] = @note.errors.full_messages
    end
    redirect_to track_url(@note.track_id)
  end

  def destroy
    @note = Note.find(params[:id])
    track = @note.track_id
    @note.destroy
    redirect_to track_url(track)
  end

  private

  def note_params
    params.require(:note).permit([:note_text])
  end
end
