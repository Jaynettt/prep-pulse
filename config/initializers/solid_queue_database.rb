
if Rails.env.production?
  SolidQueue::Record.establish_connection :production
end
