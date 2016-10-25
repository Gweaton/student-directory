$line_width = 50

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  # create an empty array
  students = []
  # get the first name
  puts "Name:"
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter the student's hobbies:"
    hobbies = gets.chomp
    puts "Enter country of birth:"
    birthcountry = gets.chomp
    # add the student hash to the array
    students << {name: name, hobbies: hobbies, cohort: :november, birthcountry: birthcountry}
    puts "Now we have #{students.count} students."
    # get another name from the user
    puts "Please enter another name:"
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
end

def print(students)
  line_width = 50
  students.each_with_index do |(student, cohort), index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]})".center($line_width)
    puts "Hobbies: #{student[:hobbies]}".center($line_width)
    puts "Country of Birth: #{student[:birthcountry]}".center($line_width)
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

def filter_by_length(students)
  puts "Printing students with names of fewer than 12 characters:"
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]})" if student[:name].length < 12
  end
end

students = input_students
print_header
print(students)
print_footer(students)
