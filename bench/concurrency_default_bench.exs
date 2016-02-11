defmodule ConcurrencyDefaultBench do
  use Benchfella
  require Logger

  setup_all do
    Logger.debug "setup_all"
    HTTPoison.start
  end

  bench "Benching Concurrency.Default single" do
     Concurrency.Default.single_start
  end

  bench "Benching Concurrency.Default" do
     Concurrency.Default.start
  end
end
