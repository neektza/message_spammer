defmodule MessageSpammer.Mixfile do
  use Mix.Project

  def project do
    [
      app: :message_spammer,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [ 
      mod: { MessageSpammer, [] },
      applications: [:logger, :poolboy]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:hulaaki, "~> 0.0.2"},
      {:poolboy, "~> 1.5"},
      {:poison, "~> 2.0"}
    ]
  end
end
