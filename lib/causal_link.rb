class CausalLink < ActiveRecord::Base
  belongs_to :from, :polymorphic => true
  belongs_to :to, :polymorphic => true
  belongs_to :relationship

  named_scope :linked_from, lambda { |relationship, from|
    {
      :conditions => {
        :relationship_id => relationship.id,
        :from_type => from.class.name,
        :from_id => from.id
      }
    }
  }
  named_scope :linked_to, lambda { |relationship, to|
    {
      :conditions => {
        :relationship_id => relationship.id,
        :to_type => to.class.name,
        :to_id => to.id
      }
    }
  }

  def to_s
    "#{from}'s #{relationship.from_inflection} is #{to}"
  end
end
