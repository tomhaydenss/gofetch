defmodule GoFetchWeb.Schema do
  @moduledoc """
    The Absinthe schema definition.
  """

  use Absinthe.Schema

  alias GoFetch.Controller

  import_types(GoFetchWeb.Schema.AppointmentTypes)

  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)

  query do
    import_fields(:application_queries)
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Controller, Controller.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
