def sum_to(n)
  return 1 if n == 1
  return nil if n <= 0
  n + sum_to(n - 1)
end

def add_numbers(nums_array)
  return nums_array[0] if nums_array.length == 1
  last = nums_array[-1]
  nums_array.pop
  last + add_numbers(nums_array)
end

def gamma_fnc(n)
  return 1 if n == 1
  return nil if n <= 0
  (n - 1) * gamma_fnc(n - 1)
end

def quick_sort(arr)
  return arr if arr.length <= 1
  pivot_arr = [arr.first]
  left_side = arr[1..-1].select { |el| el < arr.first}
  right_side = arr[1..-1].select { |el| el >= arr.first}
  quick_sort(left_side) + pivot_arr + quick_sort(right_side)
end


if __FILE__ == $PROGRAM_NAME
  puts "sum_to tests:"
  puts sum_to(5)  # => returns 15
  puts sum_to(1)  # => returns 1
  puts sum_to(9)  # => returns 45
  p sum_to(-8)  # => returns nil
  puts "\nadd_numbers tests:"
  puts add_numbers([1, 2, 3, 4]) # => returns 10
  puts add_numbers([3]) # => returns 3
  puts add_numbers([-80, 34, 7]) # => returns -39
  #puts add_numbers() # => returns nil
  puts "\nGamma Function tests:"
  p gamma_fnc(0)  # => returns nil
  puts gamma_fnc(1)  # => returns 1
  puts gamma_fnc(4)  # => returns 6
  puts gamma_fnc(8)  # => returns 5040
  puts "\nQuick Sort tests:"
  p quick_sort([1, 8, 6]) # => returns [1, 6, 8]
  p quick_sort([9, 2, 8, 4, 7]) # => returns [2, 4, 7, 8, 9]
  p quick_sort([3, 7, 3, 1, 9]) # => returns [1, 3, 3, 7, 9]
end
