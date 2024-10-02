
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
user1 = User.create!(
  email: "jon.snow@example.com",
  password: "password123",        # Devise will encrypt this
  password_confirmation: "password123",  # Confirmation for validation
  first_name: "Jon",
  last_name: "Snow"
)
user2 = User.create!(
  email: "daenerys.targaryen@example.com",
  password: "dragonqueen123",     # Devise will encrypt this
  password_confirmation: "dragonqueen123",  # Confirmation for validation
  first_name: "Daenerys",
  last_name: "Targaryen"
)

puts "Users created."

# Create Categories
puts "Creating categories..."
category1 = Category.create!(name: "Technology")
category2 = Category.create!(name: "Health")
category3 = Category.create!(name: "Finance")

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

# Create Questions
puts "Creating questions..."
question1 = Question.create!(
  content: "What are the best coding practices?",
  pulse_category: pulse_category1
)
question2 = Question.create!(
  content: "How can I improve my health?",
  pulse_category: pulse_category2
)

puts "Questions created."

# Create Answers
puts "Creating answers..."
Answer.create!(
  content: "Use version control and write unit tests.",
  question: question1,
  chat_review: "Good advice!"
)
Answer.create!(
  content: "Eat more vegetables and exercise regularly.",
  question: question2,
  chat_review: "Solid tips!"
)

puts "Answers created."
puts "Seeding completed successfully!"
