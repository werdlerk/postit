module ApplicationHelper

  def safe_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end

  def display_url(url)
    if url.nil?
      return nil

    url = url.sub("http://","").sub("www.","")
    url[0...url.index("/")]
  end

  def format_datetime(datetime)
    datetime.strftime("%-m %b %Y, %H:%M")
  end

  def abbreviate(str)
    if str.length < 150
      str
    else
      str[0..str.rindex(" ", 150)] + "..."
    end
  end
  
end
