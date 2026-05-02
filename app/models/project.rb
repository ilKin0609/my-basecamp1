class Project < ApplicationRecord
  belongs_to :user

  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  has_many :topics, dependent: :destroy
  has_many :tasks, dependent: :destroy

  has_many_attached :attachments

  validates :name, presence: true

  
  after_create :add_creator_as_admin

 
  def all_participants
    ([user] + members).uniq
  end

 
  def admin?(user)
    return true if self.user == user
    memberships.find_by(user: user)&.is_admin == true
  end

  private

  def add_creator_as_admin
    memberships.create(user: user, is_admin: true)
  end
end
