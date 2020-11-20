defmodule PromEx.BucketGeneratorTest do
  use ExUnit.Case, async: true

  alias PromEx.BucketGenerator

  doctest BucketGenerator

  describe "linear!/3" do
    test "should raise an error when an invalid start value is provided" do
      assert_raise RuntimeError, ~r/^The start value.*/, fn ->
        BucketGenerator.linear!(-1, 1, 10)
      end
    end

    test "should raise an error when an invalid step value is provided" do
      assert_raise RuntimeError, ~r/^The step value.*/, fn ->
        BucketGenerator.linear!(1, -1, 10)
      end
    end

    test "should raise an error when an invalid num_buckets value is provided" do
      assert_raise RuntimeError, ~r/^The num_buckets value.*/, fn ->
        BucketGenerator.linear!(1, 100, -10)
      end
    end
  end

  describe "exponential!/3" do
    test "should raise an error when an invalid start value is provided" do
      assert_raise RuntimeError, ~r/^The start value.*/, fn ->
        BucketGenerator.exponential!(-1, 1, 10)
      end
    end

    test "should raise an error when an invalid factor value is provided" do
      assert_raise RuntimeError, ~r/^The factor value.*/, fn ->
        BucketGenerator.exponential!(1, -1, 10)
      end
    end

    test "should raise an error when an invalid num_buckets value is provided" do
      assert_raise RuntimeError, ~r/^The num_buckets value.*/, fn ->
        BucketGenerator.exponential!(1, 100, -10)
      end
    end
  end
end
