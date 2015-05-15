class UserMailer < ApplicationMailer
  default from: 'from@example.com'

  def activation_email(user)
    @url = "#{users_url}/activate?activation_token=#{user.activation_token}"
    mail(to: user.email, subject: "Activate your Music App account!")
  end
end
