class SongsController < ApplicationController
  before_action :logged_in, only: [:show, :show_user]
  def show
    @song = Song.find(params[:song_id])
    
    @user_id = @song.likes.pluck(:user_id).uniq
    unique_users = []
    @user_id.each do |user_id|
      found_users = User.find(user_id)
      @all_users = unique_users.push(found_users) 
    end
    

  end

  def show_user
    @user= User.find(params[:user_id])
    @song_id = @user.liked_songs.pluck(:song_id).uniq
    unique_songs = []
    @song_id.each do |song_id| 
      found_songs = Song.find(song_id)
      @all_songs = unique_songs.push(found_songs)
    end

  end
  def add_like
    @user = User.find(current_user.id)
    @song = Song.find(params[:song_id])
    Liked.create(user:@user, song: @song, likes:1)
    return redirect_to "/"
  end

  def create
    @song = Song.new(song_params)
    if @song.valid?
      @song.save 
      return redirect_to "/"
    end
    flash[:errors] = ["Both fields must contain at least 2 characters!"]
    return redirect_to "/"

  end



  private
  def song_params
      params.require(:song).permit(:title, :artist)
  end

  def logged_in
    if !session[:user_id]
      return redirect_to '/sessions/new'
    end
  end
end
