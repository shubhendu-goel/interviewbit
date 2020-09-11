class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews do |t|
      t.string :title
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
