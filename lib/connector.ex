defmodule MessageSpammer.Connector do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_) do
    IO.puts "Starting Connector"
    
    clients = client_pool([], 100)
    spammer = worker(MessageSpammer.Spammer, [{:interval, 10, :clients, clients}], restart: :temporary)
    
    # Supervisor.start_link([spammer], [strategy: :one_for_one, name: MessageSpammer.Supervisor])
    supervise([spammer], strategy: :one_for_one)
  end

  def client_pool(pids, cnt) do 
    l = length(pids) + 1

    if l < cnt do
      { :ok, client_pid } = MessageSpammer.Client.start_link(%{})
      MessageSpammer.Client.connect(client_pid, [client_id: "client-#{l}", host: "localhost", port: 1883])
      spawn_clients(pids ++ [client_pid], cnt)
    else
      pids
    end
  end
end
