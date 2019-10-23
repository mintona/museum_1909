class Museum
  attr_reader :name, :exhibits, :patrons

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
  end

  def add_exhibit(exhibit)
    @exhibits << exhibit
  end

  def recommend_exhibits(patron)
    recommendations = []
    patron.interests.each do |interest|
      recommendations << @exhibits.find { |exhibit| exhibit.name == interest }
    end
    recommendations
  end

  def admit(patron)
    @patrons << patron
  end

  def patrons_by_exhibit_interest
    @exhibits.reduce({}) do |hash, exhibit|

      hash[exhibit] = @patrons.find_all { |patron| patron.interests.include?(exhibit.name)}
      hash
    end
  end

end
