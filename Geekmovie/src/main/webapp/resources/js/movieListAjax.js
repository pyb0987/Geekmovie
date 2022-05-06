function movieListAjax(selectorId ,AjaxUrl,language){
	        $.ajax({							//MovieList Ajax를 이용해서 출력
        	type: 'GET',
        	url: AjaxUrl,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		console.log(selectorId, data)
        		if(data.total_results<1){
        		$("#"+selectorId+" .movies-container").html("<h2 class='nonExist'>해당 영화가 없습니다.</h2>");
        		}
        		else{
        		$("#"+selectorId+" .movies-container .movie").each(function(index, element){
        		if(!!data.results[index]){
        			if(!!data.results[index].poster_path){
        			str = "<div class='movie-image'><img src='https://image.tmdb.org/t/p/w342/"+data.results[index].poster_path+"'></div>" ;
        			}else{
        			str = "<div class='movie-image' style='color : white; text-align: center; '>"+data.results[index].title+"</p></div>"			//이미지 없으면 제목 출력
        			}
        			let title = data.results[index].title;
        			let overview = data.results[index].overview;
        			if(title.length>20){
        				title = title.substr(0, 20)+"..."					// 제목 20자 넘으면 자르기
            		}
        			if(overview.length>120){
        			overview = overview.substr(0, 120)+"..."					//overview 120자 넘으면 자르기
        			}
        			var likeform = 	"<div class='slide-click clickBox' data-id='"+data.results[index].id+"'><div class='heartClickSmall heartClick'><div class='heartClickSmallClicker heartClickClicker'></div></div><div class='addClick addClickSmall'><svg viewBox='0 0 44 44'><path d='M14,24 L21,31 L39.7428882,11.5937758 C35.2809627,6.53125861 30.0333333,4 24,4 C12.95,4 4,12.95 4,24 C4,35.05 12.95,44 24,44 C35.05,44 44,35.05 44,24 C44,19.3 42.5809627,15.1645919 39.7428882,11.5937758' transform='translate(-2.000000, -2.000000)'></path></svg></div></div>";
        			str += "<figcaption><h3>"+title +"</h3><p>"+overview +"</p><p>"+ data.results[index].release_date +"</p>"+likeform+"<i class='ion-ios-arrow-right'><a href='/movie/movieDetail?movieId="+data.results[index].id+"&language="+language+"'></a></i></figcaption>" 
        			$(this).html(str);
        			}
        			})
        	    	 $(".slide-click.clickBox").activeLikeMovie();
				}
        		
        	
        	}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
}