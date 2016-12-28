module Apis
  class RolesController < ApiController
    def add_roles
      response = Role.create(name: params[:name]) # if request_is_valid_post?
      if response.errors.any?
        render_403(response)
      else
        render json: {
          status: 200,
          message: "Role Created",
          created_role: response.name
        }
      end
    end

    def index
      private_method_call
      response = Role.display_roles
      if response.count == 0
        existing_role = "No Roles found"
        status = 404
      else
        status = 200
        existing_role = response
      end
      render_index(status, existing_role)
    end

    def update
      unless params.key?("id") && params.key?("name")
        render_update("id = #{params[:id]} or name = #{params[:name]} are missing")
        return
      end
      response = Role.update_resource(params)
      if response.nil?
        response = {
          status: 404,
          error_message: "Record not found"
        }
      end
      render_update(response)
    end

    private

    def render_index(status, existing_role)
      render json: {
        status: status,
        roles_available: existing_role
      }
    end

    def render_update(response)
      render json: {
        response: response
      }
    end
  end
end
