class ItemsController < ApplicationController
  def update
    list = current_user.lists.find(params[:list_id])
    item = list.items.find(params[:id])

    if item.update(item_params)
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  def destroy
    list = current_user.lists.find(params[:list_id])
    item = list.items.find(params[:id])
    item.destroy!

    redirect_to lists_path, status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:name, :is_checked)
  end
end