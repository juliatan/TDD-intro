require 'directory'

describe 'Adding students to the directory' do

	it 'with name, cohort and year for one student, Julia' do
		julia = {name: "Julia", cohort: :May, year: 2014}
		expect(create_student("Julia", :May, 2014)).to eq julia 
	end

	it 'with name, cohort and year for a second student, John' do
		john = {name: "John", cohort: :May, year: 2014}
		expect(create_student("John", :May, 2014)).to eq john
	end	
	
end

describe 'Listing students' do

	it 'array has no data when initialised' do
		expect(students).to be_empty
	end

	it 'array contains data when one student is added' do
		julia = create_student("Julia", :May, 2014)
		add_student(julia)
		expect(students).not_to be_empty
	end

	it 'array for Julia input data returns "Julia (May 2014)"' do
		julia = create_student("Julia", :May, 2014)
		add_student(julia)
		expect(list_students).to eq "#{julia[:name]} (#{julia[:cohort]} #{julia[:year]})"
	end

	it 'array for more than two students lists two students in the same format"' do
		julia = create_student("Julia", :May, 2014)
		john = create_student("John", :May, 2014)
		add_student(julia)
		add_student(john)
		expect(list_students).to eq "#{julia[:name]} (#{julia[:cohort]} #{julia[:year]})\n#{john[:name]} (#{john[:cohort]} #{john[:year]})"
	end

	it 'assumes students are from May cohort if not specified' do
		julia = create_student("Julia")
		add_student(julia)
		expect(students[0][:cohort]).to eq :May
	end

	it 'assumes students start year is 2014 if not specified' do
		julia = create_student("Julia")
		add_student(julia)
		expect(students[0][:year]).to eq 2014
	end

end

describe 'Deleting students' do

	it 'is done by name' do
		julia = create_student("Julia")
		john = create_student("John")
		add_student(julia)
		add_student(john)
		expect(delete_student(john[:name])).to eq [julia]
	end

end

describe 'Writes to CSV file' do

	it 'creates a file with a user defined filename' do
		save_students_list("students.csv")
		expect(File.exist?("students.csv")).to be_true
	end

	it 'writes current student list in CSV format into file' do
		julia = create_student("Julia")
		john = create_student("John")
		add_student(julia)
		add_student(john)
		save_students_list("students.csv")
		expect(CSV.readlines("students.csv")).to eq [["Julia", "May", "2014"], ["John", "May", "2014"]]
	end

end

describe 'Loads a CSV file' do

	it 'loads user defined CSV file' do
		expect(CSV).to receive(:foreach).with("students.csv")
		load_students("students.csv")
	end

	it 'converts CSV data into hash format and adds to students list' do
		load_students("students.csv")
		expect(students).to eq [{name: "Julia", cohort: :May, year: 2014}, {name: "John", cohort: :May, year: 2014}]
	end
end
