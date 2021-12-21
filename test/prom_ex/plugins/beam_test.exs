defmodule PromEx.Plugins.BeamTest do
  use ExUnit.Case, async: true

  alias PromEx.Plugins.Beam
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [Beam]
    end
  end

  test "telemetry events are accumulated" do
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:beam)

    metrics =
      WebApp.PromEx
      |> PromEx.get_metrics()
      |> Metrics.sort()

    # Alter the JIT entry to ensure that it passes in all OTP versions in CI
    expected_metrics =
      :beam
      |> Metrics.read_expected()
      |> Enum.map(fn
        "web_app_prom_ex_beam_system_jit_support_info" <> _ ->
          jit_enabled =
            try do
              if :erlang.system_info(:emu_flavor) == :jit, do: 1, else: 0
            rescue
              _error ->
                0
            end

          "web_app_prom_ex_beam_system_jit_support_info #{jit_enabled}"

        entry ->
          entry
      end)

    assert metrics == expected_metrics
  end

  describe "event_metrics/1" do
    test "should return the correct number of metrics" do
      assert Beam.event_metrics([]) == []
    end
  end

  describe "polling_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Beam.polling_metrics(otp_app: :prom_ex)) == 4
    end
  end

  describe "manual_metrics/1" do
    test "should return the correct number of metrics" do
      assert length(Beam.manual_metrics(otp_app: :prom_ex)) == 4
    end
  end
end
