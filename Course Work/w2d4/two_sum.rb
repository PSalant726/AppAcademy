def bad_brute_force_duo(numbers, target_sum)
  first_number_index = 0
  while first_number_index < numbers.size - 1
    second_number_index = first_number_index + 1
    while second_number_index < numbers.size
      sum = numbers[first_number_index] + numbers[second_number_index]
      return true if sum == target_sum
      second_number_index += 1
    end
    first_number_index += 1
  end
  false
end

def slightly_better_soulmate_finder_duo(numbers, target_sum)
  numbers.sort!
  numbers.each do |number|
    corresponding_number = target_sum - number
    return true if numbers.bsearch do |soulmate_number|
      soulmate_number == corresponding_number
    end
  end
  false
end

def hashy_the_instant_soulmate_finder(numbers, target_sum)
  hashy = Hash.new()
  numbers.each do |number|
    soulmate_number = target_sum - number
    return true if hashy.has_key?(soulmate_number)
    hashy[number] = nil
  end
  false
end

def hashy_the_foursome_finder(numbers, target_sum)
  hashy = Hash.new() { |hash, key| hash[key] = [] }
  (0...numbers.size - 1).each do |first_number_index|
    (first_number_index+1...numbers.size).each do |second_number_index|
      sum = numbers[first_number_index] + numbers[second_number_index]
      if hashy.has_key?(sum)
        partners = hashy[sum]
        unless partners.include?(first_number_index) ||
          partners.include?(second_number_index)
          return true
        end
      end
      hashy[sum] = [first_number_index, second_number_index]
    end
  end
  false
end

if __FILE__ == $PROGRAM_NAME
  numbers = [0, 1, 5, 7, 4, 3, 1]
  target_sum = 6
  foursome_target = 12

  puts "PREPARE FOR TESTTTTINNGGGG!!!"
  puts ""
  puts "Bad Brute Force Duo, Youuur'e up!"
  puts ""
  puts "Has the bad brute force duo secured victory against their arch nemeses, the target sum and array?"
  puts bad_brute_force_duo(numbers, target_sum)? "YES, they were no match for the brute force duo!": "Oh noes! Better luck next time, team!"
  puts ""
  puts "Soulmate Finder Man, the greatest super hero of lower manhattan, you're UPP!"
  puts ""
  puts slightly_better_soulmate_finder_duo(numbers, target_sum) ? "Good job, duo of super friends! You've defeated bowser and secured the princess!" : "Eat a +1 life mushroom and try again."
  puts ""
  puts "HASHY, I CHOOSE YOU!"
  puts ""
  puts hashy_the_instant_soulmate_finder(numbers, target_sum) ? "CRITICAL HIT!" : "HASHY HURT HIMSELF IN HIS CONFUSION |-("
  puts ""
  puts "HASHY, FIND A FOURSOME!"
  puts hashy_the_foursome_finder(numbers, foursome_target) ? "BUYAH!" : "crap..."
end
