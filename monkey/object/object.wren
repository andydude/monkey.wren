class MonkeyObject {}

class ReturnValue is MonkeyObject {
	value { _value }
	construct new(value) {
		_value = value
	}
}

class Function is MonkeyObject {
	name { _name }
	parameters { _parameters }
	body { _body }
	env { _env }

	construct new(name, parameters, body, env) {
		_name = name
		_parameters = parameters
		_body = body
		_env = env
	}
}
