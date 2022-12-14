class User < ApplicationRecord
    CONFIRMATION_TOKEN_EXPIRATION = 10.minutes

    before_save :downcase_email

    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true, presence: true

    has_secure_password

    def confirm!
        update_columns(confirmed_at: Time.now)
    end

    def confirmed?
        confirmed_at.present?
    end

    def generate_confirmation_token
        signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
    end

    def unconfirmed?
        !confirmed?
    end

    private

    def downcase_email
        self.email = email.downcase
    end
end


end
