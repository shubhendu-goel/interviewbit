class RemoveEndTimeFromInterview < ActiveRecord::Migration[6.0]
  def change
    remove_column :interviews, :end_time, :time
  end
end
