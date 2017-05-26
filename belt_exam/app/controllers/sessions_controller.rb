class SessionsController < ApplicationController
  before_action :logged_in, only: [:index]
  def new
    logged_in_redirect
  end

  def index
    current_user
    @songs = Song.all

  end



def create
    email = login_params["email"]
    @user = User.find_by_email(email)
    if !@user
      flash[:errors] = ["Invalid Email or Password"]
      return redirect_to'/sessions/new'
    end
    if @user.authenticate(login_params[:password])
      session[:user_id] = @user.id
      return redirect_to '/'
    end
    flash[:errors] = ["Invalid Email or Password"]
    redirect_to '/sessions/new'
  end
  def destroy
    session.clear
    redirect_to '/sessions/new'
  end

  def register
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      return redirect_to '/'
    end
    flash[:errors] = @user.errors.full_messages
    redirect_to '/sessions/new'

  end





private
  def logged_in_redirect
    if session[:user_id]
      return redirect_to "/"
    end
  end

  def logged_in
    if !session[:user_id]
      return redirect_to '/sessions/new'
    end
  end

  def login_params
      params.require(:user).permit(:email, :password)
  end
  def user_params
      params.require(:user).permit(:first_name,:last_name, :email, :password, :password_confirmation)
  end



end