class TemplateListsController < ApplicationController
  def index
    @template_lists = current_user.template_lists.includes(:template_items)
    @selected_template_list_id = @template_lists.find_by(id: params[:selected_template_list_id])&.id || @template_lists.first&.id
    @template_list = current_user.template_lists.build
    @template_list.template_items.build
  end

  def new
    @template_list = TemplateList.new
    @template_list.template_items.build
  end

  def create
    @template_list = current_user.template_lists.build(template_list_params)
    if @template_list.save
      redirect_to template_lists_path
    else
      @template_list.template_items.build if @template_list.template_items.empty?
      render :new, status: :unprocessable_entity
    end
  end

  def update
    template_list = current_user.template_lists.find(params[:id])

    if template_list.update(update_template_list_params)
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  def destroy
    template_list = current_user.template_lists.find(params[:id])
    template_list.destroy!
    redirect_to template_lists_path, status: :see_other
  end

  private

  def template_list_params
    params.require(:template_list).permit(:title, :memo, template_items_attributes: [:name])
  end

  def update_template_list_params
    params.require(:template_list).permit(:title, :memo)
  end
end
