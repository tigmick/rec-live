# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string
#  first_name             :string
#  last_name              :string
#  contact_no             :string
#  current_location       :string
#  resume_file_name       :string
#  resume_content_type    :string
#  resume_file_size       :integer
#  resume_updated_at      :datetime
#  salary_expectation     :string
#  verify_candidate       :boolean          default(FALSE)
#  job_title              :string
#  company_name           :string
#  status                 :boolean          default(FALSE)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = ['client','candidate']

  has_many :resumes
  has_many :jobs
  has_one :user_job, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def client?
    role == "client"
  end

  def candidate?
    role == "candidate"
  end

  def full_name
    first_name+" "+last_name
  end

  def active_for_authentication?
    # Uncomment the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml
    if self.role == "client" && self.status == false
      false
    else
      super
    end
  end

end
