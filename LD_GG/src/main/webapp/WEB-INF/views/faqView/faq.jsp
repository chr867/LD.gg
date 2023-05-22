<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>faq</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
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

</head>
<body>
  <p class="question-title">궁금한 점이 있으신가요?<br>먼저 아래의 자주 묻는 질문을 확인해주세요!</p>
  
  <div class="accordion" id="faqListBox">
  </div>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
  <script>
    $(document).ready(function() {
    	$.ajax({
    		  url: "/faq/get-all-faq",
    		  type: "GET",
    		  success: function(res) {
    		    // 서버로부터 받은 데이터(response)를 처리합니다.
    		    let faq_list = JSON.parse(res);
    		    faq_list.forEach((faq, index) => {
    		    	  const $details = $("<details>");
    		    	  const $summary = $("<summary>").text(faq.questions_list);
    		    	  $details.append($summary);

    		    	  const questions_line = faq.answers_list.split('/');
    		    	  const $ul = $("<ul>");
    		    	  questions_line.forEach((question) => {
    		    	    const $li = $("<li>").text(question);
    		    	    $ul.append($li);
    		    	  });
    		    	  $details.append($ul);

    		    	  const $div = $("<div>").append($details);
    		    	  const accordionItem = $('<div>').addClass('accordion-item');
    		    	  const accordionHeader = $('<h2>').addClass('accordion-header');
    		    	  const accordionButton = $('<button>').addClass('accordion-button collapsed').attr({
    		    	    'type': 'button',
    		    	    'data-bs-toggle': 'collapse',
    		    	    'data-bs-target': '#collapse' + index,
    		    	    'aria-expanded': 'false',
    		    	    'aria-controls': 'collapse' + index
    		    	  }).append($("<strong>").text(faq.questions_list));
    		    	  accordionHeader.append(accordionButton);

    		    	  const accordionCollapse = $('<div>').attr({
    		    	    'id': 'collapse' + index,
    		    	    'class': 'accordion-collapse collapse',
    		    	    'data-bs-parent': '#accordion'
    		    	  });
    		    	  const accordionBody = $('<div>').addClass('accordion-body').html(faq.answers_list);
    		    	  accordionCollapse.append(accordionBody);

    		    	  accordionItem.append(accordionHeader);
    		    	  accordionItem.append(accordionCollapse);

    		    	  $('.accordion').append(accordionItem);
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