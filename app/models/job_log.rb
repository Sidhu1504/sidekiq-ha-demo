class JobLog < ApplicationRecord
  belongs_to :user, optional: true
end

