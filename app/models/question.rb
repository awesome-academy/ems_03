class Question < ApplicationRecord
  QUESTION_PARAMS = [:content, :question_type, :level, :subject_id, :user_id,
  answers_attributes: [:id, :content, :correct, :_destroy]].freeze

  belongs_to :subject
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :exam_questions
  has_many :exams, through: :exam_questions

  delegate :name, to: :subject, prefix: true
  delegate :content, :correct, to: :answers, prefix: true

  validates_presence_of :answers

  accepts_nested_attributes_for :answers,
    allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}

  scope :sort_by_name, ->{order :content}
  scope :get_by_id, ->(id){where subject_id: id}
  scope :get_level, ->(level){where level: level}
  scope :get_by_level_and_subject,
    ->(level, id){where("level = ? and subject_id = ?", level, id)}

  enum level: {easy: 1, normal: 2, hard: 3}
  enum question_type: {single_choice: 1, multi_choice: 2}

  validates :content, presence: true,
    length: {maximum: Settings.maximum_length_question_content},
    uniqueness: {case_sensitive: false}

  def subject_id
    subject.id
  end
end
