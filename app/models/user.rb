class User < ApplicationRecord
  after_create :set_admin_if_first_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    admin
  end

  private

  def set_admin_if_first_user
    update(admin: true) if User.count == 1
  end
end
