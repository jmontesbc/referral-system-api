class UsersController < ApplicationController
  def index
    render json: User.where(active: true)
  end

  def create
    user = User.new(user_params)
    begin
      if user.save
        render json: user, status: :created
      else
        render json: user.errors, status: :unprocessable_entity
      end
    rescue StandardError => e
      Rails.logger.error("Error message: #{e.message}", e)
    end
  end

  def show
    user = User.find(params[:id])
    begin
      if user.active
        render json: user, status: :ok
      else
        render json: user.errors, status: :not_found
      end
    rescue StandardError => e
      Rails.logger.error("Error while retrieving user #{e.message}")
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.update(active: false)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unproccessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :role_id, :active)
  end

end
