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
	function createReservation(passenger, flight, saver) {
		var reservation = {
			passengerInformation: passenger,
			flightInformation: flight
		};

		saver.saveReservation(reservation);
		return reservation;
	}

	// 샬롯이 작성한 ReservationSaver
	function ReservationSaver() {
		this.saveReservation = function(reservation) {
			// 예약 정보를 저장하는 웹서비스와 연동하는 복잡한 코드가 있을 것이다.
		};
	}
	
	describe('createReservation(passenger, flight, saver)', function() {
		var testPassenger = null,
			testFlight = null,
			testReservation = null,
			testSaver = null;

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

			testSaver = new ReservationSaver();
			spyOn(testSaver, 'saveReservation');

			testReservation = createReservation(testPassenger, testFlight, testSaver);
		});

		it('passenger를 passengerInformantion 프로퍼티에 할당한다', function() {
			expect(testReservation.passengerInformation).toBe(testPassenger);
		});

		it('주어진 flight를 flightInformation 프로퍼티에 할당한다', function() {
			expect(testReservation.flightInformation).toBe(testFlight);
		});

		it('예약 정보를 저장한다', function() {
			expect(testSaver.saveReservation).toHaveBeenCalled();
		});
	});
</script>
</body>
</html>