defmodule PromEx.BucketGenerator do
  @moduledoc """
  This module provides functions to generate histogram bucket ranges.
  The lists of buckets that can be generated are either linear
  or exponential.
  """

  @doc """
  Create a linear set of buckets based on the provided parameters.

  ## Examples

      iex> PromEx.BucketGenerator.linear!(10, 10, 10)
      [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

      iex> PromEx.BucketGenerator.linear!(0, 250, 11)
      [0, 250, 500, 750, 1000, 1250, 1500, 1750, 2000, 2250, 2500]
  """
  @spec linear!(start :: number(), step :: number(), num_buckets :: number()) :: list(non_neg_integer())
  def linear!(start, _, _) when start < 0,
    do: raise("The start value for BucketGenerator.linear/3 must be a positive integer")

  def linear!(_, step, _) when step < 1,
    do: raise("The step value for BucketGenerator.linear/3 must be greater than or equal to 1")

  def linear!(_, _, num_buckets) when num_buckets < 1,
    do: raise("The num_buckets value for BucketGenerator.linear/3 must be greater than or equal to 1")

  def linear!(start, step, num_buckets) do
    0..(num_buckets - 1)
    |> Enum.map(fn bucket ->
      :erlang.trunc(step * bucket + start)
    end)
  end

  @doc """
  Create an exponential set of buckets based on the provided parameters.

  ## Examples

      iex> PromEx.BucketGenerator.exponential!(1, 4, 10)
      [1, 4, 16, 64, 256, 1024, 4096, 16384, 65536, 262144]

      iex> PromEx.BucketGenerator.exponential!(1, 2, 10)
      [1, 2, 4, 8, 16, 32, 64, 128, 256, 512]
  """
  @spec exponential!(start :: number(), factor :: number(), num_buckets :: number()) :: list(non_neg_integer())
  def exponential!(start, _, _) when start < 0,
    do: raise("The start value for BucketGenerator.exponential/3 must be a positive integer")

  def exponential!(_, factor, _) when factor < 1,
    do: raise("The factor value for BucketGenerator.exponential/3 must be greater than or equal to 1")

  def exponential!(_, _, num_buckets) when num_buckets <= 1,
    do: raise("The num_buckets value for BucketGenerator.exponential/3 must be greater than or equal to 1")

  def exponential!(start, factor, num_buckets) do
    0..(num_buckets - 1)
    |> Enum.map(fn bucket ->
      :erlang.trunc(start * :math.pow(factor, bucket))
    end)
  end
end
