class User < ApplicationRecord
  has_many :results
  
  after_create :set_admin_if_first_user

  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  def admin?
    admin
  end

  private

  def set_admin_if_first_user
    update(admin: true) if User.count == 1
  end
end
