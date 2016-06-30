class Array
  def my_uniq
    ret_arr = []
    each do |el|
      ret_arr << el unless ret_arr.include?(el)
    end
    ret_arr
  end

  def two_sum
    ret_arr = []
    each_with_index do |el, idx|
      i = idx + 1
      while i < length
        ret_arr << [idx, i] if el + self[i] == 0
        i += 1
      end
    end
    ret_arr
  end

  def my_transpose
    ret_arr = Array.new(length){ Array.new(length) }
    each_with_index do |arr, idx|
      arr.each_with_index do |el, jdx|
        ret_arr[jdx][idx] = el
      end
    end
    ret_arr
  end
end

def stock_picker(prices)
  profit = 0
  best_days = []
  prices.each_with_index do |price, idx|
    new_idx = idx + 1
    while new_idx < prices.length
      current_profit = prices[new_idx] - price
      if current_profit > profit
        profit = current_profit
        best_days = [idx, new_idx]
      end
      new_idx += 1
    end
  end
  best_days
end
