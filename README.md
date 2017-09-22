# Bisignal

## Requirements

Minimum software requirements
  * Linux (tested on Manjaro 17.2) or other UNIX-like OS
  * Elixir 1.5
  * Erlang/OTP 20
  * Phoenix Framework 1.3
  * BiSignal project dependencies

## Installation
To run BiSignal on your machine:

Install Elixir
  * Go to https://elixir-lang.org/install.html
  * Follow the instructions to install the newest version of Elixir

Install Phoenix Framework
  * Go to https://hexdocs.pm/phoenix/installation.html
  * Follow the instructions to install Phoenix Framework 1.3

Install Node.js (including NPM)
  * Go to https://nodejs.org/en/download/
  * Follow the instructions to install latest version of Node.js

Install PostgreSQL
  * Go to https://www.postgresql.org/download/
  * Follow the instructions to install PostgreSQL 9.6
  * Create a user with name 'postgres' and password 'postgres'

Enable PostGIS
  * Go to http://postgis.net/install/ and follow instructions to install PostGIS

To start your Phoenix server:

  * Install dependencies with `mix deps.get` (On Window, NMake is required and can be acquired by installing the package from here: http://landinghub.visualstudio.com/visual-cpp-build-tools)
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
