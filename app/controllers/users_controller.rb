class UsersController < ApplicationController
  def index
    render json: User.where(active: true)
  end

  def create
    # TODO: Verify if user has permissions to set role of the new user
    begin
      user = User.new(user_params)
      unless role_not_allowed
        if user.save
          render json: user, status: :created
        else
          render json: {
            'message': 'Error while creating a new user',
            'errors': user.errors
          }, status: :unprocessable_entity
        end
      end
    rescue StandardError => e
      Rails.logger.error("Error while creating a new user: #{e.message}")
      render json: {
        'error': 'Error while creating a new user',
        'errors': e.message
      }, status: :internal_server_error
    end
  end

  def show
    unless invalid_params_error
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
    unless invalid_params_error || role_not_allowed
      user = User.find(params[:id])

      if user.update(user_params)
        render json: user, status: :ok
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end

  def destroy
    begin
      unless invalid_params_error
        user = User.find(params[:id])
        if user.update(active: false)
          render json: {
            'message': 'User successfully deleted.'
          }, status: :ok
        else
          render json: user.errors, status: :unproccessable_entity
        end
      end
    rescue StandardError => e
      Rails.logger.error("Error while deleting user: #{e.message}")
      render json: {
        'message': 'Error while deleting user',
        'errors': e.message
      }, status: :internal_server_error
    end
  end

  private

  def user_params
    params.permit([:name, :email, :role_id])
  end

  def invalid_params_error
    unless params[:id].match? /\A\d+\z/
      message = 'ID is not a numeric value'
      Rails.logger.error(message)
      render json: {
        'message': message
      }, status: :unprocessable_entity
    end
  end

  def role_not_allowed
    render json: {
        'message': 'Error while creating a new user',
        'errors': 'Creation of new admin users is not allowed'
      } if params[:role_id].to_i == 1
  end
end
