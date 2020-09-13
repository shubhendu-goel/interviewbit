class AddEndToInterview < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :end, :date
  end
end
