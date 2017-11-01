module UsersHelper
  def expose_recaptcha_when_signing_up
    puts "in helper : #{resource.present?}"
    puts "in helper recaptcha field : #{params.key?('g-recaptcha-response')}"
    puts "in helper cookies present? : #{cookies[:recaptcha]}"

    if resource.present?
      user = User.find_by_name(resource.name)
      if (cookies[:ID_RCP].present?) || (params.key?('g-recaptcha-response')) || (user.present? && user.failed_attempts >= User::RECAPTCHA_EXPOSURE_LOGIN_ATTEMPT_COUNT)
        set_recaptcha_cookies
        flash[:recaptcha_error]
        recaptcha_tags
      end
    end
  end

  private
  def set_recaptcha_cookies
    cookies.encrypted[:ID_RCP] = {
        value: 'RECAPTCHACTIVATEDCAUSEOFFAILUREOFLOGIN',
        expires: 5.minutes.from_now,
        domain: request.domain
    }
  end
end
