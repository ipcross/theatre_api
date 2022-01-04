module Api
  class BaseController < ActionController::Base
    protect_from_forgery with: :null_session
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    protected

    def render_error(errors, status)
      render json: { errors: errors }, status: status
    end

    def record_not_found
      render_error({ detail: 'not_found' }, :not_found)
    end
  end
end
