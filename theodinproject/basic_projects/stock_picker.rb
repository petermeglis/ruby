def stock_picker(prices)
  best_buy_index = 0
  best_sell_index = 1
  prices.each_with_index do |price, buy_index|
    sell_index = buy_index + 1
    while sell_index < prices.length
      if prices[sell_index] - prices[buy_index] > prices[best_sell_index] - prices[best_buy_index]
        best_buy_index = buy_index
        best_sell_index = sell_index
      end
      sell_index += 1
    end
  end

  [best_buy_index, best_sell_index]
end

stock_picker([17,3,6,9,15,8,6,1,10])