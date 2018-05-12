class Api::V1::ItemsController < Api::V1::BaseController
  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  private

  def item_params
    params.require(:item).permit(:name, :content)
  end

  def render_error
    render json: { errors: @item.errors.full_messages },
      status: :unprocessable_entity
  end

end
