def naive_window(array, window_size)
  windows = []

  start_of_window = 0
  end_of_window = start_of_window + window_size
  while end_of_window < array.size
    end_of_window = start_of_window + window_size
    windows << array[start_of_window...end_of_window]
    start_of_window += 1
  end
  max_range = 0
  windows.each do |window|
    range = window.max - window.min
    max_range = range if range > max_range
  end
  max_range
end

def boss_level_window
end

if __FILE__ == $PROGRAM_NAME
  range = [1, 0, 2, 5, 4, 8]
  range2 = [1, 3, 2, 5, 4, 8]
  puts "NAIVE WINDOW"
  p naive_window(range, 2) == 4
  p naive_window(range, 3) == 5
  p naive_window(range, 4) == 6
  p naive_window(range2, 5) == 6
end
