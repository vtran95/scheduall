class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params.require(:user).permit(:name,:interests))
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.interests == nil
      @user.interests = "Nothing, I'm boring.."
    end
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have susccessfully signed up!"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
