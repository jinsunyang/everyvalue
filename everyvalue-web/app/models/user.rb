class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable, :validatable, authentication_keys: [:name], password_length: 8..128

  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z,A-Z])        # Must contain a character
    # (?=.*[a-z])        # Must contain a lower case character
    # (?=.*[A-Z])        # Must contain an upper case character
    # (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  #override devise validatable on password
  validates :password, presence: true, format: { with: PASSWORD_FORMAT }, confirmation: true, on: :create
  validates :password, allow_nil: true, format: { with: PASSWORD_FORMAT }, confirmation: true, on: :update

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  include BaseUser

  #override devise's methods for email validation incapacitate when validatable devise option activated
  #####################################################################################################
  def email_required?
    false
  end

  def email_changed?
    false
  end
  ######################################################################################################
end
