require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_pantry_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_pantry_is_empty_by_default
    pantry = Pantry.new

    assert_instance_of Hash, pantry.stock
    assert_equal 0, pantry.stock.count
  end

  def test_pantry_can_be_searched
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_pantry_can_be_restocked
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

end
