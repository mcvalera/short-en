
class User < ActiveRecord::Base

  has_many :urls

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates_format_of :email, :with => /[\w]+[@][\w]+[.][\w]{2,}/

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

end
