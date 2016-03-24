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

    counts = answer_choices.joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .select("answer_choices.text, COUNT(responses.id) AS num_responses")
      .group("answer_choices.id")

    counts.each do |answer_choice|
      q_results[answer_choice.text] = answer_choice.num_responses
    end

    q_results
  end

end
