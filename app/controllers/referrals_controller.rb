class ReferralsController < ApplicationController

  def index
    render json: Referral.all
  end

  def create
    begin
      referral = Referral.new(referral_params)
      unless role_not_allowed
        if referral.save
          render json: referral, status: :created
        else
          render json: {
            'message': 'Error while creating a new referral',
            'errors': referral.errors
          }, status: :unprocessable_entity
        end
      end
    rescue StandardError => e
      Rails.logger.error("Error while creating a new referral: #{e.message}")
      render json: {
        'message': 'Error while creating a new record',
        'errors': [e.message]
      }, status: :internal_server_error
    end
  end

  def show
    begin
      unless invalid_params_error
        referral = Referral.find(params[:id])
        if referral.active
          render json: referral, status: :ok, except: :active
        else
          render json: referral.errors, status: :not_found
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        'message': 'Record not found',
        'errors': [e.message]
      }, status: :not_found
    rescue StandardError => e
      Rails.logger.error("Error while retrieving referral #{e.message}")
      render json: {
        'message': 'Error while retrieving record',
        'errors': [e.message]
      }, status: :internal_server_error
    end
  end

  def update
    begin
      unless invalid_params_error || role_not_allowed
        referral = Referral.find(params[:id])

        if referral.update(referral_params)
          render json: referral, except: :active, status: :ok
        else
          render json: referral.errors, status: :unprocessable_entity
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        'message': 'Record not found',
        'errors': [e.message]
      }, status: :not_found
    rescue StandardError => e
      Rails.logger.error("Error while retrieving referral #{e.message}")
      render json: {
        'message': 'Error while retrieving record',
        'errors': [e.message]
      }, status: :internal_server_error
    end
  end

  def destroy
    begin
      unless invalid_params_error
        referral = Referral.find(params[:id])
        if referral.update(active: false)
          render json: {
            'message': 'Referral successfully deleted.'
          }, status: :ok
        else
          render json: referral.errors, status: :unproccessable_entity
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: {
        'message': 'Record not found',
        'errors': [e.message]
      }, status: :not_found
    rescue StandardError => e
      Rails.logger.error("Error while deleting referral: #{e.message}")
      render json: {
        'message': 'Error while deleting referral',
        'errors': [e.message]
      }, status: :internal_server_error
    end
  end

  private

  def referral_params
    params.permit([:referred_by, :full_name, :phone_number, :email, :linkedin_url, :cv_url, :tech_stack, :ta_recruiter, :status, :comments])
  end

  def invalid_params_error
    unless params[:id].match? /\A\d+\z/
      message = 'ID is not a numeric value'
      Rails.logger.error(message)
      render json: {
        'message': 'Invalid parameter',
        'errors': [message]
      }, status: :unprocessable_entity
    end
  end
end
