class ListsController < ApplicationController
  def index
    @lists = current_user.lists
      .includes(:items)
      .order(items_updated_at: :desc)

    @selected_list_id =
      @lists.find_by(id: params[:selected_list_id])&.id ||
      @lists.first&.id

    @list = current_user.lists.build
    @list.items.build
    load_template_lists
  end

  def new
    @list = List.new
    @list.items.build
    load_template_lists
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to lists_path
    else
      @list.items.build if @list.items.empty?
      load_template_lists
      render :new, status: :unprocessable_entity
    end
  end

  def update
    list = current_user.lists.find(params[:id])

    if list.update(update_params)
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  def make_template
    list = current_user.lists.includes(:items).find(params[:id])
    template_list = current_user.template_lists.build(
      title: list.title,
      memo: list.memo,
      category: list.category
    )

    list.items.each do |item|
      template_list.template_items.build(name: item.name)
    end

    if template_list.save
      redirect_to template_lists_path, status: :see_other
    else
      redirect_to lists_path, alert: template_list.errors.full_messages.to_sentence,
                              status: :see_other
    end
  end

  def destroy
    list = current_user.lists.find(params[:id])
    list.destroy!
    redirect_to lists_path, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:title, :memo, :is_completed, items_attributes: [:name])
  end

  def completion_params
    params.require(:list).permit(:is_completed)
  end

  def update_params
    params.require(:list).permit(:title, :memo, :is_completed)
  end

  def load_template_lists
    @template_lists = current_user.template_lists.includes(:template_items).order(:title)
  end
end
