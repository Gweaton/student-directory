def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students."
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each_with_index do |(student, cohort), index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]})"
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students."
end

def filter(students)
  puts "Which letter would you like to filter by?"
  letter = gets.chomp.upcase
  puts "Results:"
  students.each_with_index do |(student, cohort), index|
    puts "#{student[:name]} (#{student[:cohort]})" if student[:name][0] == letter
  end
end

students = input_students
print_header
#print(students)
filter(students)
#print_footer(students)
