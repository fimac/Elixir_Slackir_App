defmodule Slackir.PageController do
  use Slackir.Web, :controller

  def index(conn, _params) do
    messages = Slackir.Message
    |> Slackir.Repo.all
    |> IO.inspect
    render conn, "index.html", messages: messages
  end
end
