class Poll < ActiveRecord::Base

  validates :title, :author_id, presence: true
  validates :title, uniqueness: true

  belongs_to :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: :User

  has_many :questions,
    foreign_key: :poll_id,
    primary_key: :id,
    class_name: :Question 


end
