class Pantry

  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    stock.keys.count do |in_stock|
      in_stock == item
    end
  end

end
