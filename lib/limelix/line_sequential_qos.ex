defmodule Limelix.LINESequentialQoS do

  alias Limelix.Endpoints
  alias Limelix.QoSRates
  
  defmacro __using__(opts) do
    max_request = Keyword.get(opts, :max_request)
    interval_ms = Keyword.get(opts, :interval_ms)
    {queue, target_fn} = Keyword.get(opts, :endpoint)

    quote do
      use Rpcsdk.Crawler,
        queue: unquote(queue),
        max_request: unquote(max_request),
        interval_ms: unquote(interval_ms),
        initial_args: {1, 0},
        sync: true

      @impl Rpcsdk.Crawler
      def handle_crawling({sender, arg}, key, {interval, _}) do
        result = Enum.reduce_while(1..3, nil, fn n, _ ->
          if n > 1, do: :timer.sleep(interval / 3)

          Endpoints
          |> apply(unquote(target_fn), [arg])
          |> case do
               {:error, {429, _, _}} = x ->
                 {:cont, x}
               x ->
                 {:halt, x}
             end
        end)

        if is_pid(sender), do: send(sender, result)

        case result do
          {:error, {429, _, _}} -> 
            :too_many_requests
          _ ->
            :ok
        end
      end

      @impl Rpcsdk.Crawler
      def handle_crawled(results, _, state) do
        QoSRates.next_rate(results, unquote(interval_ms), state)
      end
    end
  end
end
