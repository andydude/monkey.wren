
class Node {
	toString {
		return "UnknownNode"
	}
}

class Declaration is Node {
}

class Statement is Node {
}

class Expression is Node {
}

class Literal is Node {
}

class Program is Node {
	body { _body }
	construct new(body) {
		if (body is BlockStatement == false) {
			Fiber.abort("expected BlockStatement")
		}
		_body = body
	}
	toString {
		var inner = _body.toString
		var res = ""
		for (i in 1..(inner.count - 2)) {
			res = res + inner[i]
		}
		return res
	}
}

class BlockStatement is Statement {
	statements { _statements }
	construct new(stmts) {
		_statements = stmts
	}
	toString {
		var repr = "{"
		if (_statements.count == 0) {
			repr = repr + "}"
			return repr
		}

		for (st in _statements) {
			repr = repr + st.toString
		}
		
		repr = repr + "}"
		return repr
	}
}

class LetStatement is Statement {
	name { _name }
	value { _value }
	construct new(name, value) {
		_name = name
		_value = value
	}
	toString {
		return "let " + name.toString + " = " + value.toString + ";"
	}
}

class ReturnStatement is Statement {
	expression { _expression }
	construct new(expression) {
		_expression = expression
	}
	toString {
		return "return " + _expression.toString + ";"
	}
}

class ExpressionStatement is Statement {
	expression { _expression }
	construct new(expression) {
		if (expression == null) {
			Fiber.abort("null expression statement")
		}
		_expression = expression
	}
	toString {
		return _expression.toString + ";"
	}
}

class BinaryExpression is Expression {
	operator { _op }
	left { _left }
	right { _right }
	construct new(op, left, right) {
		_op = op
		_left = left
		_right = right
	}
	toString {
		return _left.toString + " " + _op.text + " " + _right.toString
	}
}

class UnaryExpression is Expression {
	operator { _op }
	inner { _inner }
	construct new(op, inner) {
		_op = op
		_inner = inner
	}
	toString {
		return _op.text + " " + _inner.toString
	}
}

class CallExpression is Expression {
	target { _target }
	args { _args }
	construct new(target, args) {
		_target = target
		_args = args
	}
	toString {
		var inner = _args.toString
		var res = ""
		for (i in 1..(inner.count - 2)) {
			res = res + inner[i]
		}
		return _target.toString + "(" + res + ")"
	}
}

class IndexExpression is Expression {
	target { _target }
	index { _index }
	construct new(target, index) {
		_target = target
		_index = index
	}
	toString {
		return _target.toString + "[" + _index.toString + "]"
	}
}

class FunctionExpression is Expression {
	name { _name }
	name=(name) {
		// This is a rare exception where
		// we actually need a setter method
		_name = name
	}
	
	parameterList { _parameterList }
	bodyStatement { _bodyStatement }
	construct new(name, params, body) {
		if (name != null && name is Identifier == false) {
			Fiber.abort("expected Identifier")
		}
		if (params is List == false) {
			Fiber.abort("expected List")
		}
		if (body is BlockStatement == false) {
			Fiber.abort("expected BlockStatement")
		}
		_name = name
		_parameterList = params
		_bodyStatement = body
	}
	toString {
		var res = "fn"
		if (_name != "_") {
			res = res + " " + _name.toString
		}
		res = res + "("
		var inner = _parameterList.toString
		if (_parameterList.count > 0) {
			for (i in 1..(inner.count - 2)) {
				res = res + inner[i]
			}
		}
		res = res + ") "
		res = res + _bodyStatement.toString
		return res
	}
}

class IfExpression is Expression {
	condition { _condition }
	thenExpression { _thenExpression }
	elseExpression { _elseExpression }
	construct new(condition, thenExp, elseExp) {
		_condition = condition
		_thenExpression = thenExp
		_elseExpression = elseExp
	}
}

class Identifier is Expression {
	name { _name }
	construct new(name) {
		_name = name
	}
	toString {
		return _name
	}
}

class LiteralExpression is Expression {
	literal { _literal }
	construct new(literal) {
		_literal = literal
	}
}

class BooleanLiteral is Literal {
	bool { _bool }
	construct new(bool) {
		if (bool is Bool == false) {
			Fiber.abort("Expected Boolean")
		}
		_bool = bool
	}
}

class EmptyLiteral is Literal {
	construct new() {}
	toString {
		return "null"
	}
}

class IntegerLiteral is Literal {
	num { _num }
	construct new(num) {
		if (num is Num == false) {
			Fiber.abort("Expected Number")
		}
		_num = num
	}
	toString {
		return _num.toString
	}
}

class StringLiteral is Literal {
	str { _str }
	construct new(str) {
		if (str is String == false) {
			Fiber.abort("Expected String")
		}
		_str = str
	}
	toString {
		return "\"" + _str + "\""
	}
}

class ArrayLiteral is Literal {
	elems { _elems }
	construct new(elems) {
		_elems = elems
	}
	toString {
		var elemstr = ""
		if (_elems.count > 0) {
			elemstr = elemstr + _elems[0].toString
			for (i in 1.._elems.count - 1) {
				elemstr = elemstr + ", " + _elems[i].toString
			}
		}
		return "[" + elemstr + "]"
	}
}

class HashLiteral is Literal {
	members { _members }
	construct new (members) {
		_members = members
	}
	toString {
		var elemstr = ""
		if (_members.count > 0) {
			elemstr = elemstr + _members[0].toString
			for (i in 1.._members.count - 1) {
				elemstr = elemstr + ", " + _members[i].toString
			}
		}
		return "{" + elemstr + "}"
	}
}

class HashMember {
	key { _key }
	value { _value }
	construct new (key, value) {
		_key = key
		_value = value
	}
	toString {
		return _key.toString + ": " + _value.toString
	}
}
