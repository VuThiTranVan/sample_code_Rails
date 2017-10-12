class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: I18n.t("activation.mailer.subject")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: I18n.t("users.reset_password.subject_mail")
  end
end
