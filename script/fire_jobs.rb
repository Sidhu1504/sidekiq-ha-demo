puts "Triggering bulk Sidekiq jobs..."

user = User.last

100.times do |i|
  DemoJob.perform_later(user.id)
  puts "Triggered job #{i + 1}"
end

puts "All jobs triggered!"
