class InterviewsController < ApplicationController
  def index
    @i=Interview.all
    @i=@i.sort_by{|i| i.start}.reverse
    @i=@i.sort_by{|i| i.end}.reverse
  end
  def show
    @i=Interview.find(params[:id])
    @u=User.joins(:interviews).where("interviews_users.interview_id = ?", params[:id])
    puts @u
    puts @i
  end
  def edit
  end
  def create
    #params[:interview][:title]=strip(params[:interview][:title])
    params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
    params[:interview][:end]=params[:interview][:end]+" "+params[:interview][:end_time]
    puts params
    puts "Hello World"
    puts params[:interview][:users]
    params[:interview][:users].shift
    #puts params[:interview][:users][1]
    @users=User.find(params[:interview][:users])
    puts @users
    @i=Interview.new(i_para)
    @i.users << @users
    if @i.save
      puts "Hello Wrld"
      redirect_to '/'
    else
        render 'new'
    end
  end

  def new
    @i=Interview.new
  end

  def update
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
