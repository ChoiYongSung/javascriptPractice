<%@ page language="java" contentType="text/html; charset=EUC-KR"
		pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>1��</title>

<style type="text/css">
svg {
	width: 300px;
	height: 200px;
	border: 1px solid black;
}

path {
	stroke: black;
	stroke-width: 2;
	fill: none;
}
</style>
<script src="//d3js.org/d3.v3.min.js"></script>
</head>
<body>
	<svg>
		<path id="pathFromArrays" />
	</svg>
	<svg>
		<path id="pathFromObjects" />
	</svg>
	<svg>
		<path id="pathFromFunction" />
	</svg>

<script type="text/javascript">
	// �ٸ� ���� ������ �浹�� ���ϱ� ���� ��Ī������ �����Ѵ�.
	var rj3 = {};

	// svg��� ���� ��Ī������ �����.
	rj3.svg = {};

	// rj3.svg ��Ī������ line �Լ��� �ִ´�.
	rj3.svg.line = function() {
		var getX = function(point) {
			return point[0];
		},
		getY = function(point) {
			return point[1];
		},
		interpolate = function(points) {
			return points.join("L");
		};

		function line(data) {
			var segments = [],
				points = [],
				i = -1,
				n = data.length,
				d;

			function segment() {
				segments.push("M",interpolate(points));
			}

			while (++i < n) {
				d = data[i];
				points.push([+getX.call(this,d,i), +getY.call(this,d,i)]);
			}

			if (points.length) {
				segment();
			}

			return segments.length ? segments.join("") : null;
		}

		line.x = function(funcToGetX) {
			if (!arguments.length) return getX;
			getX = funcToGetX;
			return line;
		};

		line.y = function(funcToGetY) {
			if (!arguments.length) return getY;
			getY = funcToGetY;
			return line;
		};

		return line;
	};
	
	(function() {
		var arrayData = [
			[10,130],
			[100,60],
			[190,160],
			[280,10]
		],
		lineGenerator = rj3.svg.line(),
		path = lineGenerator(arrayData);
	
		document.getElementById('pathFromArrays').setAttribute('d',path);
	}());
	
	(function() {
		var objectData = [
			{ x: 10, y: 130 },
			{ x: 100, y: 60 },
			{ x: 190, y: 160 },
			{ x: 280, y: 10 }
		],
		lineGenerator = rj3.svg.line()
			.x(function(d) { return d.x; })
			.y(function(d) { return d.y; }),
		path = lineGenerator(objectData);

		document.getElementById('pathFromObjects').setAttribute('d',path);
	}());


	rj3.svg.samples = {};

	rj3.svg.samples.functionBasedLine = function functionBasedLine() {
		var firstXCoord = 10,
			xDistanceBetweenPoints = 50,
			lineGenerator,
			svgHeight = 200; // �½��ϴ�, �̷��� �ϸ� �ȵ���^^

		lineGenerator = rj3.svg.line()
			.x(function(d,i) { return firstXCoord + i * xDistanceBetweenPoints; })
			.y(function(d) { return svgHeight - this.getValue(d); });

		return lineGenerator;
	};

	(function() {
		var yearlyPriceGrapher = {
			lineGenerator: rj3.svg.samples.functionBasedLine(),

			getValue: function getValue(year) {
				// ��ġ �� ����ó�� ȣ���մϴ�!
				return 10 * Math.pow(1.8, year-2010);
			}
		},
		years = [2010, 2011, 2012, 2013, 2014, 2015],
		path = yearlyPriceGrapher.lineGenerator(years);

		document.getElementById('pathFromFunction').setAttribute('d',path);
	}());
	</script>
</body>
</html>