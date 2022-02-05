<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자페이지</title>
<!-- fontawesome-->
<script src="https://kit.fontawesome.com/7d7ec2f3ed.js"
	crossorigin="anonymous"></script>
<!-- Jquery-->
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
<!-- bootstrap-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
	crossorigin="anonymous"></script>
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- CSS -->
<link rel="stylesheet" href="/css/font.css">
<link rel="stylesheet" href="/css/header.css">
<link rel="stylesheet" href="/css/footer.css">
<link rel="stylesheet" href="/css/admin/adminIndex.css">
</head>
<body>
	<!--  Header -->
	<header>
		<div class="header_Container">
			<c:choose>
				<c:when test="${Admin != null}">
					<!----- admin 로그인 되었을 때,  ----->
					<ul class="header_list">
						<li><img src="${dto.profile_image}"
							style="max-width: 30px; max-height: 30px;"></li>

						<li>${Admin}</li>
						<!-- 수정중 -->
						<!-- 	<li><a href="/admin/adminIndex">관리페이지</a></li> -->
						<li><a href="/member/logout" id="logoutbtn"
							style="color: #f8d200; text-decoration: none;!important">로그아웃</a></li>

					</ul>
				</c:when>
			</c:choose>
		</div>
		<div class="div-wrap">
			<div class="nav_div">
				<div class="logo">
					<i class="fas fa-seedling"></i> <a href="/">00마켓</a>
				</div>
			</div>
		</div>
	</header>
	<main>
		<div class="main-container">
			<div class="main-left-container">
				<div class="top-div">관리자페이지</div>
				<div class="middle-div">
					<button type="button" class="control-btn">회원관리</button>
					<button type="button" class="question-btn">게시글 관리</button>
					<button type="button" class="report-btn">신고 관리</button>
					<button type="button" class="mem-statics-btn">회원통계</button>
					<button type="button" class="sell-statics-btn">판매통계</button>
				</div>
			</div>

			<!-- 회원 관리 페이지 -->

			<div class="main-right-container">
				<div class="control-page">
					<div class="control-top-div">회원관리</div>
					<div class="control-contents-div">
						<table>
							<tr>
								<th><input type="checkbox" id="checkAll">
								<th>번호
								<th>아이디
								<th>이름
								<th>우편번호
								<th>주소
								<th>상세주소
								<th>연락처
								<th>이메일
								<th>거래희망지역
							</tr>
							<c:forEach var="list" items="${list}" varStatus="status">
								<tr>
									<td><input type="checkbox" name="checkbox[]"
										class="checkbox${status.count}" value="${list.seq}">
									<td>${list.seq }
									<td>${list.id }
									<td>${list.name }
									<td>${list.zipcode }
									<td>${list.address1 }
									<td>${list.address2 }
									<td>${list.phone }
									<td>${list.email }
									<td>${list.prefer_location }
								</tr>
							</c:forEach>
							<tr>
								<td colspan="10">
									<button type="button" class="deleteBtn">회원탈퇴</button>
									<button type="button" class="updateBtn">회원정보수정</button>
							</tr>
						</table>
					</div>
				</div>

				<!-- 게시글 관리 페이지 -->

				<div class="question-page">
					<div class="question-top-div">게시글 관리</div>
					<div class="question-contents-div">
						<select class="selectSubject">
							<option value="전체보기">전체보기</option>
							<c:forEach var="blist" items="${blist}">
								<option value="${blist.subject}">${blist.subject}</option>
							</c:forEach>
						</select>
						<script>
							// select 문 바뀔 때,
							$(".selectSubject")
									.on(
											"change",
											function() {
												let option = $(
														".selectSubject option:selected")
														.val();
												$(
														"#boardListTable > tbody > tr:nth-child(n+2)")
														.hide();
												let temp = $("#boardListTable > tbody > tr > td:nth-child(3n):contains('"
														+ option + "')");
												$(temp).parent().show();

												if (option == "전체보기") {
													$(
															"#boardListTable > tbody > tr")
															.show();
												}

											});
						</script>

						<table id="boardListTable">
							<tr>
								<th><input type="checkbox" id="chkBoardAll">
								<th>글번호
								<th>글주제
								<th>내용
								<th>작성자
								<th>조회수
							</tr>

							<c:forEach var="blist" items="${blist}" varStatus="boardcount">
								<tr>
									<td><input type="checkbox"
										class="boardCheckBox${boardcount.count}"
										name="checkboxBoard[]" value="${blist.board_seq}">
									<td>${blist.board_seq}
									<td>${blist.subject}
									<td>${blist.contents}
									<td>${blist.writer}
									<td>${blist.view_count}
								</tr>

							</c:forEach>
						</table>
						<div class="btn-div">
							<button type="button" class="deleteBoardBtn">게시물삭제</button>
						</div>
					</div>
				</div>

				<!-- 신고 페이지 -->
				<div class="report-page">
					<div class="report-top-div">신고 페이지</div>
				</div>

				<!-- 회원통계 페이지 -->
				<div class="statistics-page">
					<div class="statistics-top-div">회원 통계</div>
					<div class="statistics-contents-div">
						<!-- monthList 뽑아오기 -->
						<c:forEach var="monthList" items="${monthList}"
							varStatus="getMonth">
							<input type="text" name="getMonth"
								class="getMonth${getMonth.count}" value="${monthList.month}" hidden>
						</c:forEach>
						<!-- month에 따른 가입자 수 뽑아오기 -->
						<c:forEach var="countMember" items="${countMember}"
							varStatus="countMem">
							<input type="text" name="countMem"
								class="getCountMem${countMem.count}"
								value="${countMember.count}" hidden>
						</c:forEach>
						<div class="chart-div">
							<canvas id="myChart" style="width:1000;height:500;"></canvas>
						</div>

						<script>
							// 길이 값 불러오기 
							let monthLeg = $("input[name='getMonth']").length;
							let countLeg = $("input[name='countMem']").length;
				
							
							let monthArr = [];
							let countArr = [];
							for(let i=0; i < monthLeg; i++ ){
							  let temp = $(".getMonth"+(i+1)+"").val();
							  let temp1 = $(".getCountMem"+(i+1)+"").val();
							  monthArr [i] = temp;
							  countArr [i] = temp1;
							} 
					
							 
							/* 	let yearArr = [];
								let monthArr = [];
								
								$(document).ready(function(){
										for(let i=0; i < count; i++){
											let temp = $(".statistics-contents-div > .signupDate"+(i+1)+"").val();
											console.log(temp);
											yearArr [i] = temp.substr(0,4);
											monthArr[i] = temp.substr(5,2);

										}			
										
										console.log(yearArr);
										console.log(monthArr);
										
										 
									
								});*/
							/* 'January', 'February', 'March',
							'April', 'May', 'June', 'July','Agust','September','October','Nomember','December' */
							// chart 부분
							const labels = monthArr;
							const data = {
								labels : labels,
								datasets : [ {
									label : '회원가입 월별 추이',
									backgroundColor : 'rgb(255, 99, 132)',
									borderColor : 'rgb(255, 99, 132)',
									data : countArr,
								} ]
							};
							const config = {
								type : 'line',
								data : data,
								options : {/* responsive:false */}
							};
							const myChart = new Chart(document
									.getElementById('myChart'), config);
						</script>


					</div>
				</div>
				
				<!-- 판매 통계 페이지 -->
				
				<div class="sell-Statistics-page">
					<div class="sell-Statistics-top-div">판매 통계</div>
					<div class="sell-statistics-contents-div">
						<!-- monthList 뽑아오기 -->
						<c:forEach var="monthList" items="${monthList}"
							varStatus="getMonth">
							<input type="text" name="getMonth"
								class="getMonth${getMonth.count}" value="${monthList.month}" hidden>
						</c:forEach>
						<!-- month에 따른 가입자 수 뽑아오기 -->
						<c:forEach var="countMember" items="${countMember}"
							varStatus="countMem">
							<input type="text" name="countMem"
								class="getCountMem${countMem.count}"
								value="${countMember.count}" hidden>
						</c:forEach>
						<div class="chart-div">
							<canvas id="myChart" style="width:1000;height:500;"></canvas>
						</div>

						<script>
							// 길이 값 불러오기 
							let monthLeg = $("input[name='getMonth']").length;
							let countLeg = $("input[name='countMem']").length;
				
							
							let monthArr = [];
							let countArr = [];
							for(let i=0; i < monthLeg; i++ ){
							  let temp = $(".getMonth"+(i+1)+"").val();
							  let temp1 = $(".getCountMem"+(i+1)+"").val();
							  monthArr [i] = temp;
							  countArr [i] = temp1;
							} 
					
							 
							/* 	let yearArr = [];
								let monthArr = [];
								
								$(document).ready(function(){
										for(let i=0; i < count; i++){
											let temp = $(".statistics-contents-div > .signupDate"+(i+1)+"").val();
											console.log(temp);
											yearArr [i] = temp.substr(0,4);
											monthArr[i] = temp.substr(5,2);

										}			
										
										console.log(yearArr);
										console.log(monthArr);
										
										 
									
								});*/
							/* 'January', 'February', 'March',
							'April', 'May', 'June', 'July','Agust','September','October','Nomember','December' */
							// chart 부분
							const labels = monthArr;
							const data = {
								labels : labels,
								datasets : [ {
									label : '회원가입 월별 추이',
									backgroundColor : 'rgb(255, 99, 132)',
									borderColor : 'rgb(255, 99, 132)',
									data : countArr,
								} ]
							};
							const config = {
								type : 'line',
								data : data,
								options : {/* responsive:false */}
							};
							const myChart = new Chart(document
									.getElementById('myChart'), config);
						</script>


					</div>
				</div>
			</div>
		</div>

	</main>
	<footer>
		<div class="footer-box">
			<span>만든이들 : 곽서호, 김동현 92, 김동현 93, 김동휘, 박시현, 배소현 </span><br> <span>CopyRight
				2022 @ ALL RIGHT RESERVED</span>
		</div>
	</footer>
	<script>
		// 페이지 변경 스크립트
		if ($(".control-page").css("display", "block")) {
			$(".control-btn").focus();
		}
		$(".control-btn").on("click", function() {
			$(".control-btn").css("background-color:#fff", "color:#24a6a4");
			$(".control-page").css("display", "block");
			$(".question-page").css("display", "none");
			$(".report-page").css("display", "none");
			$(".statistics-page").css("display", "none");
			$(".sell-Statistics-page").css("display", "none");
		})
		$(".question-btn").on("click", function() {
			$(".control-page").css("display", "none");
			$(".report-page").css("display", "none");
			$(".question-page").css("display", "block");
			$(".statistics-page").css("display", "none");
			$(".sell-Statistics-page").css("display", "none");
		});
		$(".report-btn").on("click", function() {
			$(".control-page").css("display", "none");
			$(".question-page").css("display", "none");
			$(".report-page").css("display", "block");
			$(".statistics-page").css("display", "none");
			$(".sell-Statistics-page").css("display", "none");
		});
		$(".mem-statics-btn").on("click", function() {
			$(".control-page").css("display", "none");
			$(".question-page").css("display", "none");
			$(".report-page").css("display", "none");
			$(".statistics-page").css("display", "block");
			$(".sell-Statistics-page").css("display", "none");

		});
		$(".sell-statics-btn").on("click", function() {
			$(".control-page").css("display", "none");
			$(".question-page").css("display", "none");
			$(".report-page").css("display", "none");
			$(".statistics-page").css("display", "none");
			$(".sell-Statistics-page").css("display", "block");

		})


		// checkbox 스크립트
		$("#chkBoardAll").on("click", function() {
			if ($(this).prop('checked')) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})

		$("#checkAll").on("click", function() {
			if ($(this).prop('checked')) {
				$("input[type=checkbox]").prop("checked", true);
			} else {
				$("input[type=checkbox]").prop("checked", false);
			}
		})

		// 회원 탈퇴
		$(".deleteBtn").on("click", function() {
			$("input[name='checkbox[]']:checked").each(function() {
				var checkVal = $(this).val();

				if (confirm("회원을 탈퇴시키겠습니까?")) {
					if (checkVal != null) {
						$.ajax({
							url : "/admin/leave",
							data : {
								seqNum : checkVal
							}

						}).done(function(resp) {
							if (resp > 0) {
								alert("탈퇴가 완료 되었습니다.");
							} else {
								alert("탈퇴가 불가 합니다.");
								return false;
							}
						});
					}
				}

			});
		});
		// 회원 정보 수정 
		$(".updateBtn").on("click", function() {
			console.log($("input[name='checkbox[]']:checked"));
			if ($("input[name='checkbox[]']:checked").length > 1) {
				alert("한 개의 회원정보만 수정이 가능합니다.");
				return false;
			} else {
				$("input[name='checkbox[]']:checked").each(function() {
					var checkVal = $(this).val();

					if (checkVal != null) {
						location.href = "/admin/update?seq=" + checkVal;
					} else {
						alert("수정 할 회원을 선택해 주세요.");
						return false;
					}
				})
			}

		})

		// 게시글 삭제하기

		$(".deleteBoardBtn").on("click", function() {
			$("input[name='checkboxBoard[]']:checked").each(function() {

				var checkVal = $(this).val();
				console.log(checkVal);

				if (confirm("게시물을 삭제하시겠습니까?")) {
					if (checkVal != null) {
						$.ajax({
							url : "/admin/deleteBySeqBoard",
							data : {
								seqNum : checkVal
							}

						}).done(function(resp) {
							console.log(resp);
							if (resp > 0) {
								alert("삭제가 완료 되었습니다.");
							} else {
								alert("삭제가 불가 합니다.");
								return false;
							}
						});
					}
				}
			})

		})
	</script>
</body>
</html>