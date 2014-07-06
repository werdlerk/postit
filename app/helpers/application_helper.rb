module ApplicationHelper

  def safe_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end

  def display_url(url)
    url.sub("http://","").sub("www.","")
  end

  def format_datetime(datetime)
    datetime.strftime("%-m %b %Y, %H:%M")
  end
  
end
