defmodule Febrd.CekSaldo do

  #Required httpoison
  @cg_base_url "https://api.xendit.co/balance"
  @print_url false
  @server_key "drop your API here (Prod/Test)"
  def get_balance() do
    headers = %{
      "Authorization": "Basic " <> Base.encode64("#{@server_key}:")
    }
    response = HTTPoison.get(@cg_base_url, headers)
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
       #respon sukses
        IO.inspect(body)
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        # respon error
        IO.inspect("Request failed with status: #{status_code}")
        IO.inspect(body)
      {:error, error} ->
        # permintaan error
        IO.inspect("Request error: #{inspect(error)}")
    end
  end
end
