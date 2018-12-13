<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<script type="text/javascript">
		/*모든 방법론 불러오기*/
		$.ajax({
			type : 'GET',
			url : 'method/all',
			success : function(response) {
				if (response.length != 0) {
					alert('모든 방법론 조회 완료! ' + response);
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 모든 방법론 조회 실패!');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/* /모든 방법론 불러오기*/

		/*해당 방법론에 대한 상세 설명(단계별)
		result = map  > ( KEY = "method" : MethodVO, "methodItemList" : List<MethodItemVO> )
		 */
		$.ajax({
			type : 'GET',
			url : 'method/' + '해당 방법론의 코드 mcode',
			success : function(response) {
				if (response.length != 0) {
					alert('모든 방법론 조회 완료! ' + response);
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 모든 방법론 조회 실패!');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/해당 방법론에 대한 상세 설명(단계별)*/

		/* 내가 추가한 방법론 리스트 조회*/
		$.ajax({
			type : 'GET',
			url : 'methodlist/' + '내아이디',
			success : function(response) {
				if (response.length != 0) {
					alert('내가 추가한 방법론 리스트 조회 완료! ' + response);
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 내가 추가한 방법론 리스트 조회 실패!');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/* /내가 추가한 방법론 리스트*/

		/* 방법론 list를 나한테 추가하기 */
		var param = {
			'uid' : '내 아이디',
			'mbcode' : '추가하고싶은 방법론게시판에 올려진 게시판의 mbcode(primary key)',
			'mltitle' : '추가할 방법론list 내가정하고 싶은 이름'
		};
		$.ajax({
			type : 'POST',
			url : 'methodlist',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response == 1) {
					alert('방법론 list를 나한테 추가 완료! ' + response);
				} else if (response == -1) {
					alert('Server or Client ERROR, 방법론 list를 나한테 추가 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/방법론 list를 나한테 추가하기 */

		/* 추가한 방법론 list의 mltitle 변경하기 */
		var param = {
			'uid' : '내 아이디',
			'mbcode' : '변경 하고싶은 나의 방법론 list에 올려진 방법론의 mbcode(primary key)',
			'mltitle' : '변경할 mltitle 이름'
		};
		$.ajax({
			type : 'PUT',
			url : 'methodlist',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response == 1) {
					alert('방법론 list mltitle 변경 완료! ' + response);
				} else if (response == -1) {
					alert('Server or Client ERROR, 방법론 list mltitle 변경실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/* 추가한 방법론 list의 mltitle 변경하기 */

		/* 방법론 list를 추가했던거 삭제하기 */
		var param = {
			'uid' : '내 아이디',
			'mbcode' : '삭제하고싶은 내 방법론list에  등록된 방법론코드(primarykey)',
		};
		$.ajax({
			type : 'DELETE',
			url : 'methodlist',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response == 1) {
					alert('나의 방법론 list 삭제 완료! ' + response);
				} else if (response == -1) {
					alert('Server or Client ERROR, 나의 방법론 list 삭제 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/* /방법론 list를 추가했던거 삭제하기 */

		/*방법론 게시판 목록 전체 불러오기*/
		$.ajax({
			type : 'GET',
			url : 'methodboard/all',
			success : function(response) {
				if (response.length != 0) {
					alert('방법론 게시판 목록 전체 불러오기 완료! ' + response);
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 방법론 게시판 목록 전체 불러오기  실패!');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*방법론 게시판 목록 전체 불러오기*/

		/*방법론 게시판클릭시 올린 글 상세보기 */
		$.ajax({
			type : 'GET',
			url : 'methodboard/' + '게시판 글의 번호 MBCODE(primary key)',
			success : function(response) {
				if (response.length != 0) {
					alert('글 상세보기 조회 완료! ' + response);
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 글 상세보기 조회   실패!');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/방법론 게시판클릭시 올린 글 상세보기 */

		/* 게시글 작성하기*/
		var param = {
			'mbtitle' : '게시글 제목',
			'mbcontents' : '게시글 내용',
			'pcode' : '프로젝트코드',
			'uid' : '내아이디'
		};
		$.ajax({
			type : 'POST',
			url : 'methodboard',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response == 1) {
					alert('게시글 작성하기 완료! ' + response);
				} else if (response == -1) {
					alert('Server or Client ERROR, 게시글 작성하기 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/게시글 작성하기*/

		/* 게시글 수정하기*/
		var param = {
			'mbtitle' : '변경할 게시글 제목',
			'mbcontents' : '변경할 게시글 내용',
			'mbcode' : '변경할 게시글 mbcode (primary key)'
		};
		$.ajax({
			type : 'PUT',
			url : 'methodboard',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response == 1) {
					alert('게시글 수정하기 완료! ' + response);
				} else if (response == -1) {
					alert('Server or Client ERROR, 게시글 수정하기 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/게시글 수정하기*/

		/*게시글 삭제하기 */
		$.ajax({
			type : 'DELETE',
			url : 'methodboard/' + '삭제할 게시판 글의 번호 MBCODE(primary key)',
			success : function(response) {
				if (response == 1) {
					alert('게시글 삭제 완료! ' + response);
				} else if (response==-1) {
					alert('Server or Client ERROR, 게시글 삭제   실패!');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/게시글 삭제하기 */
	</script>
</body>
</html>