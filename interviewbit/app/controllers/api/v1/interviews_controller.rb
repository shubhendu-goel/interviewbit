module Api
  module V1  
    class InterviewsController < ApplicationController
      def index

        interviews=Interview.all
        interviews=interviews.sort_by{|i| i.start}.reverse
        interviews=interviews.sort_by{|i| i.finish}.reverse
        render json: InterviewSerializer.new(interviews).serialized_json
      end

      def show
        interview=Interview.find(params[:id])
        render json: InterviewSerializer.new(interview).serialized_json
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
    end
  end
end