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

require 'test_helper'

class InterviewScheduleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
