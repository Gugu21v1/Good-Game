class UsersController < ApplicationController
  def show
  end

  def new
    @user = User.new
    raise
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_url, :email, :password)
  end
end
