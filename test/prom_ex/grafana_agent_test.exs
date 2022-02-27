defmodule PromEx.GrafanaAgentTest do
  use ExUnit.Case, async: true

  alias PromEx.GrafanaAgent

  describe "GrafanaAgent GenServer" do
    test "should not start is invalid options are provided" do
      assert {:error, _} = start_supervised({GrafanaAgent, []})
    end
  end
end
