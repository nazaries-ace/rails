class User < ActiveRecord::Base
    has_many :articles
    before_save { self.email = email.downcase }
    
    VALID_EMAIL_REGEX =  /\A(?=[A-Z0-9][A-Z0-9@._%+-]{5,253}+$)[A-Z0-9._%+-]{1,64}+@(?:(?=[A-Z0-9-]{1,63}+\.)[A-Z0-9]++(?:-[A-Z0-9]++)*+\.){1,8}+[A-Z]{2,63}+\z/i

    validates :username, uniqueness: { case_sensitive: false }, presence: true, length: { minimum: 3, maximum: 25 }
    validates :email, uniqueness: { case_sensitive: false }, presence: true, length: { minimum: 6, maximum: 50 },
                format: { with: VALID_EMAIL_REGEX }
end