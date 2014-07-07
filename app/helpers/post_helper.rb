module PostHelper
  def new_line_format(text)
    text.gsub("\n","<br/>")
  end

end