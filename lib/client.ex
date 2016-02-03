defmodule MessageSpammer.Client do
  use Hulaaki.Client
  
  def on_publish(options) do
    IO.inspect options
  end

  def on_connect_ack(options) do
    IO.inspect options
  end

  def on_pong(options) do
    IO.inspect options
  end
end
