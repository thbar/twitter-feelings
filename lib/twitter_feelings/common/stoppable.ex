defmodule TwitterFeelings.Common.Stoppable do

  defmacro __using__(opts) do
    quote do

      def stop do
        stop(__MODULE__)
      end

      def stop(name) do
        pid = Process.whereis(name)
        cond do
        is_pid(pid) ->
          if Process.alive?(pid) do
            GenServer.call(name, :stop)
          end
        true -> :ok
        end
        :ok
      end

      def handle_call(:stop, _from, state) do
        {:stop, :normal, :ok, state}
      end

    end
  end

end