require 'open-uri'
require 'json'

class GamesController < ApplicationController
	def new
		@letters = ("A".."Z").to_a.sample(10)
	end

	def score
		@letters = params[:letters]
		@word = params[:word].upcase
		if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
			english_word?(@word) ? @displayed_result = "Congratulations #{@word} is a valid English word!" : @displayed_result = "Sorry but #{@word} does not seem to be a valild English word"
		else
			@displayed_result = "Sorry but #{@word} can´t be buit out of #{@letters}"
		end
	end 

	def english_word?(word)
		response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
 		json = JSON.parse(response.read)
  	return json['found']
	end
end
