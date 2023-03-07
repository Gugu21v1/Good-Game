class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @products = Product.where(users_id: @user.id)
    authorize @user
    authorize @products
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new(user_params)
    @restaurant.user = current_user
    authorize @user
    if @user.save
      redirect_to user_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @user
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    @user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_url, :email, :password)
  end
end
