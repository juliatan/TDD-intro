# def is_divisible_by_three?(number)
# 	number % 3 == 0
# end

# def is_divisible_by_five?(number)
# 	number % 5 == 0
# end

# make it generic
def is_divisible_by?(divisor, number)
	number % divisor == 0
end

def is_divisible_by_three?(number)
	is_divisible_by?(3, number)
end

def is_divisible_by_five?(number)
	is_divisible_by?(5, number)
end

def fizzbuzz(number)
	return "Fizz" if is_divisible_by_three?(number)
	number
end