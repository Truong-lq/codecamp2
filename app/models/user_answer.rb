class UserAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  belongs_to :answer
  belongs_to :test
  belongs_to :result
end
