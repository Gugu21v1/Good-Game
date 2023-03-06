class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[show index]

  def index
    @products = policy_scope(Product)
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(@product.user_id)
    authorize @product
   end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @user = User.find(current_user.id)
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    authorize @product
    if @product.save
      redirect_to product_path(@product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])
    authorize @product
    @product.update(product_params)
  end

  def destroy
    @product = Product.find(params[:id])
    authorize @product
    @product.destroy

    redirect_to user_path(@product.user_id), status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :details, :description, :price, :console, :user_id, product_url: [])
  end
end
