class UsersController < ApplicationController
  def index
    render json: User.where(active: true)
  end

  def create
    user = User.new(user_params)
    begin
      binding.pry
      if user.save
        render json: user, status: :created
      else
        render json: user.errors, status: :unproccessable_entity
      end
    rescue StandardError => e
      Rails.logger.error("Error message: #{e.message}", e)
    end
  end

  def show
    render json: User.where(id: user_params[:email]).and(active: true)
  end

  def update
    user = User.find(user_params[:email])
    if user.update(user_params)
      render json: user, status: :updated
    else
      render json: user.errors, status: :unproccessable_entity
    end

  end

  def delete
    user = User.find(user_params[:email])
    if user.update(active: false)
      render json: user, status: :deleted
    else
      render json: user.errors, status: :unproccessable_entity
    end

  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :role_id)
  end

end
