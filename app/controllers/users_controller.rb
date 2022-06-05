class UsersController < ApplicationController
  def index
    render json: User.where(active: true)
  end

  def create
    user = User.create(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unproccessable_entity
    end
  end

  def show
    render json: User.where(id: user_params[:id]).and(active: true)
  end

  def update
    user = User.find(user_params[:id])
    if user.update(user_params)
      render json: user, status: :updated
    else
      render json: user.errors, status: :unproccessable_entity
    end

  end

  def delete
    user = User.find(user_params[:id])
    if user.update(active: false)
      render json: user, status: :deleted
    else
      render json: user.errors, status: :unproccessable_entity
    end

  end

  private

  def user_params
    params.require(:user).permit(:id, :name, :active)
  end

end
