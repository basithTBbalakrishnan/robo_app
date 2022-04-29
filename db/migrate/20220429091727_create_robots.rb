class CreateRobots < ActiveRecord::Migration[6.0]
  def change
    create_table :robots do |t|
      t.string :commonds
      t.string :x_position
      t.string :y_position
      t.string :facing

      t.timestamps
    end
  end
end
