defmodule MessageSpammer.Starter do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    IO.puts "Starting the whole thing."
    supervise(spammers(5000), strategy: :one_for_one)
  end

  def spammers(cnt) do
    for n <- 1..cnt, do: worker(MessageSpammer.Spammer, [{:clinum, n}], id: n)
  end

end
