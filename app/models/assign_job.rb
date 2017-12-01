class AssignJob < ActiveRecord::Base
	belongs_to :job
	serialize :user_ids, Array
end
