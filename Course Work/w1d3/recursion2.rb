def range(start_num, end_num)
  return [] if end_num <= start_num - 1
  [start_num].concat(range(start_num + 1, end_num))
end

def sum_rec(arr)
  return 0 if arr.length == 0
  sum = arr.shift + sum_rec(arr)
end

def sum_it(arr)
  sum = 0
  arr.each { |num| sum += num }
  sum
end

def exp_v1(base, exp)
  return 1 if exp == 0
  base * exp_v1(base, exp - 1)
end

def exp_v2(base, exp)
  return 1 if exp == 0
  return base if exp == 1
  if exp % 2 == 0
    2 ** exp_v2(base, exp / 2)
  else
    base * (2 ** exp_v2(base, (exp - 1) / 2))
  end
end

class Array
  def deep_dup
    ret_arr = []
    each do |el|
      el.is_a?(Array) ? ret_arr << el.deep_dup : ret_arr << el
    end
    ret_arr
  end
end

def fibonacci_rec(n)
  return [0,1].take(n) if n <= 2
  arr = fibonacci_rec(n - 1)
  arr << arr[-2] + arr[-1]
end

def fibonacci_it(n)
  arr = [0,1]
  (n - 2).times { arr << arr[-1] + arr[-2] }
  arr
end

def bsearch(arr, el)
  if arr.length <= 1
    arr.include?(el) ? 0 : nil
  else
    idx = (arr.length / 2)
    left_arr = arr[0...idx]
    right_arr = arr[idx..-1]
    result = bsearch(left_arr, el)
    unless result
      result = bsearch(right_arr, el)
      result += idx unless result.nil?
    end
    result
  end
end

class Array
  def merge_sort
    return self if length < 2
    idx = length / 2
    # left_sorted = take(idx).merge_sort
    # right_sorted = drop(idx).merge_sort
    left_sorted = self[0...idx].merge_sort
    right_sorted = self[idx..-1].merge_sort
    merge(left_sorted, right_sorted)
  end

  def merge(left_sorted, right_sorted)
    merged = []
    until left_sorted.empty? || right_sorted.empty?
      if left_sorted[0] < right_sorted[0]
        merged.push(left_sorted.shift)
      else
        merged.push(right_sorted.shift)
      end
    end
    merged + left_sorted + right_sorted
  end

  def subsets
    return [[]] if empty?
    subs = take(length - 1).subsets
    subs.concat(subs.map { |sub| sub + [last] })
  end
end


if __FILE__ == $PROGRAM_NAME
  puts "range"
    p range(6, 5) == []
    p range(1, 10) == (1..10).to_a
  puts "\nsum_rec"
    p sum_rec((1..5000).to_a) == 12502500
  puts "\nsum_it"
    p sum_it((1..5000).to_a) == 12502500
  puts "\nexp_v1"
    p exp_v1(2,5) == 32
  puts "\nexp_v2"
    p exp_v2(2,5) == 32
  puts "\ndeep_dup"
    a = [[1,2],3,[[4],5]]
    b = a.deep_dup
    p a[0].object_id != b[0].object_id
  puts "\nfibonacci_rec"
    p fibonacci_rec(8) == [0,1,1,2,3,5,8,13]
  puts "\nfibonacci_it"
    p fibonacci_it(8) == [0,1,1,2,3,5,8,13]
  puts "\nbsearch"
    p bsearch([2, 4, 6, 8, 10], 6) == 2
    p bsearch([1, 2, 3, 4, 5, 6], 6) == 5
    p bsearch([1, 2, 3, 4, 5, 6], 0) == nil
    p bsearch([], 6) == nil
  puts "\nmerge_sort"
    c = (1..1000).to_a.shuffle
    p c.merge_sort == c.sort
  puts "\nsubsets"
    p [].subsets == [[]]
    p [1].subsets == [[], [1]]
    p [1, 2].subsets == [[], [1], [2], [1, 2]]
    p [1, 2, 3].subsets == [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
end
