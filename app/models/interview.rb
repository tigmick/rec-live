# == Schema Information
#
# Table name: interviews
#
#  id          :integer          not null, primary key
#  job_id      :integer
#  total_stage :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Interview < ActiveRecord::Base
	belongs_to :job
  has_many :interview_schedules
  validates_inclusion_of :total_stage, :in => 1..10
end
