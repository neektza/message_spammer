defmodule MessageSpammer do
  use Application
  
  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    IO.puts "Starting Application"
    opts = [strategy: :one_for_one, name: DeviceRegistry.Supervisor]
    Supervisor.start_link([worker(MessageSpammer.Starter, [])], opts)
  end
end
