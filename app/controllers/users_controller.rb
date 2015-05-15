class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in, only: [:show]
  before_action :admin_required, only: [:index, :destroy, :make_admin]

  def index
    @users = User.all.includes(:notes)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Created #{@user.email}'s account!"
      login(@user)
      UserMailer.activation_email(@user).deliver
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = "Removed user #{user.email} from application."
    redirect_to users_url
  end

  def toggle_admin
    @user = User.find(params[:id])
    @user.toggle!(:admin)
    redirect_to users_url
  end

  # EDIT FUNCTIONALITY NOT IMPLEMENTED

  # def edit
  #   redirect_to new_session_url unless current_user.id == params([:id])
  #   @user = User.find(params[:id])
  # end

  # def update
  #   redirect_to new_session_url unless current_user.id == params([:id])
  #   @user = User.find(params[:id])
  # end

  def show
    @user = current_user
  end

  def activate
    user = User.find_by(activation_token: params[:activation_token])
    if user
      login(user)
      if user.activated
        flash[:warning] = "User already activated."
      else
        user.toggle!(:activated)
        flash[:success] = "Account activated!"
      end

      redirect_to user_url(user)
    else
      flash[:warning] = "Invalid activation token"

      redirect_to new_session_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
