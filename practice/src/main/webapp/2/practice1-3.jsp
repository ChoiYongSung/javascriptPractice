<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 재스민 라이브러리 파일 -->
	<link data-require="jasmine@*" data-semver="2.0.0" rel="stylesheet" href="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.css" />
	<script data-require="jasmine@*" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.js"></script>
	<script data-require="jasmine@*" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine-html.js"></script>
	<script data-require="jasmine@*" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/boot.js"></script>
</head>
<body>
<script type="text/javascript">
	function createReservation(passenger, flight) {
		return {
			passengerInformation: passenger,
			flightInformation: flight
		};
	}
	
	describe('createReservation(passenger, flight)', function() {
		var testPassenger = null,
			testFlight = null,
			testReservation = null;

		beforeEach(function() {
			testPassenger = {
				firstName: '윤지',
				lastName: '김'
			};

			testFlight = {
				number: '3443',
				carrier: '대한항공',
				destination: '울산'
			};

			testReservation = createReservation(testPassenger, testFlight);
		});

		it('passenger를 passengerInformation 프로퍼티에 할당한다', function() {
			expect(testReservation.passengerInformation).toBe(testPassenger);
		});

		it('flight를 flightInformation 프로퍼티에 할당한다', function() {
			expect(testReservation.flightInformation).toBe(testFlight);
		});
	});
</script>
</body>
</html>