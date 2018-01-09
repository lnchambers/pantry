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
    if !stock[item]
      stock[item] = number
    else
      stock[item] += number
    end
  end

end
