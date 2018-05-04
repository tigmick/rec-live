# == Schema Information
#
# Table name: candidate_feedbacks
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  feedback              :string
#  client                :boolean
#  interview_schedule_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class CandidateFeedback < ActiveRecord::Base
	belongs_to :interview_schedule
	belongs_to :user
end
