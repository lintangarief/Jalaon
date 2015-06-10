class User < ActiveRecord::Base
  after_save :check_verify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :first_name, :last_name, :email, presence: true

  mount_uploader :avatar, AvatarUserUploader
  include Amistad::FriendModel
  paginates_per 20
  has_many :services
  has_one :verify_user

  def check_verify
    checkverify = self.verify_user
    if checkverify == nil
      VerifyUser.create!(current_user)
    end
  end
end