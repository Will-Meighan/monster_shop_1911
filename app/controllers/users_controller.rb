class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user] = @user.id
      redirect_to "/profile"
      flash[:notice] = "You are registered and now logged in."
    elsif @user.duplicate_email?(@user.email)
      flash[:notice] = "Email is already in use, please try another."
      render :new
    else
      flash[:notice] = "Please fill out all required fields."
      render :new
    end
  end

  def show
    if !current_user
      render file: "/public/404"
    else
      @user = current_user
    end
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
    end
end
