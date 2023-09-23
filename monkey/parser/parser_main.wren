import "./lexer" for Lexer
import "./parser" for Parser
import "io" for Stdin, Stdout

var PROMPT = ">> "

while (true) {
	System.write(PROMPT)
	Stdout.flush()
	var line = Stdin.readLine()
	var lexer = Lexer.new(line)
	var parser = Parser.new(lexer)
	var program = parser.parseProgram()
	System.print(" : " + program.toString)
}
