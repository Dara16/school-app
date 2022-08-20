class User < ApplicationRecord
    before_save :downcase_email

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true

    has_secure_password

    private

    def downcase_email
        self.email = email.downcase
    end
end


end
