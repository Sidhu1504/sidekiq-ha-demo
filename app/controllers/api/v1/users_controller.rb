module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session

      def index
        users = User.all
        render json: users
      end

      def show
        user = User.find(params[:id])
        render json: user
      end

      def search
        q = params[:q]
        users = User.where("name ILIKE :q OR email ILIKE :q OR department ILIKE :q", q: "%#{q}%")
        render json: users
      end
    end
  end
end

