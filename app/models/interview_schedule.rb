# == Schema Information
#
# Table name: interview_schedules
#
#  id                    :integer          not null, primary key
#  interview_id          :integer
#  stage                 :integer
#  interview_avail_dates :string
#  interviewers_names    :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#  next_step             :integer
#  next_step_desc        :string
#

class InterviewSchedule < ActiveRecord::Base
	serialize :interview_avail_dates, Hash
	serialize :interviewers_names, Array
	validates_inclusion_of :stage, :in => 0..10
	validates_inclusion_of :next_step, :in => 0..10 ,:allow_nil => true
	# has_many :interviews
 #  has_many :jobs, through: :interviews
   belongs_to :interview
   has_many :candidate_feedbacks
   has_many :client_comments
end
