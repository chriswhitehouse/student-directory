def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
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
def print_footer(names)
  names.length > 1 ? plural_string = "s" : plural_string = ""
  puts "Overall, we have #{names.count} great student#{plural_string}".center(140)
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
