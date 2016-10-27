@students = []

def print_menu
  puts "Student Directory Menu"
  puts "--------------------------"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a new file"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_students
  cohorts = [:january, :february, :march, :april, :may, :june, :july, :august, :september, :october, :november, :december]
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  # create an empty array
  # get the first name
  puts "Name:"
  name = STDIN.gets.chomp
  while name.empty? do
    puts "Please type something, or 'quit' to exit:"
    name = STDIN.gets.chomp
    if name == 'quit'
      exit
    end
  end
  # while the name is not empty, repeat this code
  while !name.empty? do
    puts "Enter their cohort:"
    cohort = STDIN.gets.chomp.downcase.to_sym
    if (cohorts.include? cohort) == false
      cohort = :unknown
    end
    # add the student hash to the array
    add_student_to_array(name, cohort)
    num = (@students.count == 1)? "student" : "students"
    puts "Now we have #{@students.count} #{num}."
    # get another name from the user
    puts "Please enter another name:"
    name = STDIN.gets.chomp
  end
  # return the array of students
  @students
end

def process(selection)
  case selection
    when "1"
      puts "Inputting students"
      puts
      input_students
    when "2"
      puts "Showing students..."
      puts
      show_students
    when "3"
      puts "Saving students..."
      puts
      save_students
    when "4"
      puts "Loading students..."
      puts
      try_load_students
     when "9"
      puts "Quitting..."
      puts
      exit
    else
      puts "I don't know what you mean, try again"
    end
  end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print_students_list
  line_width = 50
  @students.each_with_index do |(student, cohort), index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]})"
  end
  puts ""
end

def print_footer
  if @students.length == 1
    num = "student"
  else num = "students"
  end
  puts "Overall, we have #{@students.count} great #{num}."
  puts ""
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  #open the file for writing
  filename = user_file
  file = File.open(filename, "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    #join the array into a single string, separated by commas
    csv_line = student_data.join(",")
    #write each csv line to the file "students.csv"
    file.puts csv_line
  end
  file.close
end

def user_file
  puts "Please enter a filename:"
  filename = gets.chomp
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  if filename.nil?
  filename = user_file
  end
   #default file "students.csv" if no arguments from command line
  if File.exists?(filename) #if it exists
    load_students(filename)
      puts "Loaded #{@students.count} from #{filename}."
  else #if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def load_students(filename = "students.csv")
  #given default value, but can open any text file passed
  @students = []
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student_to_array(name, cohort)
   end
  file.close
end

def add_student_to_array(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end



try_load_students
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
