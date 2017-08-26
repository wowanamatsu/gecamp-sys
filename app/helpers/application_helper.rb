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


  def data_mask(data)
    data_formt = data.to_s[8..10] + '/' + data.to_s[5..6] + '/' + data.to_s[0..3] if data
  end

  def idade(data)
    if data
      (DateTime.now.year - data.year).to_s + ' anos'
    else
      '------'
    end
  end

end
