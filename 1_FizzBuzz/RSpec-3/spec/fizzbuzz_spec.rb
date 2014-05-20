require 'fizzbuzz'

describe "Fizzbuzz" do
  
  context 'knows that numbers are divisible by' do

    it '3' do
      expect(is_divisible_by_three?(3)).to be_true
    end

    it '5' do
      expect(is_divisible_by_five?(5)).to be_true
    end

    it 15 do
      expect(is_divisible_by_fifteen?(15)).to be_true
    end


  end

  context 'knows that numbers are not divisible by' do

    it '3' do
      expect(is_divisible_by_three?(1)).to be_false
    end

    it '5' do
      expect(is_divisible_by_five?(1)).to be_false
    end

    it 15 do
      expect(is_divisible_by_fifteen?(1)).to be_false
    end

  end

  context 'when playing the game' do

    it '1, gives 1' do
      expect(fizzbuzz(1)).to eq 1
    end


    it '3, gives "Fizz"' do
      expect(fizzbuzz(3)).to eq "Fizz"
    end

    it '5, gives "Buzz' do
      expect(fizzbuzz(5)).to eq "Buzz"
    end

    it '15, gives "FizzBuzz"' do
      expect(fizzbuzz(15)).to eq "FizzBuzz"
    end


  end

end