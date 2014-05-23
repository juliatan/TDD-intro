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
		expect(list_students).to eq "1. #{julia[:name]} (#{julia[:cohort]} #{julia[:year]})"
	end

	it 'array for more than two students lists two students in the same format"' do
		julia = create_student("Julia", :May, 2014)
		john = create_student("John", :May, 2014)
		add_student(julia)
		add_student(john)
		expect(list_students).to eq "1. #{julia[:name]} (#{julia[:cohort]} #{julia[:year]})\n2. #{john[:name]} (#{john[:cohort]} #{john[:year]})"
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

	# is this test even necessary?
	it 'takes user input and passes it as an argument to save method' do
		begin
			File.delete("test3.csv") #check file doesn't already exist
		rescue
		end
		stub!(:get_save_filename).and_return("test3.csv")
		save_students_list(get_save_filename)
		expect(File.exist?("test3.csv")).to be_true
	end
end

describe 'Loads a CSV file' do

	it 'checks if user defined CSV file exists' do
		begin
			File.delete("test1.csv") # but test.csv doesn't exist
		rescue 						# hence an error is raised, which we override
		end
		load_students("test1.csv")
	end

	it 'loads user defined CSV file' do
		expect(CSV).to receive(:foreach).with("test2.csv")
		load_students("test2.csv")
	end

	it 'converts CSV data into hash format and adds to students list' do
		load_students("test2.csv")
		expect(students).to eq [{name: "Julia", cohort: :May, year: 2014}, {name: "John", cohort: :May, year: 2014}]
	end

	# is this even necessary?
	it 'takes user input and passes it as an argument to load method' do
		stub!(:get_load_filename).and_return("test2.csv")
		load_students(get_load_filename)
		expect(students).to eq [{name: "Julia", cohort: :May, year: 2014}, {name: "John", cohort: :May, year: 2014}]
	end
end

describe 'Filtering function' do

	it 'filters students by month' do
		julia = create_student("Julia", :May, 2014)
		john = create_student("John", :June, 2014)
		add_student(julia)
		add_student(john)
		expect(filter_students(:May)).to eq "1. #{julia[:name]} (#{julia[:cohort]} #{julia[:year]})"
	end

end

describe 'User process menu' do

	# it 'shows the menu of user options' do
	# 	expect(show_menu).to eq	"1. Input the students\n
	# 	2. Show the students\n
	# 	3. Save the list to a filename of your choice\n
	# 	4. Load the list from a filename of your choice\n
	# 	9. Exit\n\n"
	# end

	# no longer relevant - tested below in input students option
	# let(:user_input) { "1" }
	# it 'allows user to input students when "1" is entered' do
	# 	user_input = 1
 #    	process_menu(user_input).should eq input_student
	# end

	# it 'correctly passes initial user choice to right process' do
	# 	stub!(:get_user_input).and_return 1
	# 	expect(interactive_menu) to ... NO RETURN VALUES!!
	# end

	it 'lists the students array when "2" is entered' do
		julia = create_student("Julia")
		john = create_student("John")
		add_student(julia)
		add_student(john)
		user_input = 2
		process_menu(user_input).should eq list_students_header
		list_students 
		list_students_footer
	end

end

describe 'Input students option' do

	# it 'asks the user for the names of the students' do
	# 	expect(input_student).to eq "Please enter the names of the students\nTo finish, just hit return twice."
	# end

	# it 'ensures that if user inputs name, user is asked for cohort and year' do
	# 	stub!(:get_name).and_return("Jim", "Jacob",'')
	# 	stub!(:get_cohort).and_return(":June")
	# 	stub!(:get_year).and_return(2014)
	# 	expect(input_student).to eq get_year
	# end

	it 'ensures that user inputs gets stored to student array correctly' do
		stub!(:get_name).and_return("Jim", "Jacob",'')
		stub!(:get_cohort).and_return(:June)
		stub!(:get_year).and_return 2014
		# allow(self).to receive(:get_cohort).and_return 2014
		input_student
		expect(students).to eq [{name: "Jim", cohort: :June, year: 2014}, {name: "Jacob", cohort: :June, year: 2014}]
	end
end

# describe 'When program is started' do

# 	it 'the interactive menu is loaded' do
# 		expect self.should receive(:interactive_menu) 
# 	end

# end





