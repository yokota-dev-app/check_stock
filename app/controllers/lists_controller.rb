class ListsController < ApplicationController
  def index
    @lists = current_user.lists
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    list = current_user.lists.find(params[:id])
    list.destroy!
    redirect_to lists_path, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:title, :memo)
  end
end
