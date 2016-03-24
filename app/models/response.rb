class Response < ActiveRecord::Base
  validates :answer_choice_id, :user_id, presence: true
  validate :not_duplicate_response
  validate :not_poll_author
  
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

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

#revisit this
  def respondent_already_answered?
    sibling_responses.any? {|sibling| sibling.user_id == user_id }
  end

  private
  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << "can't submit more than one response per question"
    end
  end

  def not_poll_author
    if question.poll.author_id == user_id
      errors[:user_id] << "cannot answer own poll"
    end
  end



end
