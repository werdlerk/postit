module ApplicationHelper

  def safe_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end

  def display_url(url)
    url = url.sub("http://","").sub("www.","")
    
    if url.index("/")
      url[0...url.index("/")]
    else
      url
    end
  end

  def format_datetime(datetime)
    if logged_in? && current_user.time_zone
      datetime = datetime.in_time_zone(current_user.time_zone)
    end
    datetime.strftime("%-m %b %Y, %H:%M (%Z)")
  end

  def abbreviate(str)
    if str.length < 150
      str
    else
      str[0..str.rindex(" ", 150)] + "..."
    end
  end
  
end
