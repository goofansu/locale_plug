defmodule LocalePlug.MixProject do
  use Mix.Project

  def project do
    [
      app: :locale_plug,
      version: "0.1.3",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Publish package
      name: "LocalePlug",
      description: description(),
      package: package(),
      docs: docs()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.7"},
      {:gettext, ">= 0.0.0"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp description do
    "Elixir plug to detect and set locale."
  end

  defp package do
    [
      name: :locale_plug,
      licenses: ["MIT"],
      maintainers: ["Yejun Su"],
      links: %{"Github" => "https://github.com/goofansu/locale_plug"}
    ]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
