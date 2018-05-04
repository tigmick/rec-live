# == Schema Information
#
# Table name: client_comments
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  client                :boolean
#  comment               :string
#  interview_schedule_id :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class ClientComment < ActiveRecord::Base
	belongs_to :interview_schedule
	belongs_to :user
end
