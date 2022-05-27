class ActionsController < ApplicationController
  def index
    render json: Action.all
  end
end
