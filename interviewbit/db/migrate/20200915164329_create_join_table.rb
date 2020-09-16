class CreateJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :interviews do |t|
       t.index [:user_id, :interview_id]
       t.index [:interview_id, :user_id]
    end
  end
end
