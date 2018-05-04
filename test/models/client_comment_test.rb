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

require 'test_helper'

class ClientCommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
