module Api
	module V1
		class UsersController < ApplicationController
			
			def index
				u=User.all
			    render json: UserSerializer.new(u).serilaized_json
			end

			def show
				u=User.find(params[:id])
				render json: UserSerializer.new(u).serilaized_json
			end

			def create
			#params[:user][:name]=Strip(params[:user][:name])
				u=User.new(u_para)
				if u.save
					UserMailer.welcome_email(@u.id).deliver_later
					u=User.all
			    	render json: UserSerializer.new(u).serilaized_json
				else
			    	render json: {error: user.errors.messages} , status: 422
				end
			end
			def update
				@u = User.find(params[:id])
				if @u.update(u_para)
			    	redirect_to users_path
				else
			  		render 'edit'
				end
			end

			def destroy
				u = User.find(params[:id])
				u.destroy
				u=User.all
			    render json: UserSerializer.new(u).serilaized_json
			end
			private 
			def u_para
			    params.require(:user).permit(:name,:email,:resume)
			end
		end
	end
end	