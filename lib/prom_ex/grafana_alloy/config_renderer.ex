defmodule PromEx.GrafanaAlloy.ConfigRenderer do
  @moduledoc """
  This module is used to render the YAML configuration file for
  GrafanaAlloy.
  """

  @doc """
  Generate and write the GrafanaAlloy config file.
  """
  @spec generate_config_file(opts :: map(), config_dir :: String.t()) :: String.t()
  def generate_config_file(opts, config_dir) do
    template_config = File.read!(template_file(opts))
    rendered_config = EEx.eval_string(template_config, assigns: opts)
    config_file_path = Path.join(config_dir, "config.alloy")
    File.write(config_file_path, rendered_config)

    config_file_path
  end

  defp template_file(%{template_file: file}), do: file

  defp template_file(_) do
    :prom_ex
    |> :code.priv_dir()
    |> List.to_string()
    |> Path.join("/grafana_alloy/default_config.alloy.eex")
  end
end
