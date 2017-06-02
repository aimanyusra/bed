class User < ApplicationRecord
	include Clearance::User

	mount_uploader :avatar, AvatarUploader
	has_many :listings, :dependent => :destroy
	has_many :authentications, :dependent => :destroy
	has_many :bookings, :dependent => :destroy
	# validates :email, presence: true, uniqueness: true
	# validates :password, presence: true
	validates :age, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true

	# you can also explicitly define enum as:  enum access_level: [:employee => 0, :company_admin => 1, :super_admin => 2}
  	enum access_level: [:customer, :moderator, :superadmin]


	def self.create_with_auth_and_hash(authentication, auth_hash)
		user = User.create!(first_name: auth_hash[:extra]["raw_info"].first_name, last_name: auth_hash[:extra]["raw_info"].last_name, email: auth_hash["extra"]["raw_info"]["email"], age: auth_hash[:extra]["raw_info"]["age_range"].min[1], gender: auth_hash[:extra]["raw_info"].gender)
		user.authentications << (authentication)      
	return user
	end

	def fb_token
		x = self.authentications.where(:provider => :facebook).first
	return x.token unless x.nil?
	end

	def password_optional?
	  true
  	end
end
