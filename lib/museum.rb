class Museum
  attr_reader :name, :exhibits, :patrons, :revenue

  def initialize(name)
    @name = name
    @exhibits = []
    @patrons = []
    @revenue = 0
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
    require "pry"; binding.pry
    recs = recommend_exhibits(patron)
      #brainstorming here but looks like will need helper methods to check total of the exhibits they are interested in and see how it relates to their spending money... otherwise it looks like maybe nested if statements.
    if recs.any? { |exhibit| exhibit.cost < patron.spending_money }
      #so if any of the recs are less than the amount of the patron spending money then we can check
    elsif recs.all? { |exhibit| exhibit.cost < patron.spending_money }
      #if all of the recs are less than the spending money...then we need to see if they can go to one or the other or both
    elsif (recs.sum { |exhibit| exhibit. cost }) <= patron.spending_money
      #if the sum of the exhibit costs is less than or equal to the spending money, they should be able to go to BOTH

    # attend exhibits when admitted
    #only exhibits they are interested in
    # visit higher cost then lower cost
    # if patron doesn't have enough spending money, they won't go
    # when they attend an exhibit, they cost is subtracted from their spending money and added to museum revenue

    # recommend_exhibits
  end

  def patrons_by_exhibit_interest
    @exhibits.reduce({}) do |hash, exhibit|

      hash[exhibit] = @patrons.find_all { |patron| patron.interests.include?(exhibit.name)}
      hash
    end
  end

  # def patrons_of_exhibits
    # returns a Hash where keys are exhibits and values are arrays containing patrons that attend the exhibit
  # end

  #def revenue
    #returns an Integer representing revenue collected from Patrons attending exhibits
  # end

end
