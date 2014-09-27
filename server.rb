require 'sinatra'

# MANNERISMS

def greeting
  @answer = "<strong>Hello!</strong><br> I'm Sir Quackington,<br>adorable lord of the sea.<br>Ask me anything,<br>
            and I will do my best to answer!"
end

def random
  @answer = ["Have you tried turning if off and on again?",
            "Sorry, I have two left flippers",
            "I have hollow bones!",
            "<strong><em>PLEASE</em></strong> stop abusing the ask button.",
            "Did you forget to add a semicolon?",
            "Maybe you forgot a comma somewhere?",
            "Maybe you added an 's' to something<br>by mistake in ActiveRecord.",
            "Maybe you should take a walk?",
            "I didn't quite understand that, but let me tell you, life is great.",
            "Take care of yourself.",
            "Let's put a binding.pry in there"].sample
end

# ROUTES

get '/' do
  greeting
  erb :index
end

post'/' do
  @question = (params[:question]).downcase.split(" ")
  if @question.empty?
    random
  elsif @question.first.include? "hello"
    greeting
  elsif @question.first.include? "quack"
    @number = @question[1].to_i
    if @number <= 0
      @number = 1
      @answer = "QUACK " * @number
    elsif @number > 100
      @answer = "9001.times { puts \"QUACK \" }"
    else
      @answer = "QUACK " * @number
    end
  elsif @question.first.include? "ruby"
    @answer = "Have you checked the <a href='http://www.ruby-doc.org/core-2.1.3/' target='_blank'>Ruby</a> docs?"
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
    @answer = "<p>Okay! Let me help you.</p>
              <p>First words are always important<br>when talking to a duck.</p>
              <p><strong>WIKIPEDIA</strong> <em>something</em><br><strong>GOOGLE</strong> <em>something</em><br><strong>OVERFLOW</strong> <em>programming questions</em><br><br>You can even ask me to<br><strong>QUACK</strong> <em>X</em> amount of times!</p>
              <p>I will know even more soon!</p>"
  elsif @question.first.include? "wikipedia"
    @question.shift
    @statement = @question.join(" ")
    @query = @question.join("+")
    @answer = "#{@statement}? <br> <a href='http://en.wikipedia.org/w/index.php?search=#{@query}' target='_blank'>Let me Wikipedia that.</a>"
  else
    random
  end

  erb :index
end
