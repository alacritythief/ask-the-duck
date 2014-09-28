# Ask the Duck! v1.5
# By Andy Wong
# https://github.com/alacritythief

require 'sinatra'

# DUCKY AI

class Duck
  def self.parse(query)
    parse_array = (query).downcase.split(" ")
  end

  def self.nocase_parse(query)
    parse_array = query.split(" ")
  end

  def self.query(question)
    question.shift
    query = question.join("+")
  end

  def self.quack(number)
    if number <= 0 || nil
      answer = "QUACK"
    elsif number > 102
      answer = "#{number}.times { puts \"QUACK \" }<p>You thought I was going to quack
                <br><strong>that</strong> many times?</p>"
    else
      answer = "QUACK " * number
    end
  end

  def self.greeting
    answer = "<h1>Hello! :></h1>
              <p>I'm <strong>Sir Quackington</strong>, adorable lord of the sea.
              <br>Ask me anything, and I will do my best to answer!
                <br>I like to help with programming questions.</p>
                If you don't know what to say, just type <strong>HELP</strong>.
                <p>Type <strong>ABOUT</strong> if you want to know more<br>about me and my creator.</p>"
  end

  def self.help
    answer = "<p>Okay! Let me help you.</p>
              <p>First words are always important<br>when talking to a duck like me.</p>
              <p><strong>GOOGLE</strong> <em>something</em><br>
              <strong>WIKIPEDIA</strong> <em>something</em><br>
              <strong>OVERFLOW</strong> <em>programming questions</em><br>
              <strong>REDDIT</strong> <em>subreddit name</em>
              <p>You can even ask me to<br><strong>QUACK</strong> <em>X</em> amount of times!</p>
              <p>Say <strong>HELLO</strong> if you want me to<br>greet you again.</p>
              <p>Type <strong>ADVANCED</strong><br>if you want to know more options!</p>"
  end

  def self.random
    answer = ["Have you tried turning if off and on again?",
            "Sorry, I have two left flippers.",
            "We're birds! We have hollow bones!",
            "<strong><em>PLEASE</em></strong> stop abusing the ask button.",
            "Did you forget to add a semicolon?",
            "Maybe you forgot a comma somewhere?",
            "Maybe you added an 's' to<br>something by mistake in ActiveRecord.",
            "Maybe you should take a walk?",
            "I didn't quite understand that,<br>but let me tell you, life is great.",
            "Take care of yourself.",
            "Let's put a \"binding.pry\" in there.",
            "Being an omnipotent rubber ducky has its benefits.",
            "Maybe it's time for some <a href='https://caturday-funtime.herokuapp.com/'>Caturday Funtime!</a>"].sample
  end

  def self.google(search)
    if !search[1].nil?
      statement = search.join(" ").capitalize
      query = self.query(search)
      answer = "\"#{statement}?\" <br> <a href='http://www.google.com/#q=#{query}' target='_blank'>Let me google that for you.</a>"
    else
      answer ="<p>Remember:<br><strong>GOOGLE</strong> <em>something</em> OR</p>
      <strong>G</strong> <em>something</em> if you want to jump<br>
        immedately to Google.</p>"
    end
  end

  def self.wikipedia(subject)
    if !subject[1].nil?
      subject.shift
      statement = subject.join(" ").capitalize
      query = subject.join("+")
      answer = "\"#{statement}?\" <br> <a href='http://en.wikipedia.org/w/index.php?search=#{query}' target='_blank'>Let me Wikipedia that.</a>"
    else
      answer ="<p>Remember:<br><strong>WIKIPEDIA</strong> <em>something</em> OR</p>
      <strong>W</strong> <em>something</em> if you want to jump<br>
      immedately to Wikipedia.</p>"
    end
  end

  def self.overflow(question)
    if !question[1].nil?
      question.shift
      statement = question.join(" ").capitalize
      query = self.query(question)
      answer = "\"#{statement}?\"<br><a href='http://stackoverflow.com/search?q=#{query}' target='_blank'>Let's look at Stack Overflow.</a>"
    else
      answer ="<p>Remember:<br><strong>OVERFLOW</strong> <em>programming questions</em> OR</p>
      <strong>O</strong> <em>something</em> if you want to jump<br>
      immedately to StackOverflow.</p>"
    end
  end

  def self.reddit(subreddit)
    if !subreddit[1].nil?
      subreddit.shift
      statement = subreddit.join(" ")
      query = self.query(subreddit)
      answer = "\"#{statement}?\"<br><a href='http://www.reddit.com/search?q=#{query}' target='_blank'>Let's look at Reddit.</a>"
    else
      answer ="<p>Remember:<br><strong>REDDIT</strong> <em>subreddit</em> OR</p>
      <strong>R</strong> <em>subreddit</em> if you want to jump<br>
      immedately to that Sub-Reddit.</p>"
    end
  end

  def self.advanced
    answer = "<p>Some fancy stuff for Pro users:</p>
    <p><strong>G, W, O,</strong> and <strong>R</strong> directly bring you to<br>
    Google, Wikipedia, StackOverflow, and Reddit.
    <p>Typing <strong>RUBY</strong> provides a link to the Ruby docs.</p>
    <p>Typing <strong>WHY</strong> tells you a bit<br>about \"Rubber duck debugging\"."
  end

  def self.about
    answer = "<p><strong>Hey there!</strong></p>
              <p>I was created by a human named<br> <a href=\"http://alacritystudios.com/\">Andy Wong</a>,
              who is a Ruby on Rails<br>apprentice at <a href=\"http://www.launchacademy.com/\">Launch Academy</a>.</p>
              <p>My <a href=\"https://github.com/alacritythief/ask-the-duck\">code</a> backend is made with<br>Ruby and <a href=\"http://www.sinatrarb.com/\">Sinatra</a>,
              and everything<br>was made in one day for the<br>
              \"Ship-It Saturday\" hackathon there.</p>
              <p>Credit goes to <a href=\"http://en.wikipedia.org/wiki/Rubber_Duck_(sculpture)\">Florentijn Hofman</a> for the<br>
              handsome duck you see in front of you.</p>"
  end
end

# HELPERS

helpers do
  def partial (template, locals = {})
    erb(template, :layout => false, :locals => locals)
  end
end

# ROUTES

get '/' do
  @answer = Duck.greeting
  erb :index
end

post'/' do
  @question = Duck.parse(params[:question])
  @case_question = Duck.nocase_parse(params[:question])

  if @question.empty?
    @answer = Duck.random
  elsif @question.first.include? "hello"
    @answer = Duck.greeting
  elsif @question.first.include? "quack"
    @number = @question[1].to_i
    @answer = Duck.quack(@number)
  elsif @question.first.include? "ruby"
    @answer = "Have you checked the <a href='http://www.ruby-doc.org/core-2.1.3/' target='_blank'>Ruby</a> docs?"
  elsif @question.first.include? "google"
    @answer = Duck.google(@question)
  elsif @question.first == "g"
    if !@question[2].nil?
      @query = Duck.query(@question)
      redirect "http://www.google.com/#q=#{@query}"
    else
      redirect "http://www.google.com/"
    end
  elsif @question.first.include? "wikipedia"
    @answer = Duck.wikipedia(@question)
  elsif @question.first == "w"
    if !@question[2].nil?
      @query = Duck.query(@question)
      redirect "http://en.wikipedia.org/w/index.php?search=#{@query}"
    else
      redirect "http://en.wikipedia.org/"
    end
  elsif @question.first.include? "overflow"
    @answer = Duck.overflow(@question)
  elsif @question.first == "o"
    if !@question[2].nil?
      @query = Duck.query(@question)
      redirect "http://stackoverflow.com/search?q=#{@query}"
    else
      redirect "http://stackoverflow.com/"
    end
  elsif @question.first.include? "reddit" || @question.first == r
    @answer = Duck.reddit(@case_question)
  elsif @question.first == "r"
    if !@question[2].nil?
      @query = Duck.query(@case_question)
      redirect "http://www.reddit.com/r/#{@query}"
    else
      redirect "http://www.reddit.com/"
    end
  elsif @question.first.include? "help"
    @answer = Duck.help
  elsif @question.first.include? "advanced"
    @answer = Duck.advanced
  elsif @question.first.include? "why"
    redirect "http://en.wikipedia.org/wiki/Rubber_duck_debugging"
  elsif @question.first.include? "about"
    @answer = Duck.about
  else
    @answer = Duck.random
  end

  erb :index
end


