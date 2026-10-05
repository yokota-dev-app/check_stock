class TemplateItemsController < ApplicationController
  def create
    template_list = current_user.template_lists.find(params[:template_list_id])
    template_item = template_list.template_items.build(create_template_item_params)

    if template_item.save
      redirect_to template_lists_path, status: :see_other
    else
      @template_lists = current_user.template_lists.includes(:template_items)
      @new_template_item_template_list_id = template_list.id
      @new_template_item_name = template_item.name
      @new_template_item_errors = template_item.errors.full_messages
      render "template_lists/index", status: :unprocessable_entity
    end
  end

  def update
    template_list = current_user.template_lists.find(params[:template_list_id])
    template_item = template_list.template_items.find(params[:id])

    if template_item.update(template_item_params)
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  def destroy
    template_list = current_user.template_lists.find(params[:template_list_id])
    template_item = template_list.template_items.find(params[:id])
    template_item.destroy!

    redirect_to template_lists_path, status: :see_other
  end

  private

  def template_item_params
    params.require(:template_item).permit(:name, :is_checked)
  end

  def create_template_item_params
    params.require(:template_item).permit(:name)
  end
end
