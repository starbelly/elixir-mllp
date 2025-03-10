defmodule MLLP.TLSContract do
  @callback setopts(socket :: :ssl.sslsocket(), options :: [:gen_tcp.option()]) ::
              :ok | {:error, term()}
  @callback send(socket :: :ssl.sslsocket(), packet :: iodata()) :: :ok | {:error, any}
  @callback recv(socket :: :ssl.sslsocket(), length :: integer()) :: {:ok, any} | {:error, any}
  @callback recv(socket :: :ssl.sslsocket(), length :: integer(), timeout :: integer()) ::
              {:ok, any} | {:error, any}

  @callback connect(
              address :: :inet.socket_address() | :inet.hostname(),
              port :: :inet.port_number(),
              options :: [:ssl.tls_client_option()],
              timeout :: timeout()
            ) :: {:ok, :ssl.sslsocket()} | {:error, any}

  @callback close(socket :: :ssl.sslsocket()) :: :ok
end

defmodule MLLP.TLS do
  @behaviour MLLP.TLSContract

  defdelegate setopts(socket, opts), to: :ssl
  defdelegate send(socket, packet), to: :ssl
  defdelegate recv(socket, length), to: :ssl
  defdelegate recv(socket, length, timeout), to: :ssl
  defdelegate connect(address, port, options, timeout), to: :ssl
  defdelegate close(socket), to: :ssl
  defdelegate shutdown(socket, opts), to: :ssl
end
