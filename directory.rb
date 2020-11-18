@students = []
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  get_name
end

def get_name
  name = STDIN.gets.chomp
  while !name.empty? do
    add_student(name, get_cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
  end
end

def get_cohort
  puts "Cohort: "
  cohort = STDIN.gets.chomp.to_sym
  if cohort.empty? then
    cohort = "november"
  end
  return cohort
end


def print_header
  puts   "The students of Villains Academy".center(60)
  puts "-------------".center(60)
end


def print_students_list
  if @students.empty? then
    return
  else
    print_cohorts
  end
end


def cohort_list
  cohorts = []
  @students.map { |student| if !cohorts.include?(student[:cohort]) then cohorts << student[:cohort] end }
  return cohorts
end


def print_cohorts
  cohort_list.each do |cohort|
      puts ""
      puts cohort.to_s.center(60)
      print_students(cohort)
  end
end


def print_students(cohort)
  count = 0
  @students.each do |student|
    if cohort == student[:cohort]
      puts "#{count+1}. #{student[:name]} (#{student[:cohort]} cohort)".center(60)
      count += 1
    end
  end
end


def print_footer
  @students.length > 1 ? plural_string = "s" : plural_string = ""
  puts ""
  puts "Overall, we have #{@students.count} great student#{plural_string}".center(60)
  puts ""
end


def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end


def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end


def show_students
  print_header
  print_students_list
  print_footer
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
      puts "I don't know what you meant, try again"
  end
end


def get_filename
  puts "Enter filename: "
  return gets.chomp
end


def save_students
  File.open(get_filename, "w") do |file|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts(csv_line)
    end
  puts "Student list saved to #{file.path}"
  end
end


def load_students()
  File.open(get_filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      add_student(name, cohort)
    end
  puts "Loaded #{@students.count} from #{file.path}"
  end
end


def try_load_students
  filename = ARGV.first
  if filename.nil? then
    return
  else
    if File.exists?(filename)
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
