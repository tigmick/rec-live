# == Schema Information
#
# Table name: user_jobs
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  job_ids    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserJob < ActiveRecord::Base
	belongs_to :user
  belongs_to :candidate, foreign_key: :candidate_id,class_name: "User"
  belongs_to :job
	serialize :job_ids, Array
end
