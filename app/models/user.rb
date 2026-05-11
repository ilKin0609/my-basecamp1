class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :projects, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :member_projects, through: :memberships, source: :project

  
  after_create :make_first_user_admin

  def admin?
    is_admin == true
  end

  private

  def make_first_user_admin
    if User.count == 1
      update(is_admin: true)
    end
  end
end