# frozen_string_literal: true

module Api
  module V1
    class WebsitesController < Api::ApiController
      def index
        # TODO: add pagination. Not a requirement for the task
        websites = Website.top(100)
        render json: websites, each_serializer: WebsiteSerializer
      end

      def show
        website = Website.find_by_shortened_id(params[:id])
        if website.present?
          website.increase_access_count!
          render json: website, serializer: WebsiteSerializer
        else
          render json: {}, status: :not_found
        end
      end

      def create
        website = Website.find_by(url: params.dig(:website, :url))
        render(json: { id: website.shortened_id }) && return if website.present?
        website = Website.new(website_params)
        if website.save
          render json: { id: website.shortened_id }
        else
          render json: { errors: website.errors }, status: :bad_request
        end
      end

      private

      def website_params
        params.require(:website).permit(:url)
      end
    end
  end
end
