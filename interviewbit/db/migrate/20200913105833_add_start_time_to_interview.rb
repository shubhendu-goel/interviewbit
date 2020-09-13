class AddStartTimeToInterview < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :start_time, :time
  end
end
