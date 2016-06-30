def add(num1, num2)
    num1 + num2
end

def subtract(num1, num2)
    num1 - num2
end

def sum(arr)
    ans = 0
    arr.each { |num| ans += num}
    ans
end

def multiply(*nums)
    prod = 1
    nums.each { |num| prod *= num }
    prod
end

def power(base, exponent)
    base ** exponent
end

def factorial(num)
    return 1 if num == 0 || num == 1
    return nil if num < 0
    i = 1
    prod = num
    while num - i > 0
        prod *= (num - i)
        i += 1
    end
    prod
end