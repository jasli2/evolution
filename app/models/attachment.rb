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

class Attachment < ActiveRecord::Base
  attr_accessible :attachable_id, :attachable_type, :description, :file

  belongs_to :attachable, :polymorphic => true

  mount_uploader :file, AttachmentUploader
end
