class ItemsController < ApplicationController
  def create
    list = current_user.lists.find(params[:list_id])
    item = list.items.build(create_item_params)

    if item.save
      redirect_to lists_path(selected_list_id: list.id), status: :see_other
    else
      flash[:item_error_list_id] = list.id
      flash[:item_error] = item.errors.include?(:name) && item.name.blank? ? "項目を追加してください" : item.errors.full_messages.to_sentence
      redirect_to lists_path(selected_list_id: list.id), status: :see_other
    end
  end

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

  def create_item_params
    params.require(:item).permit(:name)
  end
end