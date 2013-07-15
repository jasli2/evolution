# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  source_type       :string(255)
#  source_id         :integer
#  notification_type :string(255)
#  viewed_at         :datetime
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Notification do
  pending "add some examples to (or delete) #{__FILE__}"
end
