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
	CSV.foreach(filename) do |line|
		name, cohort, year = line[0], line[1], line[2]
		students << {name: name, cohort: cohort.to_sym, year: year.to_i}
	end
end
