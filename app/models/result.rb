class Result < ApplicationRecord
  belongs_to :test
  belongs_to :user

  scope :by_test_user, ->(test, user) { where(test: test, user: user).order created_at: :desc }
end
