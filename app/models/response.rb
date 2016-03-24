class Response < ActiveRecord::Base
  validates :answer_choice_id, :user_id, presence: true

  belongs_to :respondent,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  belongs_to :answer_choice,
    foreign_key: :answer_choice_id,
    primary_key: :id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

end
