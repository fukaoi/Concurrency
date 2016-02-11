defmodule Concurrency.Default do
  use GenServer

  @urls HttpUtil.getUrlList

  def single_start do
    @urls |> Enum.map(&HttpUtil.fetchHttpStatus(&1))
  end

  def start do
    Enum.count(@urls) |> start_links |> conCurrentHttpGet(@urls)
  end

  defp conCurrentHttpGet(pids, urls)

  defp conCurrentHttpGet([], _) do end

  defp conCurrentHttpGet([pid|other_pids], [url|other_url]) do
    GenServer.cast(pid, {:fetch_async, url})
    conCurrentHttpGet(other_pids, other_url)
  end

  def handle_call({:fetch_sync, url}, _, connection_dict) do
    {:reply, HttpUtil.fetchHttpStatus(url), connection_dict}
  end

  def handle_cast({:fetch_async, url}, _) do
    {:noreply, HttpUtil.fetchHttpStatus(url)}
  end

  defp start_links(count, lists \\ [])

  defp start_links(0, lists), do: lists

  defp start_links(count, lists) do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil)
    start_links(count - 1, lists ++ [pid])
  end
end
