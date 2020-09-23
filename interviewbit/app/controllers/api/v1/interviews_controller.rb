module Api
	module V1
		class InterviewsController < ApplicationController
			#respond_to :json
			def index
				i=Interview.all
			    i=i.sort_by{|i| i.start}.reverse
			    i=i.sort_by{|i| i.finish}.reverse			
			#	respond_to do |format|
    		#		format.json { render json: InterviewSerializer.new(i).serilaized_json }
  			#	end
				render json: InterviewSerializer.new(i).serialized_json
			end
			def show
		    i=Interview.find(params[:id])
    		render json: InterviewSerializer.new(i , options).serialized_json 
			end
			def create
				params[:interview][:start]=params[:interview][:start]+" "+params[:interview][:start_time]
			    params[:interview][:finish]=params[:interview][:finish]+" "+params[:interview][:finish_time]
			    params[:interview][:users].shift
			    users=User.find(params[:interview][:users])
			    @i=Interview.new(i_para)
			    @i.users = users
			    if @i.save(context: :create)
					@u=User.joins(:interviews).where("interviews_users.interview_id = ?", @i.id)
					arg = Array.new
					arg.append(@i.id)
					@u.each do |u|
					arg.append(u.id)
					end
					UserMailer.new_interview_email(@i.id).deliver_later
					cur_tim=Time.now.year*(60*24*365)+ (Time.now.month)*(60*24*30) + (Time.now.day)*(60*24) + (Time.now.hour)*(24) +(Time.now.strftime("%M").to_i)
					str_tim=@i.start.year*(60*24*365)+ (@i.start.month)*(60*24*30) + (@i.start.day)*(60*24) + (@i.start.hour)*(24) +(@i.start.strftime("%M").to_i)
					elapsed_minutes=str_tim-cur_tim- 720
					if elapsed_minutes < 0 
					elapsed_minutes = 0
					end
					job=UserMailer.reminder_email(@i.id).deliver_later(wait_until: elapsed_minutes.minutes.from_now)
					jid=job.provider_job_id
					insert_job(jid,@i.id)
					i=Interview.all
					i=i.sort_by{|i| i.start}.reverse
					i=i.sort_by{|i| i.finish}.reverse			
					render json: InterviewSerializer.new(i).serialized_json
			    else
			        render json: { error: @i.errors.messages }, status: 422
			    end
			end
			def update 
				
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
			    delete_job(@i.id)
			    @i.destroy
			    UserMailer.with(arg: arg).destroy_interview_email.deliver_later
			    i=Interview.all
				i=i.sort_by{|i| i.start}.reverse
				i=i.sort_by{|i| i.finish}.reverse			
				render json: InterviewSerializer.new(i).serialized_json
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
			    def insert_job(jid,iid)
			      query = "insert into interviews_jobs values('" + jid + "'," + String(iid) +")"
			      ActiveRecord::Base.connection.execute(query)
			    end
			    def delete_job(iid)
			      query = "select * from interviews_jobs where interview_id =" + String(iid)
			      rows = ActiveRecord::Base.connection.execute(query)
			      rows.each do |r|
			        jid=r[0]
			        puts jid
			        job = Sidekiq::ScheduledSet.new.find_job(jid)
			        job.delete
			      end
			      query = "delete from interviews_jobs where interview_id =" + String(iid)
			      ActiveRecord::Base.connection.execute(query)
			    end
			    def options
			    	@options ||= { include: %i[users] }
			    end
		end
	end
end	