7#encoding: utf-8
require 'ostruct'

class Contract
  @@contrats = [
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08852C',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([2, 3, 5, 12]),
      :finished_course_number => 0,
      :user => User.find(2),
      :sign_date => Date.new(2011, 1, 15),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08412Z',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([2, 3, 5]),
      :finished_course_number => 0,
      :user => User.find(23),
      :sign_date => Date.new(2013, 1, 15),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08125M',
      :man_per_day => 14,
      :class_per_day => 2,
      :courses => Course.find([2, 3, 5]),
      :finished_course_number => 0,
      :user => User.find(24),
      :sign_date => Date.new(2013, 1, 15),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08847C',
      :man_per_day => 17,
      :class_per_day => 2,
      :courses => Course.find([2, 3, 5]),
      :finished_course_number => 0,
      :user => User.find(22),
      :sign_date => Date.new(2013, 1, 15),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08753C',
      :man_per_day => 23,
      :class_per_day => 4,
      :courses => Course.find([2, 3, 5, 7, 9, 10, 11, 12]),
      :finished_course_number => 3,
      :user => User.find(21),
      :sign_date => Date.new(2013, 2, 25),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08278L',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([2, 3, 5]),
      :finished_course_number => 0,
      :user => User.find(3),
      :sign_date => Date.new(2013, 1, 15),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08724X',
      :man_per_day => 23,
      :class_per_day => 5,
      :courses => Course.find([2, 3, 5, 11, 15, 18, 6]),
      :finished_course_number => 0,
      :user => User.find(22),
      :sign_date => Date.new(2013, 4, 1),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08782D',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([2, 3, 5]),
      :finished_course_number => 0,
      :user => User.find(23),
      :sign_date => Date.new(2013, 5, 15),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08512E',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([2, 3, 5, 9, 12]),
      :finished_course_number => 1,
      :user => User.find(3),
      :sign_date => Date.new(2013, 5, 18),
      :price => 120000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08154C',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([12, 14, 15, 17, 19, 20]),
      :finished_course_number => 5,
      :user => User.find(25),
      :sign_date => Date.new(2013, 6, 12),
      :price => 350000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08202I',
      :man_per_day => 16,
      :class_per_day => 3,
      :courses => Course.find([12, 14, 15, 17, 19, 20]),
      :finished_course_number => 2,
      :user => User.find(23),
      :sign_date => Date.new(2013, 6, 22),
      :price => 350000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08213K',
      :man_per_day => 8,
      :class_per_day => 1,
      :courses => Course.find([12, 14, 15, 17, 19, 20]),
      :finished_course_number => 1,
      :user => User.find(26),
      :sign_date => Date.new(2013, 8, 8),
      :price => 350000
    ),
    OpenStruct.new(
      :contract_id => 'ASD0013CMD08382A',
      :man_per_day => 25,
      :class_per_day => 3,
      :courses => Course.find([12, 14, 15, 17, 19, 20]),
      :finished_course_number => 7,
      :user => User.find(25),
      :sign_date => Date.new(2013, 9, 12),
      :price => 350000
    ),
    OpenStruct.new(
      :contract_id => 'ASD1103CMD08302D',
      :man_per_day => 13,
      :class_per_day => 1,
      :courses => Course.find([11, 12, 14, 15, 17, 19, 20]),
      :finished_course_number => 2,
      :user => User.find(3),
      :sign_date => Date.new(2012, 10, 12),
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
      @@contrats[11]
    end
  end
end