# == Schema Information
#
# Table name: attachments
#
#  id              :integer          not null, primary key
#  description     :string(255)
#  attachable_id   :integer
#  attachable_type :string(255)
#  file            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Attachment do
  pending "add some examples to (or delete) #{__FILE__}"
end
