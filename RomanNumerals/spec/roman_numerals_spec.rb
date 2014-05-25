require 'roman_numerals'

describe 'RomanNumerals' do
	
	it 'should be able to convert 1 to I' do
		expect(RomanNumerals.convert(1)).to eq "I"
	end

	it 'should be able to convert 5 to V' do
		expect(RomanNumerals.convert(5)).to eq "V"
	end

	it 'should be able to convert 10 to X' do
		expect(RomanNumerals.convert(10)).to eq "X"
	end

	it 'should be able to convert 35 to XXXV' do
		expect(RomanNumerals.convert(35)).to eq "XXXV"
	end

	it 'should be able to convert 996 to CMIXVI' do
		expect(RomanNumerals.convert(996)).to eq "CMXCVI"
	end

	it 'should be able to convert 1999 to MCMXCIX' do
		expect(RomanNumerals.convert(1999)).to eq "MCMXCIX"
	end

end