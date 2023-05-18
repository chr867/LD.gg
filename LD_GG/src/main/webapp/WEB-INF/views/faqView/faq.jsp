<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>faq</title>
</head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
  /* CSS 스타일을 여기에 작성합니다. */
  body {
    font-family: Arial, sans-serif;
    padding: 20px;
  }

  summary {
    font-weight: bold;
    cursor: pointer;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    margin-bottom: 5px;
  }
</style>

<body>
  faq 페이지입니다~~
  <p class="question-title">궁금한 점이 있으신가요?<br>먼저 아래의 자주 묻는 질문을 확인해주세요!</p>
  
  <div class="question-list-box" id="faqListBox">
  </div>
  
  <script>
    $(document).ready(function() {
    	$.ajax({
    		  url: "/faq/get-all-faq",
    		  type: "GET",
    		  success: function(res) {
    		    // 서버로부터 받은 데이터(response)를 처리합니다.
    		    let faq_list = JSON.parse(res);
    		    faq_list.forEach(faq => {
    		    	const $details = $("<details>");
	   		    	  const $summary = $("<summary>").text(faq.questions_list);
	   		    	$details.append($summary)
	   		    	  let questions_line = faq.answers_list.split('/')
	   		    	  const $ul = $("<ul>"); // 새로운 ul 요소 생성
	   		    	  for(let i =0; i < questions_line.length ; i++){
	   		    		const $li = $("<li>").text(questions_line[i]); // 질문을 li 요소로 생성
	   		    	    $ul.append($li); // li 요소를 ul 요소에 추가
	   		    	  }
	   		    	$details.append($ul);
	   		    	const $div = $("<div>").append($details);
    		        $('.question-list-box').append($div);
    		      });
    		  },
    		  error: function(error) {
    		    // 요청이 실패했을 때의 처리를 수행합니다.
    		    console.log("Error:", error);
    		  }
    		});


      
    });
  </script>
</body>

</html>