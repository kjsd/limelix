defmodule Limelix.LINEQoS do
  @moduledoc """
  """

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
        wait: true,
        initial_args: {1, 0}

      @impl Rpcsdk.Crawler
      def handle_crawling({sender, arg}, key, {interval, _}) do
        Endpoints
        |> apply(unquote(target_fn), [arg])
        |> case do
             {:error, {429, _, _}} = x ->
               cond do
                 interval < unquote(interval_ms) * 5 ->
                   unquote(queue).enqueue(key, {sender, arg})
                   :too_many_requests

                 true ->
                   if is_pid(sender), do: send(sender, x)
                   :ok
               end

             x ->
               if is_pid(sender), do: send(sender, x)
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
