class User < ActiveRecord::Base
  has_many :army_lists, :dependent => :destroy
  belongs_to :favorite_army, :class_name => 'Army'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :email_regexp => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :favorite_army_id

  def update_with_password(params={})
    params.delete :current_password
    self.update_without_password params
  end
end
