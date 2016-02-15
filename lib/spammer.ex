defmodule MessageSpammer.Spammer do

  def start_link({ :clinum, clinum }) do
    IO.puts "Starting spammer."

    { :ok, client_pid } = MessageSpammer.Client.start_link(%{})
    MessageSpammer.Client.connect(client_pid, [client_id: "machine-client-#{clinum}", host: "localhost", port: 1883])

    :timer.sleep(:random.uniform(10))
    pid = spawn_link(__MODULE__, :loop_send, [{:client, client_pid, :machine, clinum }])
    {:ok, pid}
  end

  def loop_send(args) do
    {:client, client_pid, :machine, machine_id} = args


    :timer.sleep(:random.uniform(5000))
    message = %{ message: "A friendly message from machine #{machine_id}" } 
    IO.puts "Publishing message."
    MessageSpammer.Client.publish(client_pid, [id: 11_175, topic: "test/machines/#{machine_id}", message: Poison.encode!(message) , dup: 0, qos: 0, retain: 1])
    loop_send(args)
  end

end
