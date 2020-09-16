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
  def new
    @i=Interview.new
  end
  def create
    #params[:interview][:title]=strip(params[:interview][:title])
    params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
    params[:interview][:finish]=params[:interview][:finish]+" "+params[:interview][:finish_time]
    params[:interview][:users].shift
    @users=User.find(params[:interview][:users])
    @i=Interview.new(i_para)
    @i.users = @users
    if @i.save(context: :create)
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

  def update
    params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
    params[:interview][:finish]=params[:interview][:finish]+" "+params[:interview][:finish_time]
    params[:interview][:users].shift
    @i = Interview.find(params[:id])
    if params[:interview][:users].size < 2
      flash.now[:notice] = "Select atleast 2 Users."
      render 'edit' 
    else
      flag=false
      cur_usr=Array.new
        @i.users.each do |cu|
          cur_usr.append(cu.id)
      end
      query = "delete from interviews_users where interview_id = "+String(@i.id)
      ActiveRecord::Base.connection.execute(query)  
      cnt=1
      params[:interview][:users].each do |sel_usr|
        if check(sel_usr,params[:interview][:start],params[:interview][:finish]) ==false
          uid=sel_usr
          flash.now[cnt]= String(User.find(uid).name)+" is unavailable in this time slot"
          cnt=cnt+1
          flag=true
        end
      end
      if flag==true
        users=User.find(cur_usr)
        @i.users << users
        render 'edit'
      else
        users=User.find(params[:interview][:users])
        id=@i.id
        if @i.update(i_para)
          @i.users << users
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
          query = "delete from interviews_users where interview_id = "+String(id)
          ActiveRecord::Base.connection.execute(query)
          users=User.find(cur_usr)
          @i.users << users
          render 'edit'
        end
      end
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
        params.require(:interview).permit(:title,:start,:finish)
    end 
    def check(uid,start,finish)
      start=start + " UTC"
      finish=finish + " UTC"
      usr=User.find(uid)
      ans = true
      inter = Interview.joins(:users).where("interviews_users.user_id = ?", uid )
        inter.each do |i|
          st=i.start
          fs=i.finish
          if ((st>=start && st<=finish) || (fs>=start && fs<=finish) || (st<=start && fs>=finish)) ==true
            ans = false 
          end
        end
        return ans
    end
end
