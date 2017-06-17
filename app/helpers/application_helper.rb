module ApplicationHelper

  def flash_boostrap
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'

      text = "<script>$.notify('#{message}', '#{type}')</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join('\n').html_safe
  end

end
