class CreateContestantOutings < ActiveRecord::Migration[5.2]
  def change
    create_table :contestant_outings do |t|
      t.references :outing
      t.references :contestant
    end
  end
end
