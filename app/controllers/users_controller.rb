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
    binding.pry
    unless params[:id].is_a? Numeric
      render json: { 'error' => 'id it is not a numeric value' }, status: :unprocessable_entity
    else
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
  end

  def update
    unless params[:id].is_a? Numeric
      render json: { 'error' => 'id it is not a numeric value' }, status: :unprocessable_entity
    else
      user = User.find(params[:id])
      begin
        if user.update(user_params)
          render json: user, status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      rescue StandardError => e
        error_email_message(e)
      end
    end
  end

  def delete
    unless params[:id].is_a? Numeric
      render json: { 'error' => 'id it is not a numeric value' }, status: :unprocessable_entity
    else
      user = User.find(params[:id])
      begin
        if user.update(active: false)
          render json: user, status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      rescue StandardError => e
        error_email_message(e)
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :role_id)
  end

  def error_email_message(e)
    Rails.logger.error("Error while retrieving user with email #{e.message}")
  end

end
