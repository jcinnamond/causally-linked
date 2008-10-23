class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.string :from_inflection
      t.string :to_inflection

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
