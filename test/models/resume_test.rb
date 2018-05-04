# == Schema Information
#
# Table name: resumes
#
#  id              :integer          not null, primary key
#  title           :string
#  description     :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  cv_file_name    :string
#  cv_content_type :string
#  cv_file_size    :integer
#  cv_updated_at   :datetime
#  user_id         :integer
#

require 'test_helper'

class ResumeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
