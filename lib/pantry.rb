class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    stock.keys.count do |in_stock|
      return stock[item] if in_stock == item
    end
  end

  def restock(item, number)
    stock[item] = number
  end

end
