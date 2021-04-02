defmodule PromEx.GrafanaClient.ConnectionTest do
  use ExUnit.Case, async: true

  alias PromEx.GrafanaClient.Connection

  describe "build/1" do
    test "should properly build a connection struct with provided host, auth_username, and auth_password values" do
      finch_name = PromEx.TestFinchName
      base_url = "http://localhost:3000"
      username = "admin"
      password = "1234567890"

      assert %Connection{finch_process: ^finch_name, base_url: ^base_url, authorization: authorization} =
               Connection.build(finch_name, %{host: base_url, auth_username: username, auth_password: password})

      assert authorization == "Basic #{Base.encode64("#{username}:#{password}")}"
    end

    test "should properly build a connection struct with provided host and auth_token values" do
      finch_name = PromEx.TestFinchName
      base_url = "http://localhost:3000"
      auth_token = "1234567890"

      assert %Connection{
               finch_process: ^finch_name,
               base_url: ^base_url,
               authorization: "Bearer " <> ^auth_token
             } = Connection.build(finch_name, %{host: base_url, auth_token: auth_token})
    end
  end
end
