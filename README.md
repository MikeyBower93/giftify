# Giftify

## Status
In progress

## Introduction

Giftify is a project a came up with at Christmas time. Everybody if my family was trying to communicate
about what gifts they were going to be each other, and it was very easy to run into a situation where
someone accidentally buys a present someone else has already purchased.

We then tried shared google sheets, but this was quite difficult as the original creator of a google sheet
couldn't be locked from seeing their own sheet. It also wasn't very bespoke and didn't allow for deadlines, budgets etc.

This gave me the idea to create giftify, a website where you can store all the gifts you want. Then create a list
that is shared with other people, who can then collaborate in realtime to purchase gifts, when the original owner of the
list cannot see until the deadline (birthday, christmas day etc). 

## Stack
This is using Elixir/Phoenix/LiveView/Postgres and is hosted in Gigalixir.

## Setup

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
