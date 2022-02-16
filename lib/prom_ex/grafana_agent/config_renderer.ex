defmodule PromEx.GrafanaAgent.ConfigRenderer do
  @moduledoc """
  This module is used to render the YAML configuration file for
  GrafanaAgent.
  """

  @doc """
  Generate and write the GrafanaAgent config file.
  """
  def generate_config_file(opts, config_dir) do
    template_config =
      :prom_ex
      |> :code.priv_dir()
      |> List.to_string()
      |> Path.join("/grafana_agent/default_config.yml.eex")
      |> File.read!()

    {:ok, hostname} = :inet.gethostname()

    assigns =
      opts
      |> Map.put(:hostname, hostname)

    rendered_config = EEx.eval_string(template_config, assigns: assigns)
    config_file_path = Path.join(config_dir, "agent.yml")
    File.write(config_file_path, rendered_config)

    config_file_path
  end

  defp render_config_file() do
  end
end
