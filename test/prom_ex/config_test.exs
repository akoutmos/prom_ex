defmodule PromEx.ConfigTest do
  use ExUnit.Case, async: true

  alias PromEx.Config

  describe "build/1" do
    test "should normalize the Grafana host value" do
      assert %Config{grafana_config: %{host: "http://grafana:3000"}} =
               Config.build(
                 grafana: [
                   host: "http://grafana:3000/",
                   auth_token: "abcd"
                 ]
               )

      assert %Config{grafana_config: %{host: "http://grafana:3000"}} =
               Config.build(
                 grafana: [
                   host: "http://grafana:3000//////",
                   auth_token: "abcd"
                 ]
               )

      assert %Config{grafana_config: %{host: "http://grafana:3000"}} =
               Config.build(
                 grafana: [
                   host: "http://grafana:3000",
                   auth_token: "abcd"
                 ]
               )
    end
  end
end
