module TracksHelper
  include ERB::Util

  def ugly_lyrics(lyrics)
    return "" if lyrics.nil?
    html = "<pre>"
    lyrics.split("\n").each do |line|
      html+= "♫ #{html_escape(line)} <br>"
    end
    html += "</pre>"

    html.html_safe
  end
end
