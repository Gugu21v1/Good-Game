class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @user = User.find(params[:user_id])
    @product = Product.new(product_params)
    @product.user = User.find(params[:user_id])
    if @product.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
  end

  private

  def user_params
    params.require(:product).permit(:name, :product_url, :description, :price)
  end
end
