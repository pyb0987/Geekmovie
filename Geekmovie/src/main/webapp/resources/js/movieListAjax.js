function movieListAjax(selectorId ,AjaxUrl,language){
	        $.ajax({							//MovieList Ajax를 이용해서 출력
        	type: 'GET',
        	url: AjaxUrl,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		console.log(data)
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
        			str += "<figcaption><h3>"+title +"</h3><p>"+overview +"</p><p>"+ data.results[index].release_date +"</p><i class='ion-ios-arrow-right'><a href='/movie/movieDetail?movieId="+data.results[index].id+"&language="+language+"'></a></i></figcaption>" 
        			$(this).html(str);
        			}else{
        						//영화가 존재하지 않을때
        			}
        		})
        		
        	
        	}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        })
}