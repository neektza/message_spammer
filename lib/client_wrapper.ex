defmodule MessageSpammer.ClientWrapper do
  def start_link({:clinum, clinum}) do
    { :ok, client_pid } = MessageSpammer.Client.start_link(%{})
    MessageSpammer.Client.connect(client_pid, [client_id: "machine-client-#{clinum}", host: "localhost", port: 1883])
    { :ok, client_pid }
  end
end
