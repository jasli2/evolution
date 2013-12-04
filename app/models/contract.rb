#encoding: utf-8
require 'ostruct'

class Contract
  @@contrats = [
    OpenStruct.new(
      :contract_id => '55103030422AC',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([2, 3, 5]),
      :user => User.find(4),
      :sign_date => Date.new(2013, 1, 15),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => '51993233184022',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([12, 14, 15, 17, 19, 20]),
      :user => User.find(5),
      :sign_date => Date.new(2013, 1, 15),
      :price => 350000
    )
  ]

  class << self
    def all
      @@contrats
    end

    def find_by_user_name(name)
      @@contrats.select do |c|
        c.user.name == name
      end
    end

    def find(id)
      @@contrats[id-1] if id < @@contrats.count
    end
  end
end