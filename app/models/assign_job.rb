# == Schema Information
#
# Table name: assign_jobs
#
#  id         :integer          not null, primary key
#  job_id     :integer
#  user_ids   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AssignJob < ActiveRecord::Base
	belongs_to :job
	serialize :user_ids, Array
end
