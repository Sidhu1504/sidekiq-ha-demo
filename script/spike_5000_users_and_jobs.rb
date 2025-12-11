puts "⚡ SPIKE TEST: Creating 5000 users & triggering 5000 jobs instantly..."

departments = ["IT", "HR", "Finance", "Ops", "Sales"]

start_time = Time.now

5000.times do |i|
  name  = "SpikeUser#{i + 1}"
  email = nil                            # ✅ NO EMAIL
  age   = rand(20..85)
  dob   = Date.today - age.years

  user = User.create!(
    name: name,
    age: age,
    dob: dob,
    department: departments.sample,
    email: email
  )

  DemoJob.perform_later(user.id)
end

end_time = Time.now

puts "5000 USERS + JOBS ENQUEUED!"
puts "⏱ Total enqueue time: #{(end_time - start_time).round(2)} seconds"
