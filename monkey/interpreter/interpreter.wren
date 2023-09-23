import "./environment" for EnvMap
import "../object/object" for ReturnValue, Function
import "../ast/ast" for
	ArrayLiteral,
	BinaryExpression,
	BlockStatement,
	BooleanLiteral,
	CallExpression,
	EmptyLiteral,
	Expression,
	ExpressionStatement,
	FunctionExpression,
	HashLiteral,
	HashMember,
	Identifier,
	IfExpression,
	IndexExpression,
	IntegerLiteral,
	LetStatement,
	Literal,
	LiteralExpression,
	Node,
	Program,
	ReturnStatement,
	Statement,
	StringLiteral,
	UnaryExpression



class Interpreter {
	eval(node, env) {
		if (node is Program) {
			evalProgram(node, env)
		} else if (node is Literal) {
			evalLiteral(node, env)
		} else if (node is Expression) {
			evalExpression(node, env)
		} else if (node is Statement) {
			evalStatement(node, env)
		} else if (node is Node) {
			evalNode(node, env)
		} else {
			Fiber.abort("expected AST node")
		}
	}

	evalProgram(node, env) {
		return evalBlockStatement(node.body, env)
	}

	evalStatement(node, env) {
		if (node is BlockStatement) {
			evalBlockStatement(node, env)
		} else if (node is LetStatement) {
			evalLetStatement(node, env)
		} else if (node is ReturnStatement) {
			evalReturnStatement(node, env)
		} else if (node is ExpressionStatement) {
			evalExpressionStatement(node, env)
		} else {
			Fiber.abort("WTF")
		}
	}

	evalBlockStatement(node,  env) {
	}

	evalLetStatement(node, env) {
		var val = eval(node.Value, env)
		if (isError(val)) {
			return val
		}
		env[node.name.name] = val
	}

	evalReturnStatement(node, env) {
		var val = eval(node.returnValue, env)
		if (isError(val)) {
			return val
		}
		return ReturnValue.new(val)
	}

	evalExpressionStatement(node, env) {
		return eval(node.expression, env)
	}

	evalExpression(node, env) {
		if (node is IfExpression) {
			evalIfExpression(node, env)
		} else if (node is FunctionExpression) {
			evalFunctionExpression(node, env)
		} else if (node is BinaryExpression) {
			evalBinaryExpression(node, env)
		} else if (node is UnaryExpression) {
			evalUnaryExpression(node, env)
		} else if (node is CallExpression) {
			evalCallExpression(node, env)
		} else if (node is IndexExpression) {
			evalIndexExpression(node, env)
		} else if (node is LiteralExpression) {
			evalLiteralExpression(node, env)
		} else {
			Fiber.abort("WTF")
		}
	}

	evalBinaryExpression(node, env) {
	}

	evalUnaryExpression(node, env) {
	}

	evalIfExpression(node, env) {
	}

	evalFunctionExpression(node, env) {
	}

	evalCallExpression(node, env) {
	}

	evalIndexExpression(node, env) {
	}

	evalIdentifier(node, env) {
		if (env.containsKey(node.name)) {
			var val = env[node.name]
			return val
		}

		if (builtins.containsKey(node.name)) {
			return builtins[node.name]
		}

		return newError("identifier not found")
	}

	evalLiteralExpression(node, env) {
		return evalLiteral(node.literal, env)
	}

	evalLiteral(node, env) {
		if (node is BooleanLiteral) {
			evalBooleanLiteral(node, env)
		} else if (node is IntegerLiteral) {
			evalIntegerLiteral(node, env)
		} else if (node is StringLiteral) {
			evalStringLiteral(node, env)
		} else if (node is EmptyLiteral) {
			evalEmptyLiteral(node, env)
		} else if (node is ArrayLiteral) {
			evalArrayLiteral(node, env)
		} else if (node is HashLiteral) {
			evalHashLiteral(node, env)
		} else {
			Fiber.abort("WTF")
		}
	}

	evalBooleanLiteral(node, env) {
	}

	evalEmptyLiteral(node, env) {
	}

	evalIntegerLiteral(node, env) {
	}

	evalStringLiteral(node, env) {
	}

	evalArrayLiteral(node, env) {
	}

	evalHashLiteral(node, env) {
	}

	isTruthy(obj) {
		if (obj is Bool) {
			return obj
		} else if (obj == null) {
			return false
		} else {
			return true
		}
	}

	newError(message) {
		Fiber.abort(message)
	}

	isError(obj) {
		return false
	}

	evalExpressionList(exprs, env) {
		var result = []
		for (e in exprs) {
			result.add(eval(e, env))
		}
		return result
	}

	extendedFunctionEnv(fn, args) {
		var env = fn.env.newChild({})

		for (pi in 0...(fn.parameters.count)) {
			var p = fn.parameters[pi]
			env[p.name] = args[pi]
		}

		return env
	}
	applyFunction(fn, args) {
		//if (fn is Function) {
		//	var env = extendFunctionEnv(fn, args)
		//	var result = eval(fn.body, env)
		//	return result
		//} else if (fn is Fn) {
			return fn.call(args)
		//}
	}
}
