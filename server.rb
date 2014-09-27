require 'sinatra'
require 'sinatra/reloader'
require 'pry'


def greeting
  @answer = "<strong>Hello!</strong><br> I'm Sir Quackington, lord of the sea. Ask me anything,
            and I will do my best to answer!"
end

def random
  @answer = ["Have you tried turning if off and on again?",
            "Sorry, I have two left flippers",
            "I have hollow bones!",
            "<strong><em>PLEASE</em></strong> stop abusing the ask button.",
            "I didn't quite understand that, but let me tell you, life is great.",
            "Take care of yourself"].sample
end

# ROUTES

get '/' do
  greeting
  erb :index
end

post'/question' do
  @question = (params[:question]).downcase.split(" ")
  if @question.empty?
    random
  elsif @question.first.include? "hello"
    greeting
  elsif @question.first.include? "quack"
    @answer = "20.times { puts \"QUACK\" }"
  elsif @question.first.include? "google"
    @question.shift
    @statement = @question.join(" ")
    @query = @question.join("+")
    @answer = "#{@statement}? <br> <a href='http://www.google.com/#q=#{@query}' target='_blank'>Let me google that for you.</a>"
  elsif @question.first.include? "overflow"
    @question.shift
    @statement = @question.join(" ")
    @query = @question.join("+")
    @answer = "#{@statement}? <br> <a href='http://stackoverflow.com/search?q=#{@query}' target='_blank'>Let's look at Stack Overflow.</a>"
  elsif @question.first.include? "help"
    @answer = "Okay! Let me help you.<br> First words are always important when talking to a duck. <br><strong>GOOGLE</strong> <em>something</em><br><strong>OVERFLOW</strong> <em>programming questions</em><br>I will know even more soon!"
  else
    random
  end

  erb :index
end
