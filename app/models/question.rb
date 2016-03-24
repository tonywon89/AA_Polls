class Question < ActiveRecord::Base

  validates :text, :poll_id, presence: true

  belongs_to :poll,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: :Poll

  has_many :answer_choices,
    foreign_key: :question_id,
    primary_key: :id,
    class_name: :AnswerChoice

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    q_results = {}
    answer_choices.each do |a_choice|
      q_results[a_choice.text] = a_choice.responses.count
    end
    q_results
  end

end
