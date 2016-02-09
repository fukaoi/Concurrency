defmodule Concurrency.Default do
  use GenServer

  @urls HttpUtil.getUrlList

  def singleHttpGet() do
    @urls |> Enum.map(&HttpUtil.fetchHttpStatus(&1))
  end

  def conCurrentHttpGet(pids, urls)

  def conCurrentHttpGet([], _) do end

  def conCurrentHttpGet([pid|other_pids], [url|other_url]) do
    GenServer.cast(pid, {:http_fetch, url})
    conCurrentHttpGet(other_pids, other_url)
  end

  def handle_cast({:http_fetch, url}, _) do
    {:noreply, HttpUtil.fetchHttpStatus(url)}
  end

  def start_links(0, lists), do: lists

  def start_links(count, lists \\ []) do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil)
    start_links(count - 1, lists ++ [pid])
  end
end
