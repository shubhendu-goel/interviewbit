class InterviewsController < ApplicationController
  def index
    @i=Interview.all
    @i=@i.sort_by{|i| i.start}.reverse
    @i=@i.sort_by{|i| i.end}.reverse
    @u=User.all
  end
  def show
  end
  def create
    params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
    params[:interview][:end]=params[:interview][:end]+" "+params[:interview][:end_time]
    @i=Interview.new(i_para)
    if @i.save
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
        params.require(:interview).permit(:title,:start,:end)
    end 
end
