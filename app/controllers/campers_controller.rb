class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        campers = Camper.all
        render json: campers, status: :ok
    end

    def show
        campers = Camper.find(params[:id])
        render json: campers, status: :ok
    end

    def create
        new_camper = Camper.create!(camper_params)
        render json: new_camper, status: :created
    end

    private

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_unprocessable_entity_response invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def camper_params
        params.permit(:name, :age)
    end

end
