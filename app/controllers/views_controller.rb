class ViewsController < ApplicationController
  def index
    render json: View.all
  end
end
