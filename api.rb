require 'sinatra'
require 'json'
require_relative 'oldness'

helpers do

  def date_from(p)
    date = [p[:year].to_i]
    date << p[:m].to_i unless p[:m].nil?
    date << p[:d].to_i unless p[:d].nil?
    Date.new(*date)
  end

  def date_of_first_work(medium)  # obviously, many of these are arbitrary
    date_params = case medium
                   when 'novel', 'book' then [1010] # Tale of Genji
                   when 'film', 'movie' then [1894, 2, 5] # Jean Le Roy's "marvellous cinematograph"
                   when 'comic', 'manga' then [1837] # Histoire de M. Vieux Bois
                   when 'videogame' then [1951, 5, 4] # NIMROD
                   when 'history' then [-411] # end of Thucydides' history
                   when 'literature' then [-1300] # Epic of Gilgamesh
                   when 'philosophy', 'religion' then [-800] # The Upanishads
                   when 'animation', 'cartoon', 'anime'  then [1906, 4, 6] #Humorous Phases of Funny Faces
                   else raise Exception
                 end
    Date.new(*date_params)
  end
end

get '/api/range/:year' do
  oldness_ranges(date_from(params)).to_json
end

get '/api/:medium' do
  oldness_ranges(date_of_first_work(params[:medium])).to_json
end

get '/api/:medium/:year' do
  oldness_rating(date_from(params), date_of_first_work(params[:medium])).to_json
end