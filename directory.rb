def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.delete("\n")
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get cohort
    puts "Cohort: "
    cohort = gets.chomp.to_sym
    if cohort.empty? then
      cohort = "November 2020"
    end
    # get hobby
    puts "Hobby: "
    hobby = gets.chomp

    # add the student hash to the array
    students << {name: name, cohort: cohort, hobby: hobby}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts   "The students of Villains Academy".center(140)
  puts "-------------".center(140)
end
# somthing
def print(students)
  # find distinct cohorts
  if students.empty? then
    return
  else
    cohorts = []
    students.map { |student| if !cohorts.include?(student[:cohort]) then cohorts << student[:cohort] end }

      # iterate over cohorts array
      cohorts.each do |cohort|
        puts ""
        puts cohort.to_s.center(140)
        count = 0
        # while !students[count].nil? do
        # if students[count][:name][0].downcase == "c" && students[count][:name].length < 12 then
        students.each do |student|
          if cohort == student[:cohort]
            puts "#{count+1}. #{student[:name]} (#{student[:cohort]} cohort) (Favourite hobby: #{student[:hobby]})".center(140)
            count += 1
          end
        end
      end
    end
end

def print_footer(names)
  names.length > 1 ? plural_string = "s" : plural_string = ""
  puts "Overall, we have #{names.count} great student#{plural_string}".center(140)
end

def interactive_menu
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
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

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

interactive_menu
