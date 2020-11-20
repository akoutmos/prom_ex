defmodule PromEx.GrafanaClient.ConnectionTest do
  use ExUnit.Case, async: true

  alias PromEx.GrafanaClient.Connection

  describe "build/1" do
    test "should properly build a connection struct when values are provided" do
      finch_name = PromEx.TestFinchName
      base_url = "http://localhost:3000"
      auth_token = "1234567890"

      assert %Connection{
               finch_process: ^finch_name,
               base_url: ^base_url,
               auth_token: "Bearer " <> ^auth_token
             } = Connection.build(finch_name, base_url, auth_token)
    end
  end
end
