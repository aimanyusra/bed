class User < ApplicationRecord
	include Clearance::User

	has_many :listings, :dependent => :destroy
	has_many :authentications, :dependent => :destroy
	# validates :email, presence: true, uniqueness: true
	# validates :password, presence: true
	validates :age, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true


	def self.create_with_auth_and_hash(authentication, auth_hash)
		user = User.create!(first_name: auth_hash[:extra]["raw_info"].first_name, last_name: auth_hash[:extra]["raw_info"].last_name, email: auth_hash["extra"]["raw_info"]["email"], age: auth_hash[:extra]["raw_info"]["age_range"].min[1])
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
