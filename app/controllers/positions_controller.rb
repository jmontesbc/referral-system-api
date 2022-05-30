class PositionsController < ApplicationController
  def index
    render json: Position.all
  end

  def create
    position = Position.create(name: params[:name])

    if position.save
      #  TODO response success creating a new action to the api
      render json: position, status: :created
    else
      render json: position.errors, status: :unproccessable_entity
    end
  end

  def show
    render json: Position.find(params[:id])
  end

  def update
    position = Position.find(params[:id])
    if position.update(params)
      render json: position, status: :updated
    else
      render json: position.errors, status: :unproccessable_entity
    end

  end

  def destroy
  end
end
