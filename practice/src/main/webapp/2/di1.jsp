<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<title>DI 1</title>
	<link data-require="jasmine@2.0.0" data-semver="2.0.0" rel="stylesheet" href="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.css" />
	<script data-require="jasmine@2.0.0" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine.js"></script>
	<script data-require="jasmine@2.0.0" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/jasmine-html.js"></script>
	<script data-require="jasmine@2.0.0" data-semver="2.0.0" src="http://cdn.jsdelivr.net/jasmine/2.0.0/boot.js"></script>
</head>

<body>
<script type="text/javascript">
	/* Attendee = function(attendeeId) {
	
		// 'new'로 생성하도록 강제한다.
		if (!(this instanceof Attendee)) {
			return new Attendee(attendeeId);
		}
	
		this.attendeeId = attendeeId;
	
		this.service = new ConferenceWebSvc();
		this.messenger = new Messenger();
	};

	// 주어진 세션에 좌석을 예약 시도한다.
	// 성공/실패 여부를 메시지로 알려준다.
	Attendee.prototype.reserve = function(sessionId) {
		if (this.service.reserve(this.attendeeId, sessionId)) {
			this.messenger.success('좌석 예약이 완료되었습니다!' +
				' 고객님은 ' + this.service.getRemainingReservations() +
				' 좌석을 추가 예약하실 수 있습니다.');
		}	else {
			this.messenger.failure('죄송합니다, 해당 좌석은 예약하실 수 없습니다.');
		}
	}; */
	
	Attendee = function(service, messenger, attendeeId) {
		// 'new'로 생성하도록 강제한다.
		if (!(this instanceof Attendee)) {
			return new Attendee(attendeeId);
		}
		this.attendeeId = attendeeId;
		this.service = service;
		this.messenger = messenger;
	};
</script>
</body>

</html>