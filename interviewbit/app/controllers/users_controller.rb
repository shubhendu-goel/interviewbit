class UsersController < ApplicationController
  def index
    @u=User.all
  end

  def show
    @u=User.find(params[:id])
  end

  def create
    #params[:user][:name]=Strip(params[:user][:name])
    @u=User.new(u_para)
    if @u.save
      UserMailer.with(u: @u).welcome_email.deliver_later
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
    @u = User.find(params[:id])
    if @u.update(u_para)
        redirect_to users_path
    else
      render 'edit'
    end

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
