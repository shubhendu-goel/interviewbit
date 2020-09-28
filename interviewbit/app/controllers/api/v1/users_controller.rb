module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session
      def index
        users=User.all
        users=users.sort_by{|u| u.interviews.count}.reverse
        render json: UserSerializer.new(users).serialized_json
      end 

      def show
        user=User.find(params[:id])
        render json: UserSerializer.new(user).serialized_json
      end

      def create
        user=User.new(u_para)
        if user.save
          UserMailer.welcome_email(@u.id).deliver_later
          render json: UserSerializer.new(user).serialized_json
        else
            render json: {error: user.errors.messages}, status: 422
        end
      end
      def update
        user = User.find(params[:id])
        if user.update(u_para)
          UserMailer.welcome_email(@u.id).deliver_later
          render json: UserSerializer.new(user).serialized_json
        else
            render json: {error: user.errors.messages}, status: 422
        end
      end

      def destroy
        user = User.find(params[:id])
        if user.destroy
          head :no_content
        else
            render json: {error: user.errors.messages}, status: 422
        end
      end
      private 
        def u_para
            params.require(:user).permit(:name,:email,:resume)
        end
    end
  end
end