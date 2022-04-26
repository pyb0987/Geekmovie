    

	
	
var bigMovieController = function(msbpc, language){			//적용하려는 movies-BigPictureContainer를 찾아서 선언할 것
	
var bigMovieIndex=0;
var bigMovieloadChecker=[];
for(var i=0;i<20;i++){
    bigMovieloadChecker[i]=false;
}
var prev = msbpc.querySelector('.movieSlidePrev');
var next = msbpc.querySelector('.movieSlideNext');

var trendMovieIds = [];


$.ajax({							//TrendMovieList id만 가져오기
        	type: 'GET',
        	url: '/movie/getTrendingMovieList?timewindow=week',
        	dataType : 'json',
        	contentType : 'application/json', 
        	async: false, 
        	success: function(data){
        		for (var movie of data.results){
        			trendMovieIds.push(movie.id)
        		}
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
 })	

function bigMovieloader(index){
		$.ajax({							//받아온 영화 정보 디테일로 만들기
        	type: 'GET',
        	url: `/movie/getMovieData?movieId=`+trendMovieIds[index]+`&language=`+language,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		let str1;

        		if(!!data.backdrop_path){
        		str1 = 'https://image.tmdb.org/t/p/original/'+data.backdrop_path ;			//백드랍 이미지
        		}else{        		
        			str1 = '${pageContext.request.contextPath}/resources/img/wall.jpg' ;	
        		}
        		$(".movie-bigPictureContainer:nth-child("+(index+1)+") .movie-bigPicture").css({"background":"linear-gradient(to bottom,rgba(0,0,0,0) 80%,rgba(0,0,0,0.5) 90%,rgba(0,0,0,1) 100%), url("+ str1 +")", "background-repeat": "no-repeat", "background-size": "cover"});   //배경화면 및 그라데이션 
        		
				$(".movie-bigPictureContainer:nth-child("+(index+1)+") .movie-bigDetail").html("<h2 class='bigMovieTitle'>"+data.title+"</h2>"+"<h2 class='bigMovieLink' onclick='location.href=`/movie/movieDetail?movieId="+trendMovieIds[index]+"&language="+language+"`;'>정보 보기</h2>");



				return false;
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        	
        })
}


	function bigMovieAdjust() {						//BigPicture 함수  - Resize하면 실행되는 함수 안에 넣을것
		$(".movies-BigPictureContainer").offset( { left: -window.innerWidth*bigMovieIndex} );
		}
		
		
	
	function returnFunction(){				//BigPicture 함수  - event와 맨처음 슬라이드 ajax. 
		bigMovieloader(0);
		
		prev.addEventListener('click', function () { 
	
	 	if (bigMovieIndex !== 0) {
			bigMovieIndex = bigMovieIndex - 1
			bigMovieAdjust(bigMovieIndex);
			if(!bigMovieloadChecker[bigMovieIndex]){
				bigMovieloader(bigMovieIndex);
				bigMovieloadChecker[bigMovieIndex]=true;
				}
			}

 		});
	
		next.addEventListener('click', function () { 
	
	 	if (bigMovieIndex !== 19) {
			bigMovieIndex = bigMovieIndex + 1
			bigMovieAdjust(bigMovieIndex);
			if(!bigMovieloadChecker[bigMovieIndex]){
				bigMovieloader(bigMovieIndex);
				bigMovieloadChecker[bigMovieIndex]=true;
				}
			}

 		});
	

	
	
		
		
		
	}
	return {
	initialSet : function(){return returnFunction()},
	adjust : function(){return bigMovieAdjust()}
	} ;
	
};















