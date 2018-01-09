require 'pry'

class Pantry

  attr_reader :stock, :shopping_list, :cookbook

  def initialize
    @stock         = {}
    @shopping_list = {}
    @cookbook      = []
  end

  def stock_check(item)
    stock.keys.count do |in_stock|
      return stock[item] if in_stock == item
    end
  end

  def restock(item, number)
    if stock[item]
      stock[item] += number
    else
      stock[item] = number
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.select do |item, number|
      if shopping_list[item]
        shopping_list[item] += number
      else
        shopping_list[item] = number
      end
    end
  end

  def print_shopping_list
    shopping_list.reduce("") do |result, list|
      result + "* #{list[0]}: #{list[1]}\n"
    end.chomp
  end

  def add_to_cookbook(recipe)
    cookbook << recipe
  end

  def what_can_i_make
    cookbook.map do |recipe|
      recipe.name if check_ingredients(recipe.ingredients)
    end.compact
  end

  def check_ingredients(ingredients)
    ingredients.all? do |ingredient|
      stock_check(ingredient[0]) >= ingredient[1]
    end
  end

end
