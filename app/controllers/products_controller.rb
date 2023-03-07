class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[show index]

  def index
    @products = policy_scope(Product.where(console: params[:type]))
    @all_products = policy_scope(Product)
    if params[:query]
      @lista = []
      pesquisa_separada = params[:query].upcase.split
      pesquisa_separada.each do |palavra|
        p palavra
        Product.all.each do |produto|
          if produto.name.upcase.include?(palavra) ||
             produto.details.upcase.include?(palavra) ||
             produto.console.upcase.include?(palavra)
            if @lista.include?(produto) == false
              @lista << produto
            end
          end
        end
      end
    end
  end

  def show
    @product = Product.find(params[:id])
    @user = User.find(@product.users_id)
    authorize @product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def create
    @user = User.find(current_user.id)
    @product = Product.new(product_params)
    @product.users_id = current_user.id
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

    redirect_to user_path(@product.users_id), status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:name, :details, :description, :price, :console, :users_id, product_url: [])
  end
end
