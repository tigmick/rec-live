# == Schema Information
#
# Table name: jobs
#
#  id                    :integer          not null, primary key
#  title                 :string
#  description           :text
#  industry_id           :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  status                :integer          default(0)
#  closed_at             :datetime
#

require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
