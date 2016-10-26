$line_width = 50
@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
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
    if @students.count == 1
      num = "student"
    else num = "students"
    end
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
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
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
    process(STDIN.gets.chomp)
  end
end

def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
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

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method if it isn't given
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
