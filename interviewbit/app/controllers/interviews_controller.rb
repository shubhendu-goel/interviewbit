class InterviewsController < ApplicationController
  def index
    @i=Interview.all
    @i=@i.sort_by{|i| i.start}.reverse
    @i=@i.sort_by{|i| i.finish}.reverse
  end
  def show
    @i=Interview.find(params[:id])
    @u=User.joins(:interviews).where("interviews_users.interview_id = ?", params[:id]).distinct
  end
  def edit
    @i = Interview.find(params[:id])
  end
  def create
    #params[:interview][:title]=strip(params[:interview][:title])
    params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
    params[:interview][:finish]=params[:interview][:finish]+" "+params[:interview][:finish_time]
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
    params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
    params[:interview][:finish]=params[:interview][:finish]+" "+params[:interview][:finish_time]
    params[:interview][:users].shift
    users=User.find(params[:interview][:users])
    @i = Interview.find(params[:id])
    id=@i.id
    query = "delete from interviews_users where interview_id = "+String(id)
    ActiveRecord::Base.connection.execute(query)
    @i.users << users
    if @i.update(i_para)
      arg =Array.new
      arg.append(@i.title)
      arg.append(@i.start)
      arg.append(@i.finish)
      users.each do |u|
        arg.append(u.email)
      end
      UserMailer.with(arg: arg).update_interview_email.deliver_later
      redirect_to interviews_path
    else
      render 'edit'
    end
  end

  def destroy
    @i = Interview.find(params[:id])
    @u=User.joins(:interviews).where("interviews_users.interview_id = ?", @i.id)
    arg = Array.new
    arg.append(@i.title)
    arg.append(@i.start)
    arg.append(@i.finish)
    @u.each do |u|
      arg.append(u.email)
    end
    @i.destroy
    UserMailer.with(arg: arg).destroy_interview_email.deliver_later
    redirect_to interviews_path
  end
  private 
    def i_para
        params.require(:interview).permit(:title,:start,:users,:finish)
    end 
end
