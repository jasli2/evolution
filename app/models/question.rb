class Question < ActiveRecord::Base
  attr_accessible :answer, :qdata

  validates :answer, :presence => true
  validates :qdata, :presence => true

  belongs_to :examination

end
