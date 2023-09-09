import "./enum" for Enum

var TokenKind = Enum.new("TokenKind", [
	"EOF",

	// operators
	"EQ_EQ",
	"BANG_EQ",
	"PLUS",
	"MINUS",
	"BANG",
	"STAR",
	"SOL",
	"LT",
	"GT",
	"EQ",
	"COMMA",
	"COLON",
	"SEMICOLON",
	"LPAREN",
	"RPAREN",
	"LBRACE",
	"RBRACE",
	"LBRACK",
	"RBRACK",
	
	// keywords
	"FUNCTION",
	"LET",
	"TRUE",
	"FALSE",
	"IF",
	"ELSE",
	"RETURN",

	// other
	"IDENT",
	"INTEGER_LIT",
	"STRING_LIT",
])

class Token {
	kind { _kind }
	text { _text }

	construct new(kind, text) {
		_kind = kind
		_text = text
	}
}
