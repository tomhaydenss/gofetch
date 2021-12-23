defmodule GoFetch.Controller do
  def data() do
    Dataloader.Ecto.new(GoFetch.Repo)
  end
end
