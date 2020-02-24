# LocalePlug

A plug to set locale for Elixir web frameworks.

[![CI](https://github.com/goofansu/locale_plug/workflows/CI/badge.svg)](https://github.com/goofansu/locale_plug/actions?query=workflow%3ACI)

`locale` is detected according to following order:

> params > cookies > "accept-language" in request headers

## Installation

```elixir
def deps do
  [
    {:locale_plug, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
plug LocalePlug, backend: MyApp.Gettext
```
