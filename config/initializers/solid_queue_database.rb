
if Rails.env.production?
  if defined?(SolidQueue::Record)
    SolidQueue::Record.establish_connection :production
  end
end
