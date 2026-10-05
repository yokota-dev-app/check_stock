class ItemsController < ApplicationController
  def destroy
    list = current_user.lists.find(params[:list_id])
    item = list.items.find(params[:id])
    item.destroy!

    redirect_to lists_path, status: :see_other
  end
end