class Option < ActiveRecord::Base
  attr_accessible :content, :question_id

  validates :content, :presence => true
  validates :question_id, :presence => true

  belongs_to :question

end
