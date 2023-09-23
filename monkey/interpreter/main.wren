import "../parser/lexer" for Lexer
import "../parser/parser" for Parser
import "./interpreter" for Interpreter
import "io" for Stdin, Stdout

var PROMPT = ">> "

while (true) {
	System.write(PROMPT)
	Stdout.flush()
	var line = Stdin.readLine()
	var lexer = Lexer.new(line)
	var parser = Parser.new(lexer)
	var program = parser.parseProgram()
	var interp = Interpreter.evalProgram(program)
	System.print(" : " + program.toString)
}
