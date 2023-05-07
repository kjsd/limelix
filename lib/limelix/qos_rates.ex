defmodule Limelix.QoSRates do
  
  def next_rate([_|_] = results, x1, x2) do
    results
    |> Enum.any?(&(&1 == :too_many_requests))
    |> if(do: down_rate(x1, x2), else: up_rate(x1, x2))
  end
  def next_rate(_, _, x), do: x

  defp down_rate(min_interval, {_, {tilt, success_count}}) do
    case success_count do
      0 ->
        next_tilt = tilt + 1
        {min_interval * next_tilt, {next_tilt, 0}}

      _ ->
        {min_interval * tilt, {tilt, 0}}
    end
  end

  defp up_rate(min_interval, {interval, {tilt, success_count}}) do
    case tilt do
      1 ->
        {min_interval, {1, 0}}

      _ ->
        n = success_count + 1
        min = min_interval * (tilt - 1)
        x = interval - fibonacci_at(n)

        cond do
          x > min ->
            {x, {tilt, n}}

          true ->
            {min, {tilt - 1, n}}
        end
    end
  end

  defp fibonacci_at(n), do: fibonacci_sequence() |> Enum.take(n + 1) |> Enum.at(-1)
  defp fibonacci_sequence, do: Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
end
