import "./lexer" for Lexer
import "io" for Stdin, Stdout

var PROMPT = ">> "

while (true) {
	System.write(PROMPT)
	Stdout.flush()
	var line = Stdin.readLine()
	var lexer = Lexer.new(line)

	while (true) {
		var tok = lexer.nextToken()
		if (tok.kind.value == 0) break
		System.print(" - " + tok.text)
	}
}
