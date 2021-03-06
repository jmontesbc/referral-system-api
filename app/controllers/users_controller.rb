class UsersController < ApplicationController
  def index
    render json: User.where(active: true)
  end

  def create
    user = User.new(user_params)
    # TODO: Verify if user has permissions to set role of the new user
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
    user = User.find(user_params[:email])
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
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
