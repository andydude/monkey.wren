import "./token" for Token, TokenKind

class Lexer {
	input { _input }
	pos { _pos }
	pos=(pos) {
		_pos = pos
	}
	readPos { _readPos }
	readPos=(readPos) {
		_readPos = readPos
	}

	char { _char }
	char=(char) {
		_char = char
	}

	construct new(input) {
		_pos = 0
		_readPos = 0
		_input = input
		readChar()
	}
	
	nextToken() {
		var tok = null

		skipSpace()

		if (_char == "=") {
			if (peekChar() == "=") {
				var ch = _char
				readChar()
				var lit = ch + _char
				tok = Token.new(TokenKind["EQ_EQ"], lit)
			} else {
				tok = Token.new(TokenKind["EQ"], _char)
			}
		} else if (_char == "+") {
			tok = Token.new(TokenKind["PLUS"], _char)
		} else if (_char == "-") {
			tok = Token.new(TokenKind["MINUS"], _char)
		} else if (_char == "!") {
			if (peekChar() == "=") {
				var ch = _char
				readChar()
				var lit = ch + _char
				tok = Token.new(TokenKind["BANG_EQ"], lit)
			} else {
				tok = Token.new(TokenKind["BANG"], _char)
			}
		} else if (_char == "/") {
			tok = Token.new(TokenKind["SOL"], _char)
		} else if (_char == "*") {
			tok = Token.new(TokenKind["STAR"], _char)
		} else if (_char == "<") {
			tok = Token.new(TokenKind["LT"], _char)
		} else if (_char == ">") {
			tok = Token.new(TokenKind["GT"], _char)
		} else if (_char == ";") {
			tok = Token.new(TokenKind["SEMICOLON"], _char)
		} else if (_char == ":") {
			tok = Token.new(TokenKind["COLON"], _char)
		} else if (_char == ",") {
			tok = Token.new(TokenKind["COMMA"], _char)
		} else if (_char == "(") {
			tok = Token.new(TokenKind["LPAREN"], _char)
		} else if (_char == ")") {
			tok = Token.new(TokenKind["RPAREN"], _char)
		} else if (_char == "{") {
			tok = Token.new(TokenKind["LBRACE"], _char)
		} else if (_char == "}") {
			tok = Token.new(TokenKind["RBRACE"], _char)
		} else if (_char == "[") {
			tok = Token.new(TokenKind["LBRACK"], _char)
		} else if (_char == "]") {
			tok = Token.new(TokenKind["RBRACK"], _char)
		} else if (_char == "\"") {
			var lit = readString()
			tok = Token.new(TokenKind["STRING_LIT"], lit)
		} else if (_char == "\0") {
			tok = Token.new(TokenKind["EOF"], "")
		} else {
			if (isLetter(_char)) {
				var lit = readIdentifier()
				var kind = lookupIdent(lit)
				tok = Token.new(kind, lit)
				return tok
			} else if (isDigit(_char)) {
				var lit = readNumber()
				tok = Token.new(TokenKind["INTEGER_LIT"], lit)
				return tok
			} else {
				tok = Token.new(TokenKind["EOF"], "illegal")
			}
		}
		readChar()
		return tok
	}
	
	skipSpace() {
		while (_char == " " || _char == "\t" || _char == "\n" || _char == "\r") {
			readChar()
		}
	}
	
	readChar() {
		if (_readPos != null && _readPos >= _input.count) {
			_char = "\0"
		} else {
			_char = _input[_readPos]
		}
		_pos = _readPos
		_readPos = _readPos + 1
	}
	
	peekChar() {
		if (_readPos >= _input.count) {
			return 0
		} else {
			return _input[_readPos]
		}
	}
	
	readIdentifier() {
		var pos = _pos
		//System.print("RI" +_char)
		while (isLetter(_char)) {
			readChar()
		}
		var res = stringSlice(_input, pos, _pos)
		return res
	}
	
	readNumber() {
		var pos = _pos
		while (isDigit(_char)) {
			readChar()
		}
		var res = stringSlice(_input, pos, _pos)
		return res
	}
	
	readString() {
		var pos = _pos + 1
		while (true) {
			readChar()
			if (_char == "\"" || _char == "\0") {
				break
			}
		}
		var res = stringSlice(_input, pos, _pos)
		return res
	}

  isLetter(char) {
		if (char is Num) {
			System.print("isN")
			return true
		}
		if (char is String == false) {
			System.print("isL")
			Fiber.abort("isLetter expected String")
		}
		var ch = char.codePoints[0]
    return "a".codePoints[0] <= ch && ch <= "z".codePoints[0] || "A".codePoints[0] <= ch && ch <= "Z".codePoints[0] || ch == "_".codePoints[0]
  }
  
  isDigit(char) {
		var ch = char.codePoints[0]
  	return "0".codePoints[0] <= ch && ch <= "9".codePoints[0]
  }

  lookupIdent(ident) {
    var keywords = {
    	"fn":     TokenKind["FUNCTION"],
    	"let":    TokenKind["LET"],
    	"true":   TokenKind["TRUE"],
    	"false":  TokenKind["FALSE"],
    	"if":     TokenKind["IF"],
    	"else":   TokenKind["ELSE"],
    	"return": TokenKind["RETURN"],
    }
		
    if (keywords.containsKey(ident)) {
  		return keywords[ident]
  	}
		
  	return TokenKind["IDENT"]
  }
	
  stringSlice(s, first, past) {
		var rs = ""
		for (i in first...past) {
			rs = rs + s[i]
		}
		return rs
  }
}
