class InterviewsController < ApplicationController
  def index
    @i=Interview.all
    @i=@i.sort_by{|i| i.start}.reverse
    @i=@i.sort_by{|i| i.end}.reverse
  end
  def show
    @i=Interview.find(params[:id])
    @u=User.joins(:interviews).where("interviews_users.interview_id = ?", params[:id])
  end
  def edit
    @i = Interview.find(params[:id])
  end
  def create
    #params[:interview][:title]=strip(params[:interview][:title])
    params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
    params[:interview][:end]=params[:interview][:end]+" "+params[:interview][:end_time]
    params[:interview][:users].shift
    @users=User.find(params[:interview][:users])
    @i=Interview.new(i_para)
    @i.users << @users
    if @i.save
      @u=User.joins(:interviews).where("interviews_users.interview_id = ?", @i.id)
      arg = Array.new
      arg.append(@i.id)
      @u.each do |u|
        arg.append(u.id)
      end
      puts arg
      UserMailer.with(arg: arg).new_interview_email.deliver_later
      redirect_to '/'
    else
        render 'new'
    end
  end

  def new
    @i=Interview.new
  end

  def update
    @i = Interview.find(params[:id])
    if @i.update(i_para)
        redirect_to interviews_path
    else
      render 'edit'
    end
  end

  def destroy
    @i = Interview.find(params[:id])
    @i.destroy
    redirect_to interviews_path
  end
  private 
    def i_para
        params.require(:interview).permit(:title,:start,:users,:end)
    end 
end
