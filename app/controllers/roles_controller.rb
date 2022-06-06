class RolesController < ApplicationController
  def index
    render json: Role.all
  end

  def create
    # TODO: Implement validation to ensure only admin users can add new roles
    begin
      role = Role.new(role_params)
      if role.save
        render json: role, status: :created
      else
        render json: role.errors, status: :unprocessable_entity
      end
    rescue StandardError => e
      Rails.logger.error("Error while creating new role: #{e.message}", e)
    end
  end
end

private

def role_params
  params.require(:role).permit(:name)
end
