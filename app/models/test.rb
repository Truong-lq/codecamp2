class Test < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :title, presence: true
end
