def stock_picker(prices)
  return nil if prices.length < 2
  
  best_buy_index = 0 #default
  best_sell_index = 1 #default
  max_profit = prices[best_sell_index] - prices[best_buy_index]
  lowest_index = best_buy_index

  prices.each_with_index do |price, index|
    if price > prices[best_buy_index] && price - prices[best_buy_index] > max_profit
      best_sell_index = index
      max_profit = price - prices[best_buy_index]
    end
    if price < prices[lowest_index]
      lowest_index = index
    end
    if price > prices[lowest_index] && price - prices[lowest_index] > max_profit
      best_buy_index = lowest_index
      best_sell_index = index
      max_profit = price - prices[lowest_index]
    end  
  end

  [best_buy_index, best_sell_index]
end

p stock_picker([17,3,6,9,15,8,6,1,10])
p stock_picker([1,3,6,9,4,3,7,17])
p stock_picker([5,8,10,4,2,1,5,7,10,8])
p stock_picker([5,8,10,9,5,3,2,1,4])
p stock_picker([])
