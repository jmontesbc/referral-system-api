class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.create(name: params[:name])

    if user.save
      #  TODO response success creating a new action to the api
      render json: user, status: :created
    else
      render json: user.errors, status: :unproccessable_entity
    end
  end

  def show
    render json: User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(params)
      render json: user, status: :updated
    else
      render json: user.errors, status: :unproccessable_entity
    end

  end

  def destroy
  end

end
