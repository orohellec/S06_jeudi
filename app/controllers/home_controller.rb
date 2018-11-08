class HomeController < ApplicationController
  def index
    @all_crypto = Cryptomonnaie.all
  end

  def create
    @bdd_crypto = CryptoSearchService.new(params[:crypto][:name])
    @the_crypto = @bdd_crypto.result
    if @the_crypto
      flash[:info] = "La valeur de #{@the_crypto[:name]} est de #{@the_crypto[:trade]}"
    else
      flash[:erreur] = "Cette cryptomonnaie n'esxiste pas"
    end
      redirect_to '/'
  end

=begin
  def result(bdd_crypto)
    @the_crypto = bdd_crypto.result
    puts @the_crypto
    puts @the_crypto[:name]
    puts @the_crypto[:trade]
  end
=end
end
