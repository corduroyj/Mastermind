# define number display hashes
def code_colors(number)
  {
    "1" => "\e[101m  1  \e[0m ",
    "2" => "\e[43m  2  \e[0m ",
    "3" => "\e[44m  3  \e[0m ",
    "4" => "\e[45m  4  \e[0m ",
    "5" => "\e[46m  5  \e[0m ",
    "6" => "\e[41m  6  \e[0m ",
  }[number]
end

def clue_colors(clue)
  {
    "*" => "\e[91m\u25CF\e[0m ",
    "?" => "\e[37m\u25CB\e[0m ",
  }[clue]
end

#gets a choice of what game is played
def getChoice
  input = gets.chomp
  if input == 0 || 1
    return input
  else
    getChoice
  end
end

#gets the code from the player
def getCode
  input = gets.chomp
  if input.match?(/[1-6]{4}/)
    return input.split("")
  else
    getCode
  end
end

#game loop for computer codebreaker
def compBreaker(code)
  trialCode = []
  finalCode = ["", "", "", ""]
  $j = 0
  
  while $j < 8
    trialCode = compCode(finalCode)
    codeCheck(code, trialCode, finalCode)
    if code == finalCode
      $j = 10
    end
    $j += 1
    sleep 1
    
  end
  if $j == 8
    puts "Didn't guess the code correctly :("
  elsif $j == 11
    puts "Code guessed correctly :)"
  end
end

#object for computer to generate
def compCode (final)
  trialCode = [(rand(6) + 1).to_s, (rand(6) + 1).to_s, (rand(6) + 1).to_s, (rand(6) + 1).to_s]
  puts
  $k = 0
  while $k < 4
    if final[$k] != ""
      trialCode[$k] = final[$k] 
    end
    $k += 1
  end
  print "Trial Code is: "
  printCode(trialCode)
  return trialCode
end

def breakerCode
  [(rand(6) + 1).to_s, (rand(6) + 1).to_s, (rand(6) + 1).to_s, (rand(6) + 1).to_s]
end

#object for computer to check code
def codeCheck(code, trialCode, finalCode = ["","","",""])
  $i = 0
  while $i < 4
    if code[$i] == trialCode[$i]
      finalCode[$i] = trialCode[$i]
      trialCode[$i] = "0"
      print clue_colors('*')
    elsif trialCode.include?(code[$i])
      print clue_colors('?')
    end
    $i += 1
  end
  # print "finalCode is: #{finalCode}"
  return finalCode
end

#object which starts game after game choice is made
def playMaker
  puts ""
  puts "You are CodeMaker! choose a four digit code using numbers from 1 to 6"
  print "Your code: "
  code = getCode
  printCode(code)
  
  compBreaker(code)
end

def playBreaker
  puts ""
  puts "You are CodeBreaker! Try to guess the computers generated code"
  compCode = breakerCode
  playerCode = []
  $h = 0
  while $h < 8
    print "Enter code guess: "
    playerCode = getCode
    printCode(playerCode)
    if playerCode == compCode
      puts "You guessed the code! Looks like you are a real <GOOGLE FAMOUS CODEBREAKER NAME>!"
      $h = 10
    end
    codeCheck(compCode, playerCode)
    $h += 1
  end
  if $h == 8
    puts "Looks like you couldn't guess the code :("
    puts "code was:"
    printCode(compCode)
  end
end

def startPlay
  choice = getChoice
  
  if choice == '0'
    playMaker
  elsif choice == '1'
    playBreaker
  end
end

def printCode(code)
  puts "( #{code_colors(code[0])} #{code_colors(code[1])} #{code_colors(code[2])} #{code_colors(code[3])})"  
end

puts "Welcome to Mastermind"
puts "In this game, one player creates a 'code' of four numbers from 1 - 6"
puts "#{code_colors("1")} #{code_colors("2")} #{code_colors("3")} #{code_colors("4")} #{code_colors("5")} #{code_colors("6")}"
puts "and another player (or perhaps computer) tries to break the code"
puts "they do this by guessing the numbers with their own code!"
puts "if any of the codebreakers numbers are in the same position as the codemaker you will see a #{clue_colors("*")}"
puts "and if any of the numbers are right at all, you will see a #{clue_colors("?")}"
puts ""
puts "Do you want to be codemaker or codebreaker?"
print "enter 0 for maker, 1 for breaker: "

startPlay


