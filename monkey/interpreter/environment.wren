class EnvMap {
	maps { _maps }

	construct new(m) {
		if (m == null) {
			_maps = [{}]
		} else if (m is Map) {
			_maps = [m]
		} else if (m is List) {
			_maps = m
		}
	}

	construct new() {
		new({})
	}

	newChild(m) {
		return EnvMap.new([m] + _maps)
	}

	newChild() {
		return newChild({})
	}

	getParent() {
		return EnvMap.new(_maps[1..._maps.count])
	}
	
	containsKey(key) {
		for (m in _maps) {
			if (m.containsKey(key)) {
				return true
			}
		}
		return false

	}
	
	missingKey() {
		return null
	}
	
	[key] {
		for (m in _maps) {
			if (m.containsKey(key)) {
				return m[key]
			}
		}
		return missingKey()
	}
	
	[key]=(value) {
		_maps[0][key] = value
	}
}
