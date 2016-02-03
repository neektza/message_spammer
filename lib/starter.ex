defmodule MessageSpammer.Starter do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    IO.puts "Starting the whole thing"
    
    # clients = build_pool([], 2)
    # IO.inspect clients

    res = MessageSpammer.Client.start_link(%{})
    IO.inspect res

    spammer = worker(MessageSpammer.Spammer, [{ :interval, 100 }], restart: :temporary)
    
    supervise([spammer], strategy: :one_for_one)
  end

  # def build_pool(pool, cnt) do 
  #   l = length(pool) + 1

  #   if l >= cnt do
  #     pool
  #   else
  #     { :ok, pid } = MessageSpammer.ClientWrapper.start_link({ :clinum, l })
  #     build_pool(pool ++ [pid], cnt)
  #   end
  # end
end
