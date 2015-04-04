class VideoDecorator < Draper::Decorator
  delegate_all

  def video_frame
    if youtube?
      frame = "<iframe type='text/html' width='900' height='600'"
      frame += "src='http://www.youtube.com/embed/#{key.first}?autoplay=1&origin=https://debatevid.io"
      if key.length > 1
        frame += "&playlist=#{key.join(",")}"
      end
      frame += "' frameborder='0' />"
      frame.html_safe
    else
      "<iframe src='https://player.vimeo.com/video/#{key.first}' width='900' height='600' frameborder='0' webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>".html_safe
    end
  end
end