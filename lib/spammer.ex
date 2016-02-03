defmodule MessageSpammer.Spammer do

  def start_link(args) do
    IO.puts "Starting spammer."
    pid = spawn(__MODULE__, :loop_send, [args])
    {:ok, pid}
  end

  def loop_send(args) do
    {:interval, interval, :clients, clients} = args

    machine_id = :random.uniform(100)
    client = Enum.random(clients)
    
    IO.puts "Spammer publishing to through client."

    MessageSpammer.Client.publish(client, [id: 11_175, topic: "test/machines/#{machine_id}", message: "a message from #{machine_id}", dup: 0, qos: 0, retain: 1])

    :timer.sleep(interval)
    loop_send(args)
  end

end
