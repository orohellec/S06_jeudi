require 'open-uri'

class CryptoSearchService
  def initialize(crypto_name)
    @link = "https://coinmarketcap.com/all/views/all/"
    @crypto_name = crypto_name
    perform
  end

  def perform
  doc = Nokogiri::HTML(open(@link))
  tab_name = doc.css("td.no-wrap.currency-name > a")
  tab_price = doc.css("td:nth-child(5) > a")
  final_name = []
  final_price = []
  i = 0
  while i < tab_name.size
    final_name[i] = tab_name[i].text.to_s
    i += 1
  end
  i = 0
  price_to_s = []
  price_to_f = []
  while i < tab_price.size
    final_price[i] = tab_price[i].text
    price_to_s[i] = final_price[i][1..final_price.size].to_s
    price_to_f[i] = price_to_s[i].to_f
    i += 1
  end
  @my_hash = Hash[final_name.zip(price_to_f)]
  save()
  end

  def save
    Cryptomonnaie.delete_all
    @my_hash.each do |key, value|
    Cryptomonnaie.create(name: key.downcase, trade: value)
    end
  end

  def result
    the_crypto = Cryptomonnaie.find_by(name: @crypto_name)
    return the_crypto
  end
end
