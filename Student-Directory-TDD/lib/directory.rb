require 'csv'

def create_student(name, cohort = :May, year = 2014)
	{name: name, cohort: cohort, year: year}
end

def students
	@students ||= []
end

def add_student(student)
	students << student # note that students here is the method not the variable
end

def list_students
	 students.map do |student| # .each will not work here because it doesn't return anything
		"#{student[:name]} (#{student[:cohort]} #{student[:year]})"
	end.join("\n")
end

def delete_student(name)
	students.delete_if { |student| student[:name] == name }
end

def save_students_list(filename)
	CSV.open(filename, "w") do |line|
		students.each do |student|
			line << [student[:name], student[:cohort], student[:year]]
		end
	end
end

def load_students(filename)
	return nil unless File.exists?(filename) # if filename doesn't exist, exit from method
	CSV.foreach(filename) do |line|
		name, cohort, year = line[0], line[1], line[2]
		students << {name: name, cohort: cohort.to_sym, year: year.to_i}
	end
end

def show_menu
	puts "\n1. Input the students"
	puts "2. Show the students"
	puts "3. Save the list to a filename of your choice"
	puts "4. Load the list from a filename of your choice"
	puts "9. Exit\n\n"
end

def process_menu(user_input)
	case user_input
	when 1
		input_student
	when 2
		list_students
	when 3
		save_students_list(get_save_filename)
	when 4
		load_students(get_load_filename)
	when 9
		exit
	else
		"I don't know what you meant, try again!"
	end
end

def input_student
	puts "Please enter the names of the students.\nTo finish, just hit return twice."
	name = get_name

	while !name.empty? do
		cohort = get_cohort

		if !cohort.empty?
			year = get_year
		else
			cohort = :May
			year = 2014
		end

		add_student(create_student(name, cohort, year))

		puts "Anyone else?"
		name = get_name
	end

	puts students
end

def get_name
	gets.chomp
end

def get_cohort
	puts "Which cohort?"
	cohort = gets.chomp.to_sym
end

def get_year
	puts "Which year?"
	year = gets.chomp.to_i
end

def interactive_menu
	loop do
		show_menu
		process_menu(get_user_input)
	end
end

def get_user_input
	gets.chomp.to_i
end

def get_save_filename
	gets.chomp
end

def get_load_filename
	gets.chomp
end

#interactive_menu




