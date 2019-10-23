require 'minitest/autorun'
require 'minitest/pride'
require './lib/patron'
require './lib/exhibit'
require './lib/museum'

class MuseumTest < Minitest::Test
  def setup
    @dmns = Museum.new("Denver Museum of Nature and Science")

    @gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    @dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    @imax = Exhibit.new("IMAX", 15)

    @bob = Patron.new("Bob", 20)
    @sally = Patron.new("Sally", 20)
  end

  def test_it_exists
    assert_instance_of Museum, @dmns
  end

  def test_it_has_attributes
    assert_equal "Denver Museum of Nature and Science", @dmns.name
    assert_equal [], @dmns.exhibits
    assert_equal [], @dmns.patrons
    assert_equal 0, @dmns.revenue
  end

  def test_it_can_add_exhibit
    assert_equal [], @dmns.exhibits

    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    assert_equal [@gems_and_minerals, @dead_sea_scrolls, @imax], @dmns.exhibits
  end

  def test_it_can_recommend_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)



    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    assert_equal [@dead_sea_scrolls, @gems_and_minerals], @dmns.recommend_exhibits(@bob)

    @sally.add_interest("IMAX")

    assert_equal [@imax], @dmns.recommend_exhibits(@sally)
  end

  def test_it_can_admit_patrons
    assert_equal [], @dmns.patrons

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal [@bob, @sally], @dmns.patrons
  end

  def test_it_can_sort_patrons_by_exhibit_interest
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    @bob.add_interest("Dead Sea Scrolls")
    @bob.add_interest("Gems and Minerals")

    @sally.add_interest("Dead Sea Scrolls")

    @dmns.admit(@bob)
    @dmns.admit(@sally)

    assert_equal (
      {@gems_and_minerals => [@bob], @dead_sea_scrolls => [@bob, @sally],
      @imax => []
      }), @dmns.patrons_by_exhibit_interest
  end

  # probably will need a helper method to find the sum of the exhibit costs they are interested in
  def test_it_can_admit_patrons_and_send_to_exhibits
    @dmns.add_exhibit(@gems_and_minerals)
    @dmns.add_exhibit(@dead_sea_scrolls)
    @dmns.add_exhibit(@imax)

    tj = Patron.new("TJ", 7)
    tj.add_interest("IMAX")
    tj.add_interest("Dead Sea Scrolls")
    require "pry"; binding.pry
    @dmns.admit(tj)
    # this seems really hard to test in one go so need to figure out how to break it up into steps... and since so many steps are happening it seems like helper methods would be necessary 
    assert_equal 7, tj.spending_money
  end


end
