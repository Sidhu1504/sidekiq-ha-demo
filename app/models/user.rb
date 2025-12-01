# app/models/user.rb
class User < ApplicationRecord
  # you already have fields: name, age, dob, department, email
  has_many :job_logs

  # allow passwords but don't force them for old records
  has_secure_password validations: false

  # Optional: you can tighten this later if you want
  validates :email, presence: true, uniqueness: true
end

