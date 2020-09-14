class RemoveEndFromInterview < ActiveRecord::Migration[6.0]
  def change
    remove_column :interviews, :end, :date
  end
end
