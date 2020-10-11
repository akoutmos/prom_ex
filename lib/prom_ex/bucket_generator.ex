defmodule PromEx.BucketGenerator do
  def linear(start, _, _) when start < 0,
    do: raise("The start value for BucketGenerator.linear/3 must be a positive integer")

  def linear(_, step, _) when step < 1,
    do: raise("The step value for BucketGenerator.linear/3 must be greater than or equal to 1")

  def linear(_, _, num_buckets) when num_buckets < 1,
    do: raise("The num_buckets value for BucketGenerator.linear/3 must be greater than or equal to 1")

  def linear(start, step, num_buckets) do
    0..(num_buckets - 1)
    |> Enum.map(fn bucket ->
      step * bucket + start
    end)
  end

  def exponential(start, _, _) when start < 0,
    do: raise("The start value for BucketGenerator.exponential/3 must be a positive integer")

  def exponential(_, factor, _) when factor < 1,
    do: raise("The factor value for BucketGenerator.exponential/3 must be greater than or equal to 1")

  def exponential(_, _, num_buckets) when num_buckets <= 1,
    do: raise("The num_buckets value for BucketGenerator.exponential/3 must be greater than or equal to 1")

  def exponential(start, factor, num_buckets) do
    0..(num_buckets - 1)
    |> Enum.map(fn bucket ->
      :erlang.trunc(start * :math.pow(factor, bucket))
    end)
  end
end
