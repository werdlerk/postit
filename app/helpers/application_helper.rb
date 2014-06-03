module ApplicationHelper

  def safe_url(url)
    url.starts_with?("http://") ? url : "http://#{url}"
  end
end
