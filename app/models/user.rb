class User < ApplicationRecord
  has_many :job_logs

  has_secure_password validations: false

  validates :email, uniqueness: true, allow_blank: true
end

