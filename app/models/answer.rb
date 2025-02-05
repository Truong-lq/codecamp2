class Answer < ApplicationRecord
  belongs_to :question

  validates :content, presence: true

  def is_correct?
    is_correct
  end
end
