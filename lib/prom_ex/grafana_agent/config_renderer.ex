defmodule PromEx.GrafanaAgent.ConfigRenderer do
  @moduledoc """
  This module is used to render the YAML configuration file for
  GrafanaAgent.
  """

  @doc """
  Generate and write the GrafanaAgent config file.
  """
  @spec generate_config_file(opts :: map(), config_dir :: String.t()) :: String.t()
  def generate_config_file(opts, config_dir) do
    template_config =
      :prom_ex
      |> :code.priv_dir()
      |> List.to_string()
      |> Path.join("/grafana_agent/default_config.yml.eex")
      |> File.read!()

    rendered_config = EEx.eval_string(template_config, assigns: opts)
    config_file_path = Path.join(config_dir, "agent.yml")
    File.write(config_file_path, rendered_config)

    config_file_path
  end
end
