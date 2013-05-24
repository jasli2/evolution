# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(128)      not null
#  manager_id       :integer
#  birthday         :date
#  joined_at        :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  position_id      :integer
#  password_digest  :string(255)
#  name             :string(255)
#  is_admin         :boolean          default(FALSE)
#  avatar           :string(255)
#  staff_id         :integer
#  phone_num        :integer
#  mobile_phone     :integer
#  department       :string(255)
#  department_level :integer
#

require 'spec_helper'

describe User do
  it { should belong_to :manager }
  it { should belong_to :position }
  it { should have_many :subordinates }
  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should_not allow_value("blah").for(:email) }
  it { should allow_value("a@b.com").for(:email) }

  subject {FactoryGirl.create(:user)}

  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }

  describe "factory" do
    it "should has a valid factory" do
      should be_valid
      puts "test password password_digest is " + subject.password_digest
    end
  end

  describe "validations" do  
    it "should has unique email address" do
      u = subject
      FactoryGirl.build(:user, :email => u.email).should_not be_valid
    end
  end

  describe "user email valid" do
    it "should check email" do
      u = FactoryGirl.build(:user, :email => "longl")
      u.should_not be_valid
    end
  end

end
