module PostHelper
  def format_description(text)
    text.gsub("\n","<br/>")
  end

end