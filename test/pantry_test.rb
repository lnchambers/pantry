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

    recipe2 = Recipe.new("Spaghetti")

    recipe2.add_ingredient("Spaghetti Noodles", 10)
    recipe2.add_ingredient("Marinara Sauce", 10)
    recipe2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(recipe2)

    assert_equal ({"Flour"=>20, "Cheese"=>25, "Spaghetti Noodles"=>10, "Marinara Sauce"=>10}), pantry.shopping_list
  end

  def test_pantry_print_shopping_list
    recipe = Recipe.new("Cheese Pizza")
    pantry = Pantry.new

    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(recipe)

    assert_equal ({"Cheese"=>20, "Flour"=>20}), pantry.shopping_list

    recipe2 = Recipe.new("Spaghetti")

    recipe2.add_ingredient("Spaghetti Noodles", 10)
    recipe2.add_ingredient("Marinara Sauce", 10)
    recipe2.add_ingredient("Cheese", 5)

    pantry.add_to_shopping_list(recipe2)
    puts pantry.print_shopping_list

    assert_equal ("* Cheese: 25
* Flour: 20
* Spaghetti Noodles: 10
* Marinara Sauce: 10"), pantry.print_shopping_list
  end

  def test_pantry_can_add_to_cookbook
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry = Pantry.new
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_instance_of Array, pantry.cookbook
    assert_equal 3, pantry.cookbook.count
    assert_instance_of Recipe, pantry.cookbook.first
    assert_equal "Cheese Pizza", pantry.cookbook.first.name
    assert_equal ({"Raw nuts"=>10, "Salt"=>10}), pantry.cookbook.last.ingredients
  end

end
