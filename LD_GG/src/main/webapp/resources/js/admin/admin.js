const user_type = document.getElementById('user_type').innerHTML
console.log(user_type)

if(user_type != 3){
  alert("접근 권한이 없습니다")
  location.href = "/member/testMain"
}

// 공지 목록
function notice_lst(){
$("#grid").jqGrid({
		url : "/userinterface/notice/histroy.json",
		datatype : "json",
		colNames : ['번호', '제목', '내용', '조회수', '추천 수', '날짜'],
		colModel:[
			{name:'t_b_num', index:'t_b_num', width:90, align: "center", key:true},
			{name:'t_b_title', index:'t_b_title', width:90, align: "center", sortable : false},
			{name:'t_b_content', index:'t_b_content', width:90, align: "center", sortable : false},
			{name:'t_b_views', index:'t_b_views', width:90, align: "center"},
			{name:'t_b_recom', index:'t_b_recom', width:90, align: "center"},
			{name:'t_b_date', index:'t_b_date', width:90, align: "center"}
		],
		sortable : true,
		loadonce : true,
		autowidth: true,
		multiselect: true,
		pager:'#pager',
		rowNum: 10,
		rowList: [10, 20, 50],
		sortname: 't_b_num',
		sortorder: 'desc',
		height: 600,
		onCellSelect: function(rowid, icol){
			if(icol != 0){
				location.href = `/userinterface/notice/detail?t_b_num=${rowid}`
			}
		}
	})
}
// 목록 끝
notice_lst();
// 검색
document.getElementById("search").addEventListener("click", function() {
	let keyword = document.getElementById('keyword').value;
	console.log(keyword);
	$("#grid").jqGrid('setGridParam', {
		url : "/userinterface/notice/search.json",
		datatype : "json",
		postData: {keyword: keyword},
		colNames : ['번호', '제목', '내용', '조회수', '추천 수', '날짜'],
		colModel:[
			{name:'t_b_num', index:'t_b_num', width:90, align: "center", key:true},
			{name:'t_b_title', index:'t_b_title', width:90, align: "center", sortable : false},
			{name:'t_b_content', index:'t_b_content', width:90, align: "center", sortable : false},
			{name:'t_b_views', index:'t_b_views', width:90, align: "center"},
			{name:'t_b_recom', index:'t_b_recom', width:90, align: "center"},
			{name:'t_b_date', index:'t_b_date', width:90, align: "center"}
		],
		sortable : true,
		loadonce : true,
		autowidth: true,
 		multiselect: true,
		pager:'#pager',
		rowNum: 10,
		rowList: [10, 20, 50],
		sortname: 't_b_num',
		sortorder: 'desc',
		height: 600,
		onCellSelect: function(rowid, icol){
		if(icol != 0){
			location.href = `/userinterface/notice/detail?t_b_num=${rowid}`
		}
	}
}).trigger("reloadGrid");
console.log('jq 끝')
});
// 검색 끝

// 삭제
function notice_del(){
	let t_b_num = $("#grid").jqGrid('getGridParam', 'selarrrow');
	let t_b_num_json = JSON.stringify(t_b_num);
	let confirmation = confirm("삭제하시겠습니까?");
	console.log(t_b_num);
	if(confirmation){
		$.ajax({
		    url: '/userinterface/admin/delete.do',
		    type: 'post',
		    data: {t_b_num: t_b_num},
			traditional: true
		}).done(res=>{
		    notice_lst();
		    alert(res);
		}).fail(err=>{
		    alert(err);
		});
	}
}
// 삭제 끝