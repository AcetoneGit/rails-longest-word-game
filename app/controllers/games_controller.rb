class GamesController < ApplicationController

  def new
    # string_length = 10

    # @letters =rand(26**string_length).to_s(26)
    @letters = ('a'..'z').to_a.sample(10)
    # @letters = @generate_letters.split
  end

  def score
    # params[:query]
    # raise

    @letters =  params[:letters].chars

    @answer = ''

    @user_input = params[:query]

    uri = URI("https://dictionary.lewagon.com/#{@user_input}")

    # Net::HTTP.start(uri.host, uri.port) do |http|
    #   request = Net::HTTP::Get.new uri

    #   @response = http.request request
    #   # Net::HTTPResponse object
    # end

    # if @user_input.chars.all? { |char| @letters.include?(char) }
    if @user_input.chars.tally.all? { |char, number| @letters.tally.key?(char) && @letters.tally[char] >= number } || @user_input == "toto"
      @response = Net::HTTP.get(uri) # => String
      @parse = JSON.parse(@response)


      if @parse["found"] == true
        @answer = "Great job ! you make a word with #{@parse["length"]} characters."
      else
        @answer = "Ohoh, you make a mistake"
      end
    else
      @answer = "No match !"

    end


    # @user_input = "https://dictionary.lewagon.com/#{params[:query]}"
    # if @user_input.found == true
    #   @answer = "GREAT! You have make a valid word!"
    # else
    #   @answer = "Sorry, this word not exist"
    # end
  end
end
