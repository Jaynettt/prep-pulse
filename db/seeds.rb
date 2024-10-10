ENV["SEEDING"] = 'true'
puts "Clearing old data..."
Answer.delete_all
Question.delete_all
PulseCategory.delete_all
Category.delete_all
Pulse.delete_all
User.delete_all

puts "Old data cleared."

# Create Users
puts "Creating users..."

# Define the file paths for CVs
cv_file_path_1 = Rails.root.join('app', 'assets', 'cvs', 'Web_Developer_CV_Example.pdf') 
cv_file_path_2 = Rails.root.join('app', 'assets', 'cvs', 'Web_Developer_CV_Example.pdf')

# Check if CV files exist
if File.exist?(cv_file_path_1) && File.exist?(cv_file_path_2)
  user1 = User.create!(
    email: "dhh@rails.com",
    password: "dhh@rails.com",
    password_confirmation: "dhh@rails.com",
    first_name: "Daniel",
    last_name: "Hansen",
    cv_evaluation: "Strong technical skills and leadership qualities."
  )
  user1.cv.attach(
    io: File.open(cv_file_path_1),
    filename: "Web_Developer_CV_Example.pdf",
    content_type: 'application/pdf'
  )

  user2 = User.create!(
    email: "mats@ruby.com",
    password: "mats@ruby.com",
    password_confirmation: "mats@ruby.com",
    first_name: "Mats",
    last_name: "Matsimuto",
    cv_evaluation: "Excellent communication and strategic thinking."
  )
  user2.cv.attach(
    io: File.open(cv_file_path_2),
    filename: "Web_Developer_CV_Example.pdf",
    content_type: 'application/pdf'
  )

  puts "Users created."
else
  puts "Error: One or both CV files do not exist. Please check the file paths."
  exit
end

# Create Categories
puts "Creating categories..."
category1 = Category.create!(name: "Technical Skills")
category2 = Category.create!(name: "Soft Skills")
category3 = Category.create!(name: "Psychometric Skills")

puts "Categories created."

# Create Pulses
puts "Creating pulses..."
pulse1 = Pulse.create!(
  job_role: "Software Engineer",
  job_description: "Builds scalable applications",
  company_name: "Stark Industries",
  company_description: "Leading tech company in the North",
  user: user1
)
pulse2 = Pulse.create!(
  job_role: "Data Analyst",
  job_description: "Analyzes large data sets",
  company_name: "Targaryen Analytics",
  company_description: "Expert data analytics firm",
  user: user2
)

puts "Pulses created."

# Create Pulse Categories
puts "Linking pulses with categories..."
pulse_category1 = PulseCategory.create!(category: category1, pulse: pulse1)
pulse_category2 = PulseCategory.create!(category: category2, pulse: pulse2)
pulse_category3 = PulseCategory.create!(category: category3, pulse: pulse1)

puts "Pulses linked with categories."

puts "Seeding completed successfully!"
ENV["SEEDING"] = 'false'
