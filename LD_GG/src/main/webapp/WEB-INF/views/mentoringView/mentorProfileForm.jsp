<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Mentor Profile Form</title>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Segoe UI', sans-serif;
  font-size: 16px;
  color: #333;
}

h1, h2, h3, h4, h5, h6 {
  margin: 1rem 0;
}

h1 {
  font-size: 2.5rem;
}

h2 {
  font-size: 2rem;
}

h3 {
  font-size: 1.5rem;
}

h4 {
  font-size: 1.2rem;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}

form label {
  display: block;
  margin-bottom: 0.5rem;
}

form input[type="text"], form input[type="number"] {
  padding: 0.5rem;
  font-size: 1rem;
  border: 1px solid #ccc;
  border-radius: 0.5rem;
  width: 100%;
  margin-bottom: 1rem;
}

form input[type="submit"] {
  background-color: #4CAF50;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.5rem;
  font-size: 1rem;
  cursor: pointer;
}

form input[type="submit"]:hover {
  background-color: #3e8e41;
}

.scrollable-table {
  height: 200px;
  overflow: auto;
  margin-top: 1rem;
}

table {
  width: 100%;
  border-collapse: collapse;
}

th, td {
  border: 1px solid #ddd;
  padding: 0.5rem;
  text-align: left;
}

th {
  background-color: #f2f2f2;
}

.toggle-button, .save_tag {
  display: block;
  margin-top: 1rem;
  background-color: #4CAF50;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.5rem;
  font-size: 1rem;
  cursor: pointer;
}

.toggle-button:hover {
  background-color: #3e8e41;
}
.save_tag:hover {
  background-color: #3e8e41;
}

#container_by_class {
  border: 1px solid black;
  margin: 1rem 0;
  padding: 1rem;
}

.delete-button {
  background-color: #f44336;
  color: #fff;
  padding: 0.5rem 1rem;
  border: none;
  border-radius: 0.5rem;
  font-size: 1rem;
  cursor: pointer;
}

.delete-button:hover {
  background-color: #d32f2f;
}

@media screen and (min-width: 768px) {
  .flex-container {
    display: flex;
    justify-content: space-between;
  }
  
  .form-container {
    width: 45%;
  }
  
  #mentor_class_info {
    width: 45%;
  }
}
.scrollable-table {
	height: 200px;
	overflow: auto;
}

.toggle-button {
	display: block;
	margin: 10px;
}

#container_by_class {
	border: 1px solid black;
}

</style>
</head>
<body>
	<h1>멘토 프로필 작성</h1>
	<form id="mentorProfileForm" onsubmit="return submitForm()">
		<h2>${member.lol_account}멘토님</h2>
		<label for="about_mentor">멘토 소개:</label> <input type="text"
			id="about_mentor" name="about_mentor"
			value="${mentor_profile.about_mentor}" required><br>
		<br> <label for="specializedPosition">특화 포지션:</label> <input
			type="text" id="specializedPosition" name="specialized_position"
			value="${mentor_profile.specialized_position}" required><br>
		<br> <label for="specializedChampion">특화 챔피언:</label> <input
			type="text" id="specializedChampion" name="specialized_champion"
			value="${mentor_profile.specialized_champion}" required><br>
		<br> <label for="contactTime">수업 가능 시간:</label> <input
			type="text" id="contactTime" name="contact_time"
			value="${mentor_profile.contact_time}" required><br>
		<br> <label for="careers">경력:</label> <input type="text"
			id="careers" name="careers" value="${mentor_profile.careers}"
			required><br>
		<br> <label for="recom_ment">이런 분들께 추천해요:</label> <input
			type="text" id="recom_ment" name="recom_ment"
			value="${mentor_profile.recom_ment}" required><br>
		<br> <input type="submit" value="작성">
	</form>
	<div class="scrollable-table">
		<table>
			<thead>
				<tr>
					<th>선택</th>
					<th>태그</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${tag_list}" var="tag_list">
					<tr>
						<td><input type="checkbox" name="selected_tags"
							value="${tag_list.tag_id}"></td>
						<td>${tag_list.tag_info}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<button class="save_tag" onclick="deleteMentorTag()">태그 저장</button>
	<button class="toggle-button" onclick="toggleTable()">숨기기</button>

	<form id="classForm" onsubmit="return classSubmitForm()">
		<label for="class_name">수업명:</label> <input type="text"
			id="class_name" name="class_name" value="" required><br>
		<br> <label for="class_info">수업 정보:</label> <input type="text"
			id="class_info" name="class_info" value="" required><br>
		<br> <label for="price">가격: </label> <input type="number"
			id="price" name="price" value="" required><br>
		<br> <input type="submit" value="새로운 수업 작성">
	</form>
	<div id="mentor_class_info">
		<c:forEach items="${class_list}" var="class_list">
			<div id="container_by_class">
				<div>
					<h4>${class_list.class_name}</h4>
					<button onclick="deleteClass('${class_list.class_id}')">삭제</button>
				</div>
				<div>
					<h4>${class_list.price}</h4>
				</div>
				<div>
					<h4>${class_list.class_info}</h4>
				</div>
			</div>
		</c:forEach>
	</div>
	<script>
	function select_by_email_class() {
		  const lol_account = "${member.lol_account}";
		  fetch(`/mentor/select-mentor-class?lol_account=${lol_account}`, {
		    headers: {
		      "Content-Type": "application/json;charset=UTF-8",
		    },
		  })
		    .then((response) => response.json())
		    .then((class_list) => {
		      const mentorClassInfo = document.getElementById("mentor_class_info");
		      let html = "";
		      class_list.forEach((mentorClass) => {
		    	  console.log(mentorClass);
		    	  html += "<div id=\"container_by_class\">\n" +
		          "  <div>\n" +
		          "    <h4>" + mentorClass.class_name + "</h4>\n" +
		          "    <button onclick=\"deleteClass('" + mentorClass.class_id + "')\">삭제</button>\n" +
		          "  </div>\n" +
		          "  <div>\n" +
		          "    <h4>" + mentorClass.price + "</h4>\n" +
		          "  </div>\n" +
		          "  <div>\n" +
		          "    <h4>" + mentorClass.class_info + "</h4>\n" +
		          "  </div>\n" +
		          "</div>";
		      });
		      mentorClassInfo.innerHTML = html;
		    })
		    .catch((error) => console.error(error));
		}

		function deleteClass(class_id){
	        let xhr = new XMLHttpRequest();
	        xhr.open("DELETE", "/mentor/delete-mentor-class/");
	        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
	        xhr.onload = function () {
	    	    if (xhr.status === 200) {
	    	    	select_by_email_class();
	    	    }
	        };
	        xhr.send(class_id);
    	}
    	function classSubmitForm() {
        let form = document.getElementById("classForm");
        let formData = new FormData(form);
        let xhr = new XMLHttpRequest();
        xhr.open("POST", "/mentor/insert-mentor-class/");
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        let price = parseInt(formData.get("price"));
        let mentorClassDTO = {
        	mentor_email: "${mentor_profile.mentor_email}",
        	class_name: formData.get("class_name"),
        	class_info: formData.get("class_info"),
        	price: price
        };
        console.log(mentorClassDTO);
        xhr.onload = function () {
    	    if (xhr.status === 200) {
    	    	select_by_email_class();
    	    }
        };
        xhr.send(JSON.stringify(mentorClassDTO));
        return false;
      }
    	function toggleTable() {
    	  let table = document.querySelector('.scrollable-table');
    	  if (table.style.display === 'none') {
    	    table.style.display = 'block';
    	  } else {
    	    table.style.display = 'none';
    	  }
    	}
      function submitForm() {
        let form = document.getElementById("mentorProfileForm");
        let formData = new FormData(form);
        let xhr = new XMLHttpRequest();
        xhr.open("PUT", "/mentor/edit-profile/");
        xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
        let mentorProfileDTO = {
        	mentor_email: "${email}",
        	about_mentor: formData.get("about_mentor"),
            specialized_position: formData.get("specialized_position"),
            specialized_champion: formData.get("specialized_champion"),
            contact_time: formData.get("contact_time"),
            careers: formData.get("careers"),
            recom_ment: formData.get("recom_ment")
        };
        xhr.send(JSON.stringify(mentorProfileDTO));
        return false;
      }
      
      function submitTagForm(tagList) {
    	  let jsonData = JSON.stringify(tagList);
    	  let xhr = new XMLHttpRequest();
    	  xhr.open("PUT", "/mentor/edit-mentor-tag/");
    	  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    	  xhr.onload = function () {
    	    if (xhr.status === 200) {
    	      console.log("멘토 태그가 저장되었습니다.");
    	    } else {
    	      console.error("멘토 태그 저장에 실패했습니다.");
    	    }
    	  };
    	  xhr.send(jsonData);
    	  return false;
    	}

    	function deleteMentorTag() {
    	  let mentorEmail = "${mentor_profile.mentor_email}";
    	  let xhr = new XMLHttpRequest();
    	  xhr.open("DELETE", "/mentor/delete-mentor-tag");
    	  xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    	  xhr.onload = function () {
    	    if (xhr.status === 200) {
    	      let checkboxes = document.getElementsByName("selected_tags");
    	      let tagList = [];
    	      for (let i = 0; i < checkboxes.length; i++) {
    	        if (checkboxes[i].checked) {
    	          let tag = checkboxes[i].value;
    	          let data = {
    	            mentor_email: "${mentor_profile.mentor_email}",
    	            tag_id: tag,
    	          };
    	          tagList.push(data);
    	        }
    	      }
    	      submitTagForm(tagList); // submitTagForm 함수 호출
    	      //console.log("멘토 태그가 삭제되었습니다.");
    	    } else {
    	    	//console.log("멘토 태그 삭제에 실패했습니다.");
    	    }
    	  };
    	  xhr.send(mentorEmail);
    	}
    </script>
</body>
</html>
