defmodule Slackir.RandomChannel do
  use Slackir.Web, :channel


  def join("elixirbridge", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (random:lobby).
  def handle_in("shout", payload, socket) do
    Slackir.Message.changeset(%Slackir.Message{}, payload) |> Slackir.Repo.insert!
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("new_message", message, socket) do
  Slackir.Message.changeset(%Slackir.Message{}, message) |> Slackir.Repo.insert!
  broadcast! socket, "new_message", message
  {:noreply, socket}
end




  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
