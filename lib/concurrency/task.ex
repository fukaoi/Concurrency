defmodule Concurrency.Task do
    @urls HttpUtil.getUrlList

    def start do
      @urls
      |> Enum.map(fn(url)-> Task.async(fn -> url |> HttpUtil.fetchHttpStatus end) end)
      |> Enum.map(&Task.await/1)
    end
end
