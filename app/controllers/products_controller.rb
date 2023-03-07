class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %I[show index]

  def index
    @products = policy_scope(Product.where(console: params[:type]))
    @all_products = policy_scope(Product)
    if params[:query]
      pesquisa_separada = params[:query].split
      pesquisa_separada_tamanho = pesquisa_separada.size
      p pesquisa_separada.first
      case pesquisa_separada_tamanho
      when 1
        @searched_products = policy_scope(Product.where("products.name ILIKE :query
          OR products.details ILIKE :query OR products.console ILIKE :query", query: "%#{pesquisa_separada.first}%"))
      when 2
        @searched_products = policy_scope(Product.where("products.name ILIKE :query1
          OR products.details ILIKE :query1 OR OR products.console ILIKE :query1 products.name ILIKE :query2 OR products.console ILIKE :query2
          OR products.details ILIKE :query2", query1: "%#{pesquisa_separada[0]}%", query2: "%#{pesquisa_separada[1]}%"))
      when 3
        @searched_products = policy_scope(Product.where("products.name ILIKE :query1
          OR products.details ILIKE :query1 OR products.console ILIKE :query1 OR products.name ILIKE :query2 OR products.console ILIKE :query2
          OR products.details ILIKE :query2 OR products.name ILIKE :query3 OR products.console ILIKE :query3
          OR products.details ILIKE :query3", query1: "%#{pesquisa_separada[0]}%", query2: "%#{pesquisa_separada[1]}%", query3: "%#{pesquisa_separada[2]}%"))
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
