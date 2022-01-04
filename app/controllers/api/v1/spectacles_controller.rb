module Api
  module V1
    class SpectaclesController < Api::BaseController
      include AccessApiAuth
      before_action :load_spectacle, only: %i[destroy]

      # GET /api/spectacles
      def index
        render json: Spectacle.all, each_serializer: SpectacleSerializer
      end

      # POST /api/spectacles
      def create
        return render_error({ detail: 'bad request' }, 400) unless params[:name].present? &&
                                                                   params[:date_from].present? &&
                                                                   params[:date_to].present?
        begin
          from = Date.parse(params[:date_from])
          to = Date.parse(params[:date_to])
        rescue StandardError
          return render_error({ detail: 'bad date format' }, 400)
        end

        spectacle = Spectacle.create(name: params[:name], period: from..to)
        return render_error({ detail: spectacle.errors.full_messages.join(',') }, 400) if spectacle.errors.present?
        render json: spectacle
      end

      # DELETE /api/spectacles/:id
      def destroy
        @spectacle.destroy
        render json: 'Was successfully destroyed.'
      end

      private

      def load_spectacle
        @spectacle = Spectacle.find params[:id] if params[:id]
        return render_error({ detail: 'not_found' }, :not_found) unless @spectacle
      end
    end
  end
end
