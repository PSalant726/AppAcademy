# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#   my_min(list)  # =>  -5

def my_min_phase1(arr)
  arr.each_with_index do |el, iter|
    second_iter = iter + 1
    is_smallest = true
    while second_iter < arr.length
      is_smallest &&= arr[iter] < arr[second_iter]
      second_iter += 1
    end
    return el if is_smallest == true
  end
end

def my_min_phase2(arr)
  min = arr.first
  arr.drop(1).each { |el| min = el if el < min }
  min
end

def largest_contiguous_subsum_phase1(list)
  sub_arrays = []

  list.each_with_index do |element, index|
    end_of_sub_array = index + 1
    while end_of_sub_array < list.size
      sub_arr = list[index..end_of_sub_array]
      sub_arrays << sub_arr
      end_of_sub_array += 1
    end
  end
  largest_sum = 0
  sub_arrays.each do |arr|
    sum = arr.reduce(:+)
    largest_sum = sum if sum > largest_sum
  end
  largest_sum
end

def largest_contiguous_subsum_phase2(list_of_numbers)
  largest_sum_so_far = 0
  cummulative_sum_of_current_series = 0

  list_of_numbers.each do |number|
    cummulative_sum_of_current_series += number
    if cummulative_sum_of_current_series <= 0
      cummulative_sum_of_current_series = 0
    else
      if cummulative_sum_of_current_series > largest_sum_so_far
        largest_sum_so_far = cummulative_sum_of_current_series
      end
    end
  end
  largest_sum_so_far
end

if __FILE__ == $PROGRAM_NAME
  list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
  p my_min_phase1(list)  # =>  -5
  p my_min_phase2(list)  # =>  -5
  list2 = [2, 3, -6, 7, -6, 7]
  p largest_contiguous_subsum_phase1(list2)
  p largest_contiguous_subsum_phase2(list2)
end
