require './lib/pantry'
require './lib/recipe'
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

    pantry.restock("Cheese", 20)

    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_recipe_can_be_added_to_shopping_list
    recipe = Recipe.new("Cheese Pizza")
    pantry = Pantry.new

    recipe.add_ingredient("Flour", 20)
    recipe.add_ingredient("Cheese", 20)
    pantry.add_to_shopping_list(recipe)

    assert_instance_of Hash, pantry.shopping_list
    assert_equal 2, pantry.shopping_list.count
    assert_equal ["Flour", "Cheese"], pantry.shopping_list.keys
    assert_equal [20, 20], pantry.shopping_list.values
  end

  def test_more_recipes_can_be_added_to_shopping_list
    recipe = Recipe.new("Cheese Pizza")
    pantry = Pantry.new

    recipe.add_ingredient("Flour", 20)
    recipe.add_ingredient("Cheese", 20)
    pantry.add_to_shopping_list(recipe)

    assert_equal ({"Flour"=>20, "Cheese"=>20}), pantry.shopping_list

    recipe2 = Recipe.new("Sphaghetti")

    recipe2.add_ingredient("Sphaghetti Noodles", 10)
    recipe2.add_ingredient("Marinara Sauce", 10)
    recipe2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(recipe2)

    assert_equal ({"Flour"=>20, "Cheese"=>25, "Sphaghetti Noodles"=>10, "Marinara Sauce"=>10}), pantry.shopping_list
  end

end
