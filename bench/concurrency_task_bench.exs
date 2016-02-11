defmodule TaskHttpBench do
  use Benchfella
  require Logger

  setup_all do
    Logger.debug "setup_all"
    HTTPoison.start
  end

  bench "Benching Concurrency.Task" do
    Concurrency.Task.start
  end
end
