# LocalePlug

An Elixir plug to set locale for web applications.

[![CircleCI](https://circleci.com/gh/bright-u/locale_plug.svg?style=svg)](https://circleci.com/gh/bright-u/locale_plug)

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
