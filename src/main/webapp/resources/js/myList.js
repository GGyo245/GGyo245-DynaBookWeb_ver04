/**
 * 
 */
$(document).ready(function(){
	purchase();
});

function bookmark(){
	$.ajax({
		url:"/user/myBookMark"
		,type:"post"
		,dataType:"json"
		,success:function(result){
			
			console.log(result);
			$('.contents').remove();
			$('#notFound').remove();
			
			let booknumber;
			let title;
			let episode;
			let genre = '';
			var tag = '';
			
			for(var i=0; i<result.length; i++){
				
				booknumber = result[i].BOOKNUMBER;
				partnumber = result[i].BOOKPARTNUMBER;
				title =  result[i].TITLE;
				episode = result[i].EPISODETITLE;
				genre = "'/resources/css/img/TitleImg/"+result[i].GENRE+".jpg'";
				
				tag = '<div class="col-4 contents">';
				tag += '<div class="contentsBoard">';
				tag += '<a href="/viewer?bookpartnumber='+partnumber+'&part_booknumber='+booknumber+'">'
				tag += '<img class="searchImg" src="/resources/css/img/TitleImg/'+booknumber+'.jpg" onerror="this.src='+genre+'">'
				tag += '</a>'
				tag += '<div class="mylistTitle">'+title+'</div>';
				tag += '<div class="mylistepisode">'+episode+'</div>';
	            tag += '</div></div>';
	            
	            $('#contentRow').append(tag);
	        };
			
	        $('#mylistBookmark').css('color','#1F8CE6');
	        $('#mylistPurchase').css('color','#636c73')
	        
	        if(result.length == 0){
	            $('#contentRow').append('<div id="notFound">등록하신 북마크가 없습니다.</div>');
	        }
	        
		},error:function(){
			alert("실패")
		}
	});
}

function purchase(){
	$.ajax({
		url:"/user/myPurchase"
		,type:"post"
		,dataType:"json"
		,success:function(result){
			
			console.log(result);
			$('.contents').remove();
			$('#notFound').remove();
			
			let booknumber;
			let title;
			let episode;
			let genre = '';
			var tag = '';
			
			for(var i=0; i<result.length; i++){
				
				booknumber = result[i].BOOKNUMBER;
				partnumber = result[i].BOOKPARTNUMBER;
				title =  result[i].TITLE;
				episode = result[i].EPISODETITLE;
				genre = "'/resources/css/img/TitleImg/"+result[i].GENRE+".jpg'";
				
				tag = '<div class="col-4 contents">';
				tag += '<div class="contentsBoard">';
				tag += '<a href="/viewer?bookpartnumber='+partnumber+'&part_booknumber='+booknumber+'">'
				tag += '<img class="searchImg" src="/resources/css/img/TitleImg/'+booknumber+'.jpg" onerror="this.src='+genre+'">'
				tag += '</a>'
				tag += '<div class="mylistTitle">'+title+'</div>';
				tag += '<div class="mylistepisode">'+episode+'</div>';
	            tag += '</div></div>';
	            
	            $('#contentRow').append(tag);
	        };
			
	        $('#mylistBookmark').css('color','#636c73');
	        $('#mylistPurchase').css('color','#1F8CE6');
	        
	        if(result.length == 0){
	            $('#contentRow').append('<div id="notFound">구매하신 소설이 없습니다.</div>');
	        }
	        
		},error:function(){
			alert("실패")
		}
	});
}


