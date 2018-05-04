# == Schema Information
#
# Table name: reviews
#
#  id               :integer          not null, primary key
#  job_id           :integer
#  user_id          :integer
#  is_review        :boolean
#  review_count     :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  is_cv_download   :boolean          default(FALSE)
#  cv_download_date :datetime
#  cv_ids           :string
#  meeting          :text
#

class Review < ActiveRecord::Base
	belongs_to :job
	belongs_to :user
	serialize :cv_ids, Array
end
