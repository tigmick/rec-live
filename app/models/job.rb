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

class Job < ActiveRecord::Base
  belongs_to :industry
  belongs_to :user
  has_many :reviews

  has_one :interview
  has_one :assign_job
  has_many :interview_schedules, through: :interview

  has_attached_file :document,
  :url  => "/assets/jobs/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/jobs/:id/:style/:basename.:extension"

  validates_attachment_file_name :document, matches: [/\.(pdf|(docx?)|dot|wrd)\z/]
  include PgSearch
  multisearchable :against => [:title]

  enum status: [ :open, :closed ]

  def status_string
    open? ? 'open' : 'clos'
  end
end
