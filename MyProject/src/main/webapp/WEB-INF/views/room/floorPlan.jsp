<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="resources/css/floorPlan.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			var $tabs = $('a');
			$tabs.click(function() {
				$('box').addClass('hidden');
				$(this).next().removeClass('hidden');
			});
		});
	</script>
</head>
<body>

	<h1>Floor Plan</h1>
	
	<div class="container">
		<div class="wrap">
			<ul class="tab">
				<li id="mapTab1" class="ctn ctn1">
					<h3 class="title">
						<a href="#도면1">Deluxe(DXD)</a>
					</h3>
					<div id="도면1" class="box">
						<img src="resources/images/priceRoom/도면1.JPG" alt="도면1">
					</div>
				</li>
				<li id="mapTab2" class="ctn ctn2">
					<h3 class="title">
						<a href="#도면2">Deluxe(DXT)</a>
					</h3>
					<div id="도면2" class="hidden box">
						<img src="resources/images/priceRoom/도면2.JPG" alt="도면2">
					</div>
				</li>
			</ul>
		</div>
	</div>
	
</body>
</html>