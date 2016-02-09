defmodule HttpUtil do
  require Logger

  def getUrlList do
    [
      "http://www.yahoo.com/",
      "http://www.google.com/",
      "http://fukaoi.org/",
      "http://wikipedia.com/",
      "http://www.yahoo.co.jp/",
      "http://www.amazon.co.jp/",
      "http://www.google.co.jp",
      "https://www.google.fr/",
      "https://www.amazon.fr/",
      "https://fr.yahoo.com/",
      "http://wikipedia.fr/",
      "http://bnatsaba.com/",
      "http://crashie.com/",
      "http://fullddl.com/",
      "http://garysinise.com/",
      "http://jodi.org/"
    ]
  end

  def fetchHttpStatus(url) do
     res_title = HTTPoison.get!(url).body |> Floki.find("title")
     case res_title do
       [{"title", [], title_name}] -> IO.puts "#{title_name} #{url}"
       [] -> IO.puts "No data..."
       [{"error"}] -> Logger.error "Error url:#{url}"
     end
  end
end
