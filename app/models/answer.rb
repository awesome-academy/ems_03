class Answer < ApplicationRecord
  belongs_to :question
  has_many :detail_exam_answers
  has_many :detail_exams, through: :detail_exam_answers

  validates :content, presence: true
end
