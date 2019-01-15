<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>linting</title>
<!-- 재스민 라이브러리 파일 -->
<link data-require="jasmine@*" data-semver="2.0.0" rel="stylesheet" href="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.css" />
<script data-require="jasmine@*" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.js"></script>
<script data-require="jasmine@*" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine-html.js"></script>
<script data-require="jasmine@*" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/boot.js"></script>
</head>
<body>
<script type="text/javascript">
	function calculateUpgradeMileages(tripMileages, memberMultiplier) {
		var upgradeMileage = [], i = 0;
		for (i = 0; i < tripMileages.length; i++) {
			var calcRewardsMiles = function(mileage) {
				return mileage * memberMultiplier;
			};
			upgradeMileage[i] = calcRewardsMiles(tripMileages[i]);
		}
		return upgradeMileage;
	}

	describe('calculateUpgradeMileages(tripMileages, memberMultiplier', function() {
		var testPassenger = null;
	
		beforeEach(function() {
			testPassenger = {
				firstName : '일웅',
				lastName : '이',
				tripMileages : [
					500,
					600,
					3400,
					2500
				]
			};
		});
	
		it('배율이 1.0이면 원래 마일리지를 반환한다', function() {
			expect(calculateUpgradeMileages(testPassenger.tripMileages, 1.0)).toEqual(testPassenger.tripMileages);
		});
	
		it('배율이 3.0이면 해당 마일리지를 계산하여 반환한다', function() {
			var expectedResults = [], multiplier = 3.0;

			for (var i = 0; i<testPassenger.tripMileages.length; i++) {
				expectedResults[i] = testPassenger.tripMileages[i] * multiplier;
			}

			expect(calculateUpgradeMileages(testPassenger.tripMileages, multiplier))
				.toEqual(expectedResults);
		});
	});
</script>
</body>
</html>