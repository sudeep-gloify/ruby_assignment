class CreateLibraries < ActiveRecord::Migration[6.1]
  def change
    create_table :libraries do |t|
      t.string :name
      t.time :opening_time
      t.time :closing_time

      t.timestamps
    end
  end
end
