def range(start, finish)
  return [] if finish < start
  return [start] if start == finish
  range(start, finish - 1) << finish
end

def range_it(start, finish)
  return [] if finish < start
  acc = []
  start.upto(finish) { |num| acc << num }
  acc
end

def exp_v1(base, n)
  return 1 if n == 0
  if n < 0
    (1 / base.to_f) * (exp_v1(base, n + 1).to_f)
  else
    base * exp_v1(base, n - 1)
  end
end

def exp_v2(base, n)
  return 1 if n == 0
  return base if n == 1
  if n % 2 == 0
    if n > 0
      half = exp_v2(base, n / 2)
    else # when n is even and < 0
      half = 1 / exp_v2(base, n.abs / 2).to_f
    end
    half * half
  else
    if n > 0
      half = exp_v2(base, (n - 1) / 2)
    else
      half = 1 / (exp_v2(base, (n + 1).abs / 2)).to_f
      base = 1 / base.to_f
    end
    base * half * half
  end
end

def deep_dup(arr)
  ret_arr = []
  arr.each do |el|
    if el.is_a?(Array)
      ret_arr << deep_dup(el)
    else
      ret_arr << el
    end
  end
  ret_arr
end

def fibonacci_rec(n)
  return [0, 1].take(n) if n <= 2
  # return [0] if n == 1
  # return [0, 1] if n == 2
  # return [] if n <= 0
  arr = fibonacci_rec(n - 1)
  arr << arr[-1] + arr[-2]
end

def fibonacci_it(n)
  return [] if n <= 0
  return [0] if n == 1
  fibs = [0, 1]
  (2...n).each do |idx|
    fibs << fibs[idx - 1] + fibs[idx - 2]
  end
  fibs
end

def bsearch(arr, el)
  # base case
  if arr.length <= 1
    arr.include?(el) ? 0 : nil
  else
    # gets index of rhs partition
    rhs_idx = (arr.length / 2)
    # create lhs, rhs partitions
    lhs, rhs = partition(arr, rhs_idx)
    # get index of el if exists in lhs
    result = bsearch(lhs, el)
    # doesn't exist in lhs
    if result.nil?
      # check rhs
      result = bsearch(rhs, el)
      # if found on rhs, increment with rhs_idx
      result += rhs_idx unless result.nil?
    end
    result
  end
end

def partition(arr, idx)
  lhs = arr[0...idx]
  rhs = arr[idx..-1]
  [lhs, rhs]
end

def merge_sort(arr)
  # base case
  return arr if arr.length <= 1
  # induction!
  split = arr.length / 2
  lhs, rhs = partition(arr, split).map! { |array| merge_sort(array) }
  merge(lhs, rhs)
end

def merge(lhs, rhs)
  merged = []
  until lhs.empty? || rhs.empty?
    merged << (lhs.first < rhs.first ? lhs.shift : rhs.shift)
  end
  # push remaining elements
  # merged += (lhs.empty? ? rhs : lhs)
  merged + rhs + lhs
end

def subsets(arr)
  return [[]] if arr.empty?
  ret_arr = []
  last = arr.pop
  subs = subsets(arr)
  ret_arr += subs
  ret_arr += subs.map { |subset| subset + [last] }
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount <= 0
  coins.sort.reverse
  coins.shift while coins.first > amount
  amount -= coins[0]
  [coins[0]] + greedy_make_change(amount, coins)
end

def usable_coins(amount, coins)
  coins.select { |coin| coin <= amount }
end

def make_better_change(amount, coins = [25, 10, 5, 1])
  return [] if amount <= 0

  min_coins = amount / coins.last
  ret_arr = nil

  usable_coins = usable_coins(amount, coins)

  usable_coins.each do |coin|
    if amount % coin == 0 && ((amount / coin) < min_coins)
      ret_arr = Array.new((amount / coin), coin)
      min_coins = ret_arr.length
      break
    else
      new_amount = amount - coin
      arr = make_better_change(new_amount, usable_coins) + [coin]
      if arr.length <= min_coins
        ret_arr = arr
        min_coins = ret_arr.length
      end
    end
  end
  ret_arr
end

if __FILE__ == $PROGRAM_NAME
  p make_better_change(24, [10, 7, 1])
  p make_better_change(500)
end
