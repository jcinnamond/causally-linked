# CausallyLinked
module CausallyLinked
  def causally_linked
    include CausalLinks
  end
end

module CausalLinks
  def method_missing(sym, *args, &block)
    relationship_name = sym.to_s.singularize
    relationships = find_relationships(relationship_name)
    if relationships.empty?
      super
    else
      links = find_links(relationship_name, relationships)
      if relationship_name == sym.to_s
        return links.first
      else
        return links
      end
    end
  end

  def find_relationships (name)
    Relationship.find(
      :all,
      :conditions => [
        'from_inflection = ? OR to_inflection = ?',
        name, name
      ]
    )
  end

  def find_links (name, relationships)
    linked = []
    relationships.each do |relationship|
      if relationship.to_inflection == name
        links = CausalLink.linked_to(relationship, self)
        linked += links.map(&:from)
      end

      if relationship.from_inflection == name
        links = CausalLink.linked_from(relationship, self)
        linked += links.map(&:to)
      end
    end

    linked
  end
end
