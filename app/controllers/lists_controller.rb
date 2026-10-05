class ListsController < ApplicationController
  def index
    @lists = List.includes(:user)
  end
end
