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

require 'test_helper'

class CandidateFeedbackTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
