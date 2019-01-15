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
	};
	
	DiContainer.prototype.messages = {
		registerRequiresArgs: '이 생성자 함수는 인자가 3개 있어야 합니다: ' +
			'문자열, 문자열 배열, 함수.'
	};
	
	DiContainer.prototype.register = function(name,dependencies,func) {
		var ix;
	
		if (typeof name !== 'string'
		|| !Array.isArray(dependencies)
		|| typeof func !== 'function') {
			throw new Error(this.messages.registerRequiresArgs);
		}
		for (ix=0; ix<dependencies.length; ++ix) {
			if (typeof dependencies[ix] !== 'string') {
				throw new Error(this.messages.registerRequiresArgs);
			}
		}
	};
	
	describe('DiContainer', function() {
		var container;
		beforeEach(function() {
			container = new DiContainer();
		});
		describe('register(name,dependencies,func)', function() {
			// 01
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
					}).toThrow();
				});
			});
		});
	});
</script>
</body>
</html>