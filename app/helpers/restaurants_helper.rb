module RestaurantsHelper
  def change_locale locale
    request.env['REQUEST_PATH'] + "?locale=#{locale}"
  end
end

