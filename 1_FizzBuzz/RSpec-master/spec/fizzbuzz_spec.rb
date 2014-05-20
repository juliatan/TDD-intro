require 'fizzbuzz' # looks for the filename in the lib file

describe "Fizzbuzz" do # Fizzbuzz is just any string
	
	context 'knows that a number is divisible by' do # bundles things together

		it '3' do
			expect(is_divisible_by_three?(3)).to be_true
		end 

		it '5' do
			expect(is_divisible_by_five?(5)).to be_true
		end

	end

	context 'knows that a number is not divisible by' do

		it '3' do
			expect(is_divisible_by_three?(1)).to be_false # could be .not_to be_true
		end

		it '5' do
			expect(is_divisible_by_five?(1)).to be_false
		end

	end

	context 'when playing the game returns' do
		
		it '1 for the number 1' do
			expect(fizzbuzz(1)).to eq 1
		end

		it '"Fizz" for the number 3' do
			expect(fizzbuzz(3)).to eq "Fizz"
		end
	end

end