module TracksHelper
  def ugly_lyrics(lyrics)
    lyrics.split("\n").map do |line|
      "&#9835; " + h(line)
    end.join("\n").html_safe
  end
end
