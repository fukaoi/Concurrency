defmodule Concurrency.Default do
  use GenServer

  @urls HttpUtil.getUrlList

  def singleHttpGet() do
    @urls |> Enum.map(&HttpUtil.fetchHttpStatus(&1))
  end

  def conCurrentHttpGet([], _) do end

  def conCurrentHttpGet([pid|other_pids], [url|other_url]) do
    GenServer.cast(pid, {:http, url})
    conCurrentHttpGet(other_pids, other_url)
  end

  def handle_cast({:http, url}, _) do
    {:noreply, HttpUtil.fetchHttpStatus(url)}
  end

  defp start_links(0, lists), do: lists

  defp start_links(count, lists \\ []) do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil)
    start_links(count - 1, lists ++ [pid])
  end
end
