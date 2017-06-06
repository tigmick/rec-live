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
