def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get hobby
    puts "Hobby: "
    hobby = gets.chomp

    # add the student hash to the array
    students << {name: name, cohort: :november, hobby: hobby}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts   "The students of Villains Academy"
  puts "-------------"
end
# somthing
def print(students)
  count = 0
  while !students[count].nil? do
    if students[count][:name][0].downcase == "c" && students[count][:name].length < 12 then
      puts "#{count+1}. #{students[count][:name]} (#{students[count][:cohort]} cohort) (Favourite hobby: #{students[count][:hobby]})".center(140)
    end
    count += 1
  end
end
def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
