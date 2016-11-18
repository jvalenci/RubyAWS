require 'sinatra'
require 'sinatra/reloader' if development?
require './rsg.rb'

post '/:grammar' do

  @grammar = params[:grammars]
  filename = "grammars/#{@grammar}"
  if(/([\w\-.])+/.match(@grammar))
    erb :error
  end

  if(!FileTest.exists? filename)
   erb :error
  else
   gDefsArray = read_grammar_defs(filename).map{|x| split_definition(x)}
   hs = to_grammar_hash(gDefsArray)
   @sentence = expand(hs).rstrip
   erb :rsg
  end
end


get '/' do
 erb :home
end

not_found do
  erb :error
end



