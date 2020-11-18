# create an empty array
@students = []
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  # get the first name
  name = STDIN.gets.delete("\n")
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get cohort
    puts "Cohort: "
    cohort = STDIN.gets.chomp.to_sym
    if cohort.empty? then
      cohort = "november"
    end
    # get hobby
    #puts "Hobby: "
    #hobby = gets.chomp

    # add the student hash to the array
    add_student(name, cohort)
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
  # return the array of students
  @students
end

def print_header
  puts   "The students of Villains Academy".center(60)
  puts "-------------".center(60)
end
# somthing
def print_students_list
  # find distinct cohorts
  if @students.empty? then
    return
  else
    cohorts = []
    @students.map { |student| if !cohorts.include?(student[:cohort]) then cohorts << student[:cohort] end }

      # iterate over cohorts array
      cohorts.each do |cohort|
        puts ""
        puts cohort.to_s.center(60)
        count = 0
        # while !students[count].nil? do
        # if students[count][:name][0].downcase == "c" && students[count][:name].length < 12 then
        @students.each do |student|
          if cohort == student[:cohort]
            puts "#{count+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(60)
            count += 1
          end
        end
      end
    end
end

def print_footer
  @students.length > 1 ? plural_string = "s" : plural_string = ""
  puts "Overall, we have #{@students.count} great student#{plural_string}".center(60)
end

def interactive_menu
  loop do
    # 1. print the menu and ask the user what to do
    # 2. read the input and save it into a variable

    print_menu
    process(STDIN.gets.chomp)
    # 3. do what the user has asked
  end
end

def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the lost from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
  # 2. read the input and save it into a variable
end

def show_students
  print_header
  print_students_list
  print_footer
end

def process(selection)
  case selection
    when "1"
      # input the students
      @students = input_students
    when "2"
      # show the students
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # this will casue the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def save_students
  # open file to writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts(csv_line)
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student(name, cohort)
  end
  file.close
  puts "Loaded #{@students.count} from #{filename}"
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? then
    load_students
  else # get out of the method if it isn't given
    if File.exists?(filename) # if it exists
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist
      puts "Sorry, #{filename} doesn't exist."
      exit # quit the program
    end
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end


try_load_students
interactive_menu
