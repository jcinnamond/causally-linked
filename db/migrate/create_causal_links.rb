class CreateCausalLinks < ActiveRecord::Migration
  def self.up
    create_table :causal_links do |t|
      t.string :from_type
      t.integer :from_id
      t.string :to_type
      t.integer :to_id
      t.integer :relationship_id

      t.timestamps
    end
  end

  def self.down
    drop_table :causal_links
  end
end
