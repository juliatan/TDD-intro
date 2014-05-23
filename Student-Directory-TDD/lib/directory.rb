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
	students.map.with_index do |student, i|
		"#{i+1}. #{student[:name]} (#{student[:cohort]} #{student[:year]})"
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
	puts "#{filename} has been saved! What's next?"
end

def load_students(filename)
	students.clear
	if File.exists?(filename) # if filename doesn't exist, exit from method
		CSV.foreach(filename) do |line|
			name, cohort, year = line[0], line[1], line[2]
			students << {name: name, cohort: cohort.to_sym, year: year.to_i}
		end
		puts "#{filename} has been loaded! What's next?"
	else
		puts "This file doesn't exist, pick another option." 
	end
end

def filter_students(month)
	filtered = students.keep_if do |student|
	 	student[:cohort] == month.to_sym
	end
	
	filtered.map.with_index do |student, i| 
		"#{i+1}. #{student[:name]} (#{student[:cohort]} #{student[:year]})"
	end.join("\n")
end

def show_menu
	puts "\nWelcome to the Makers Academy student directory. Pick an option."
	puts "\n1. Input the students"
	puts "2. Show all of the students"
	puts "3. Save the list to a filename of your choice"
	puts "4. Load the list from a filename of your choice"
	puts "5. Delete a student by name"
	puts "6. Filter students list by cohort"
	puts "9. Exit\n\n"
end

def process_menu(user_input)
	case user_input
	when 1
		input_student
	when 2
		list_students_header
		puts list_students
		list_students_footer
	when 3
		save_students_list(get_save_filename)
	when 4
		load_students(get_load_filename)
	when 5
		delete_student(get_delete_name)
	when 6
		puts filter_students(get_filter_cohort)
	when 9
		exit
	else
		"I don't know what you meant, try again!"
	end
end

def input_student
	puts "Please enter the names of the students.\nTo finish, just hit return twice."
	prompt
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
	prompt
	gets.chomp.to_i
end

def get_save_filename
	puts "What filename do you want to save to?"
	prompt
	gets.chomp
end

def get_load_filename
	puts "What's the name of the filename?"
	prompt
	gets.chomp
end

def get_delete_name
	puts "Enter the name of the student you want to delete."
	prompt
	gets.chomp
end

def get_filter_cohort
	puts "Which month do you want to filter by?"
	prompt
	gets.chomp
end

def prompt
	print ">> "
end

def list_students_header
	puts "These are the students at Makers Academy"
	puts "----------------------------------------\n\n"
end

def list_students_footer
	puts "\n----------------------------------------"
	puts "Overall, we have #{students.count} #{pluralisation} at Makers!"
end


def pluralisation
	students.length == 1 ? "student": "students"
end

# interactive_menu