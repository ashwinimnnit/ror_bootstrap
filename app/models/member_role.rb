class MemberRole < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  has_many :posts
  validates :user_id, uniqueness: { scope: :role_id }

  def self.role_assignment(param)
    roles_to_added = param["roles"].map(&:to_i)
    param["users"].map(&:to_i).each do |uid|
      user = User.find_by_id(uid)
      next unless user
      roles_to_added.each do |new_role|
        user.member_role << MemberRole.create(user_id: user.id, role_id: new_role)
      end
    end
  end
end
