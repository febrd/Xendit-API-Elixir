defmodule FlizzyCash.Xendit.Invoice do



  @cg_base_url "https://api.xendit.co/v2/invoices"
  @print_url false
  @server_key "your api prod/test"


  def create_invoice(
    external_id \\ "payment-link-example",
    amount \\ 100000,
    description \\ "Invoice Demo #123",
    invoice_duration \\ 86400,
    expiration_date \\ nil,  # Set expiration date here
    customer \\ %{
      "given_names": "John",
      "surname": "Doe",
      "email": "johndoe@example.com",
      "mobile_number": "+6287774441111",
      "addresses": [
        %{
          "city": "Jakarta Selatan",
          "country": "Indonesia",
          "postal_code": "12345",
          "state": "Daerah Khusus Ibukota Jakarta",
          "street_line1": "Jalan Makan",
          "street_line2": "Kecamatan Kebayoran Baru"
        }
      ]
    },
    customer_notification_preference \\ %{
      "invoice_created": ["whatsapp", "sms", "email"],
      "invoice_reminder": ["whatsapp", "sms", "email"],
      "invoice_paid": ["whatsapp", "sms", "email"],
      "invoice_expired": ["whatsapp", "sms", "email"]
    },
    success_redirect_url \\ "https://www.google.com",
    failure_redirect_url \\ "https://www.google.com",
    currency \\ "IDR",
    items \\ [
      %{
        "name": "Air Conditioner",
        "quantity": 1,
        "price": 100000,
        "category": "Electronic",
        "url": "https://yourcompany.com/example_item"
      }
    ],
    fees \\ [
      %{
        "type": "ADMIN",
        "value": 5000
      }
    ]
  ) do

headers = %{
  "accept": "application/json",
  "Authorization": "Basic " <> Base.encode64("#{@server_key}:"),
  "content-type": "application/json"
}

body = %{
  "external_id": external_id,
  "amount": amount,
  "description": description,
  "invoice_duration": invoice_duration,
  "expiration_date": expiration_date,
  "customer": customer,
  "customer_notification_preference": customer_notification_preference,
  "success_redirect_url": success_redirect_url,
  "failure_redirect_url": failure_redirect_url,
  "currency": currency,
  "items": items,
  "fees": fees
}

case HTTPoison.post(@cg_base_url, Poison.encode!(body), headers) do
  {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
    # Successful response
    IO.inspect(response_body)
  {:ok, %HTTPoison.Response{status_code: status_code, body: response_body}} ->
    # Error response
    IO.inspect("Request failed with status: #{status_code}")
    IO.inspect(response_body)
  {:error, error} ->
    # HTTPoison request error
    IO.inspect("Request error: #{inspect(error)}")
end
end



  def get_invoice(id_invoice \\ "579c8d61f23fa4ca35e52da4") do
    headers = %{
      "accept": "application/json",
      "Authorization": "Basic " <> Base.encode64("#{@server_key}:"),
      "content-type": "application/json"
    }


    response = HTTPoison.get("#{@cg_base_url}/#{id_invoice}", headers)
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
        # respon sukses
        IO.inspect(response_body)
      {:ok, %HTTPoison.Response{status_code: status_code, body: response_body}} ->
        # eror respon
        IO.inspect("Request failed with status: #{status_code}")
        IO.inspect(response_body)
      {:error, error} ->
        # HTTPoison request error
        IO.inspect("Request error: #{inspect(error)}")
    end
  end
end
