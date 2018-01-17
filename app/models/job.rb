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
end
