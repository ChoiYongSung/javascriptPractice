<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>DI 2</title>
	<link data-require="jasmine@2.0.0" data-semver="2.0.0" rel="stylesheet" href="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.css" />
	<script data-require="jasmine@2.0.0" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.js"></script>
	<script data-require="jasmine@2.0.0" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine-html.js"></script>
	<script data-require="jasmine@2.0.0" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/boot.js"></script>
</head>
<body>
<script>
DiContainer = function() {
	// 생성자에 의해 객체가 생성되도록 강제한다.
	if (!(this instanceof DiContainer)) {
		return new DiContainer();
	}

	this.registrations = [];
};

DiContainer.prototype.messages = {
	registerRequiresArgs: '이 생성자 함수는 인자가 3개 있어야 합니다: ' +
		'문자열, 문자열 배열, 함수.'
};

DiContainer.prototype.register = function(name,dependencies,func) {

	var ix;

	if (typeof name !== 'string' ||
		 !Array.isArray(dependencies) ||
		 typeof func !== 'function') {
		throw new Error(this.messages.registerRequiresArgs);
	}
	for (ix=0; ix<dependencies.length; ++ix) {
		if (typeof dependencies[ix] !== 'string') {
			throw new Error(this.messages.registerRequiresArgs);
		}
	}

	this.registrations[name] = { dependencies: dependencies, func: func };
};

DiContainer.prototype.get = function(name) {
	var self = this,
			registration = this.registrations[name],
			dependencies = [];
	if (registration === undefined) {
		return undefined;
	}

	registration.dependencies.forEach(function(dependencyName) {
		var dependency = self.get(dependencyName);
		dependencies.push( dependency === undefined ? undefined : dependency);
	});
	return registration.func.apply(undefined, dependencies);
};

describe('DiContainer', function() {
	var container;
	beforeEach(function() {
		container = new DiContainer();
	});
	describe('register(name,dependencies,func)', function() {

		it('인자가 하나라도 누락되었거나 타입이 잘못되면 예외를 던진다', function() {
			var badArgs = [
				// 인자가 아예 없는 경우
				[],
				// name만 있는 경우
				['Name'],
				// name과 dependencies만 있는 경우
				['Name',['Dependency1','Dependency2']],
				// dependencies가 누락된 경우
				// (상용 프레임워크는 지원하지만 DiContainer는 지원하지 않음)
				['Name', function() {}],
				// 타입이 잘못된 다양한 사례들
				[1,['a','b'], function() {}],
				['Name',[1,2], function() {}],
				['Name',['a','b'], 'should be a function']
			];
			badArgs.forEach(function(args) {
				expect(function() {
					container.register.apply(container,args);
				}).toThrowError(container.messages.registerRequiresArgs);
			});
		});
	});

	describe('get(name)', function() {

		it('성명이 등록되어 있지 않으면 undefined를 반환한다', function() {
			expect(container.get('notDefined')).toBeUndefined();
		});

		it('등록된 함수를 실행한 결과를 반환한다', function() {
			var name = 'MyName',
					returnFromRegisteredFunction = "something";
			container.register(name,[], function() {
				return returnFromRegisteredFunction;
			});
			expect(container.get(name)).toBe(returnFromRegisteredFunction);
		});

		it('등록된 함수에 의존성을 제공한다', function() {
			var main = 'main',
					mainFunc,
					dep1 = 'dep1',
					dep2 = 'dep2';
			container.register(main,[dep1,dep2], function(dep1Func, dep2Func) {
				return function() {
					return dep1Func() + dep2Func();
				};
			});
			container.register(dep1,[], function() {
				return function() {
					return 1;
				};
			});
			container.register(dep2,[], function() {
				return function() {
					return 2;
				};
			});
			mainFunc = container.get(main);
			expect(mainFunc()).toBe(3);
		});

		it('의존성을 재귀적으로 제공한다', function() {
			var level1 = 'one',
				level2 = 'two',
				level3 = 'three',
				result = [];
			container.register(level1,[level2], function(level2func) {
				return function() {
					result.push(level1);
					level2func();
				};
			});
			container.register(level2,[level3], function(level3func) {
				return function() {
					result.push(level2);
					level3func();
				};
			});
			container.register(level3,[], function() {
				return function() {
					result.push(level3);
				};
			});

			container.get(level1)();
			expect(result).toEqual([level1,level2,level3]);
		});
	});
});
</script>
</body>
</html>