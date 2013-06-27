# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  source_type :string(255)
#  source_id   :integer
#  finish_at   :datetime
#  deadline    :datetime
#  todo_type   :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Todo < ActiveRecord::Base
  attr_accessible :deadline, :finish_at, :source, :todo_type, :user_id

  validates :deadline, :presence => true
  validates :user_id, :presence => true
  validates :todo_type , :presence => true

  belongs_to :user
  belongs_to :source, :polymorphic => true

  validates :source, :presence => true

  def finished?
    !finish_at.nil?
  end
end
