require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      letter = ('a'..'z').to_a[rand(26)]
      @letters.push(letter)
    end
    return @letters
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    @check1 = first_check(@answer, @letters)
    @check2 = second_check(@answer)
    if @check1
      # do the second check
      @check2
    end
# The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
  end

  def first_check(answer,letters)
    answer_array = answer.split('')
    letter_array = letters.split('')
    answer_array.each { |letter|
      if letter_array.include?(letter)
        return true
      else
        failure = "#{answer} is NOT built out of the original grid"
        return failure
      end
    }
  end

  def second_check(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    result = JSON.parse(open(url).read)
    if result["found"] == true
      return "Congratulations! #{answer} is a valid English word!"
    else
      not_english_word = "#{answer} is not an English word"
      return not_english_word
    end
  end
end
