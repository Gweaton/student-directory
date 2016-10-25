$line_width = 50
@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_students
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  # create an empty array
  cohorts = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  # get the first name
  puts "Name:"
  name = gets.chomp
  while name.empty? do
    puts "Please type something, or 'quit' to exit:"
    name = gets.chomp
    if name == 'quit'
      exit
    end
  end
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter the student's hobbies:"
    hobbies = gets.chomp
    puts "Enter country of birth:"
    birthcountry = gets.chomp
    puts "Enter their cohort:"
    cohort = gets.chomp.capitalize
    if (cohorts.include? cohort) == false
      cohort = "unknown"
    end
    # add the student hash to the array
    @students << {name: name, hobbies: hobbies, cohort: cohort, birthcountry: birthcountry}
    puts "Now we have #{@students.count} students."
    # get another name from the user
    puts "Please enter another name:"
    name = gets.chomp
  end
  # return the array of students
  @students
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
    end
  end

def print_header
  puts "The students of Villains Academy".center($line_width)
  puts "-------------".center($line_width)
end

def print_students_list
  line_width = 50
  @students.each_with_index do |(student, cohort), index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]})".center($line_width)
    puts "Hobbies: #{student[:hobbies]}".center($line_width)
    puts "Country of Birth: #{student[:birthcountry]}".center($line_width)
  end
end

def print_footer
  if @students.length == 1
    num = "student"
  else num = "students"
  end
  puts "Overall, we have #{@students.count} great #{num}."
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu


# def sort_by_cohort
#   sorted = @students.sort_by {|hash| hash[:cohort]}
#   sorted.each_with_index do |student, index|
#     puts "#{sorted[index][:cohort]}, #{sorted[index][:name]}"
#   end
# end
#
# def filter
#   puts "Which letter would you like to filter by?"
#   letter = gets.chomp.upcase
#   puts "Results:"
#   @students.each_with_index do |(student, cohort), index|
#     puts "#{student[:name]} (#{student[:cohort]})" if student[:name][0] == letter
#   end
# end
#
# def filter_by_length
#   puts "Printing students with names of fewer than 12 characters:"
#   @students.each do |student|
#     puts "#{student[:name]} (#{student[:cohort]})" if student[:name].length < 12
#   end
# end
