class PrattEntry {
	// kind is a number like Tok["PLUS"]
	kind { _kind }

	// prec is a number like 2
	prec { _prec }

	// assoc is a boolean like
	// false, implying Left-associative (or Prefix)
	// true, implying Right-associative
	assoc { _assoc }

	// parser is a function
	parser { _parser }

	construct new(kind, prec, assoc, parser) {
		_kind = kind
		_prec = prec
		_assoc = assoc
		_parser = parser
	}
}

class PrattParser {
	lexer { _lexer }
	previousToken { _previousToken }
	nextToken { _nextToken }
	defaultPrec { _defaultPrec }
	prefixTable { _prefixTable }
	infixTable { _infixTable }
	
	construct new(lexer, defaultPrec, prefixTable, infixTable) {
		_lexer = lexer
		_previousToken = null
		_nextToken = null
		_defaultPrec = defaultPrec
		_prefixTable = prefixTable
		_infixTable = infixTable
	}

	// monkey nextToken()
	// lox advance()
	// here advance
	advance() {

		// monkey .curToken
		// lox .previous
		// here previousToken
		_previousToken = _nextToken

		// monkey .peekToken
		// lox .current
		// here nextToken
		_nextToken = _lexer.nextToken()
	}
	
	// monkey ?
	// lox consume
	consume(kind, message) {
		if (!check(kind)) {
			Fiber.abort(message)
		}
		advance()
		return
	}

	// monkey expectPeek
	// lox match
	match(kind) {
		if (!check(kind)) {
			return false
		}
		advance()
		return true
	}

	// monkey peekTokenIs
	// lox check
	check(kind) {
		if (_nextToken == null) {
			return false
		}
		return _nextToken.kind == kind
	}

	checkPrevious(kind) {
		if (_previousToken == null) {
			return false
		}
		return _previousToken.kind == kind
	}

	// monkey peekPrecedence
	// lox ?
	getPrecedence(opToken) {
		// if (opToken == null) {
		// 	return _defaultPrec
		// }
		var prec = _infixTable[opToken.kind.value]
		if (prec == null) {
			return _defaultPrec
		}
		return prec.prec
	}

	isEofish(token) {
		if (token.kind.name == "EOF") {
			return true
		}
		if (token.kind.name == "COMMA") {
			return true
		}
		if (token.kind.name == "RPAREN") {
			return true
		}
		if (token.kind.name == "RBRACK") {
			return true
		}
		if (token.kind.name == "RBRACE") {
			return true
		}
		if (token.kind.name == "SEMICOLON") {
			return true
		}
		
		return false
	}
	
	parsePrecedence(minPrec) {
		if (isEofish(_nextToken)) {
			return null
		}
		
		var left = parsePrefixSelector(_nextToken)
		var prec = 0
		if (left == null) {
			return null
		}

		while (true) {
			if (isEofish(_nextToken)) {
				break
			}
			
			// System.print("prec " + _nextToken.kind.name)
			prec = getPrecedence(_nextToken)
			// System.print("curPrec " + prec.value.toString)
			// System.print("minPrec " + minPrec.value.toString)
			if (prec.value > minPrec.value) {
				System.print("Got bad precedence")
				break
			}
			advance()
			
			var right = parseInfixSelector(_previousToken, left)
			if (right == null) {
				System.print("Got null right")
				break
			}
			left = right
		}

		return left
	}

	// parsePrefixSelector(opToken) {
	// 	// not implemented
	// }
	// 
	// parseInfixSelector(opToken, left) {
	// 	// not implemented
	// }	
}
