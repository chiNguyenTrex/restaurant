class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    locale = params[:locale].strip
    if locale.present? && I18n.available_locales.include?(locale.to_sym)
      session[:language] = locale
    end
    session[:language]
  end
end
