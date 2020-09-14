class UsersController < ApplicationController
  def index
    @u=User.all
  end

  def show
  end

  def create
    @u=User.new(u_para)
    if @u.save
      redirect_to users_path
    else
        render 'new'
    end
  end

  def new
    @u=User.new
  end
  def edit
    @u = User.find(params[:id])
  end
  def update
  end

  def destroy
    @u = User.find(params[:id])
    @u.destroy
    redirect_to users_path
  end
  private 
    def u_para
        params.require(:user).permit(:name,:email,:resume)
    end
  
end
