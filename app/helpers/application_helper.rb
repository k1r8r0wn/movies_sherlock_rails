module ApplicationHelper
  def greetings
    current_time = Time.now.to_i
    midnight = Time.now.beginning_of_day.to_i
    noon = Time.now.middle_of_day.to_i
    six_pm = Time.now.change(:hour => 18 ).to_i
    ten_pm = Time.now.change(:hour => 22 ).to_i

    case
    when midnight.upto(noon).include?(current_time)
      t('main.auth_toolbar.greetings.morning')
    when noon.upto(six_pm).include?(current_time)
      t('main.auth_toolbar.greetings.afternoon')
    when six_pm.upto(ten_pm).include?(current_time)
      t('main.auth_toolbar.greetings.evening')
    when ten_pm.upto(midnight + 1.day).include?(current_time)
      t('main.auth_toolbar.greetings.night')
    end
  end
end
