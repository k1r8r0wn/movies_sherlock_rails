module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join

    html = <<-HTML
    <div class="errors">
      <ul class="centered">
        <li>#{messages}</li>
      </ul>
    </div>
    HTML

    html.html_safe
  end
end
