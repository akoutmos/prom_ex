defmodule PromEx.DefaultPromExSetUps do
  @moduledoc false

  use PromEx, otp_app: :prom_ex

  @impl true
  def plugins do
    [
      {PromEx.Plugins.Application, otp_app: :prom_ex}
    ]
  end

  @impl true
  def dashboards do
    [
      {:prom_ex, "application.json"}
    ]
  end
end
