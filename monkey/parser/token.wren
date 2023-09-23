import "./enum" for Enum

var Prec = Enum.new("Prec", [
	"POST",
	"PRE",
	"FACTOR",
	"TERM",
	"SHIFT",
	"REL",
	"EQUAL",
	// "BITAND",
	// "BITXOR",
	// "BITOR",
	// "LOGAND",
	// "LOGOR",
	// "COND",
	// "ASSIGN",
	"KEY",
	// "COMMA",

	// pseudo-precedence
	"LAST",
])

var Tok = Enum.new("Tok", [
	"EOF",

	// operators
	"BANG",
	"BANG_EQ",
	"COLON",
	"COMMA",
	"EQ",
	"EQ_EQ",
	"GT",
	"LT",
	"MINUS",
	"PLUS",
	"SEMICOLON",
	"SOL",
	"STAR",
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

	// pseudo-token
	"LAST",
])

class Token {
	kind { _kind }
	text { _text }

	construct new(kind, text) {
		_kind = kind
		_text = text
	}
}
