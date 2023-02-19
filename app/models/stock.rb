class Stock < ApplicationRecord
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex.public_key,
      secret_token: Rails.application.credentials.iex.private_key,
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    begin
      new(ticker: ticker_symbol, name: client.quote(ticker_symbol).company_name, last_price: client.quote(ticker_symbol).latest_price)
    rescue => exception
      return nil
    end
  end 
end
