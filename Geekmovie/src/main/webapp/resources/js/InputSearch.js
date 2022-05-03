

function InputSearch(inputBoxId, movieBoxId, checkImgId, searchModeId, searchButtonId, SearchResultsContainerId, language, pageContext, searchUrl){		//모달창 있어야함

		var genreMap = new Map([[28,'액션'],	//genreMap
		[12, '모험'],
		[16, '애니메이션'],
		[35, '코미디'],
		[80, '범죄'],
		[99, '다큐멘터리'],
		[18, '드라마'],
		[10751, '가족'],
		[14, '판타지'],
		[36, '역사'],
		[27, '공포'],
		[10402, '음악'],
		[9648, '미스터리'],
		[10749, '로맨스'],
		[878, 'SF'],
		[10770, 'TV영화'],
		[53, '스릴러'],
		[10752, '전쟁'],
		[37, '서부']]);  
	
	
	
	function searchMovieSelect(movieId, movieTitle){			//영화검색결과를 누르면 movieId 달아줌
	document.getElementById(inputBoxId).value = movieTitle;
	document.getElementById(movieBoxId).value = movieId;
	document.getElementById(inputBoxId).className = "movieSelected";
	document.getElementById(inputBoxId).readOnly = true;
	document.getElementById(checkImgId).className = "visualized";
	$(".modal").fadeOut();
	};
	
	$(document).on("click", ".movie-searchContainer", function(e){
		searchMovieSelect(e.currentTarget.dataset.id, e.currentTarget.dataset.title)

	})
	$(document).on("click", ".search-result", function(e){
		searchMovieSelect(e.currentTarget.dataset.id, e.currentTarget.dataset.title)

	})
	
	
	
	
	

	var inputBox = document.getElementById(inputBoxId);
	var movieBox = document.getElementById(movieBoxId);
	var checkImg = document.getElementById(checkImgId);
	var SearchMode = document.getElementById(searchModeId);
	var modalExit = document.querySelector('.modalExit');
	var SearchButton = document.getElementById(searchButtonId);	
	
	function movieSelected(){					//영화선택되면 색깔변경
		inputBox.className = "movieSelected";
	}
	
	
	checkImg.addEventListener('click', function(e){	//체크박스 누르면 색깔변경 사라짐
		inputBox.classList.remove("movieSelected");
		inputBox.readOnly = false;
		checkImg.classList.remove("visualized");
    }); 
	
	
	SearchMode.addEventListener('click', function(e){ //서치모드 변경시 색깔변경 사라짐
		inputBox.classList.remove("movieSelected");
		inputBox.readOnly = false;
		checkImg.classList.remove("visualized");
    }); 
	
	modalExit.addEventListener('click', function(e){ //X박스 누르면 모달창 제거
	    $(".modal").fadeOut();
    }); 
	
	
	function SearchResultMoreEventListenerAllocator(searchresultmore){				//영화 정보 완료되면 이벤트 설정  - searchResultmore는 더보기 버튼
	searchresultmore.addEventListener('click', function(e){
			const query = inputBox.value;
			modalSearch(1, query, language);		//더보기 하면 모달창으로
	});
	};
	
	
	function ModalEventListenerAllocator(){
	 Array.prototype.forEach.call(document.querySelectorAll('.modalPagination a'), function(btn) {
		   btn.addEventListener('click', function(e) {
		     var tr = e.target;
		     if(!!tr.dataset.page){
		   	modalSearch(tr.dataset.page, tr.dataset.query, tr.dataset.language);
		     }
		   })
		  });
	  };
	
	
	SearchButton.addEventListener('click', function(e){					//서치버튼 클릭
	var query = inputBox.value;
	if(query!=""){
	let isReady = inputBox.classList.contains("movieSelected");
	if (SearchMode.value != 'movie' || isReady){		
		if(!!SearchUrl){
			if(SearchMode.value == 'movie'){
				query = movieBox.value;
				}
			var url = SearchUrl+'?SearchMode='+SearchMode.value+'&query='+query+'&language='+language+'&page=1';		//서치 실행 url
			location.href = url;
			}

	}else{				//만약 체크가 안되어있다면 모달창으로
		modalSearch(1, query, language);
	}
	}
	});
	
	inputBox.onkeydown = function(event){				//인풋박스에서 엔터해도 서치버튼 클릭으로 인식
	if (event.keyCode === 13) {
	    event.preventDefault();
	    let clickEvent = new Event("click");
	    SearchButton.dispatchEvent(clickEvent);
	}
	};
	
	function modalSearch(modalPage, inputQuery, inputLanguage){		//모달창 정보표시
		$(".modal").fadeIn();
		$(".modal").css('position', 'fixed');
		var searchUrl = "/movie/searchMovieList?query="+inputQuery+"&language="+inputLanguage+"&page="+modalPage;
		  		$.ajax({							//받아온 영화 정보 표에 나열
        	type: 'GET',
        	url: searchUrl,
        	dataType : 'json',
        	contentType : 'application/json', 
        	success: function(data){
        		var str = ""
        		var count = 0;
        		$(".movies-searchInnerContainer").empty();	
        		data.results.forEach(function(item,index){
					var genreAry = [];
					item.genre_ids.forEach(function(item){
	        			genreAry.push(genreMap.get(item))
					})
					var imageUrl = '';
					if(!!item.poster_path){
        				imageUrl = "https://image.tmdb.org/t/p/w185"+item.poster_path;
        			}else{
        				imageUrl = pageContext+`/resources/img/noImage.jpg`       		//사진이 없을때 이미지			
        			}
					var year = '';
					if(!!item.release_date){
						year = item.release_date.substr(0,4);
					}else{
						year = "Year Unknown"
					}
        			str += '<div class="movie-searchContainer" data-id ="'+item.id+'" data-title="'+item.title+'" style="cursor:pointer;"><div class="movie-pictureContainer"><div class="movie-picture" style="background: url(\'';
        			str +=	imageUrl+'\'); background-size: contain; background-repeat: no-repeat; background-position: center center;"></div>';
					str += '</div><div class="movie-title-container"><div class="movie-title prevent-flow">';
					str += item.title+'</div></div><div class="movie-year prevent-flow">'
					str += year+'</div><div class="movie-genre prevent-flow">'
					str += genreAry.join(' ,')+'</div><div class="movie-vote prevent-flow">'+item.vote_average+'</div>'					//나중에 geekmovie자체점수로 변경필요
						
					str += '</div>'
					count +=1
					})
					str += '<div class="fake-searchContainer"></div>'.repeat(Math.max(20-count, 0))
					str += '<div class="pagination-container" style="grid-column: 1 / span 4;"><div class="pagination modalPagination"></div></div>'
        			$(".movies-searchInnerContainer").html(str)
				ModalmakePagination(data.total_pages,inputQuery,inputLanguage,  modalPage);
        		return false;
        	}
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        		$(".movies-searchInnerContainer").html('<div id="searchText"></div>');
        		
        		$("#searchText").html('<h1>검색결과가 존재하지 않습니다.</h1>')	
        	}
        })
	}	
	
	function ModalmakePagination(pageNum, inputQuery, inputLanguage, modalPage){				//모달창 내부 페이징 기능 구현
  	if(pageNum>500){
  		pageNum = 500;			//외부데이터베이스 서치시 500쪽 제한
  	}
    var pageNow = modalPage;
    var pageFirst = parseInt((pageNow-1)/10)*10;
    var str='';
    if (pageNow==1){
         str += '<a>처음</a>'
        }else{
           str += "<a class='modalSearch' data-page='"+1+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>처음</a>";
        }
    if (pageNow<11){
    str += '<a>&laquo;</a>'
    }else{
        str += "<a class='modalSearch' data-page='"+(pageFirst)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>&laquo;</a>";
    }
    var index = 1
    while(pageFirst+index<=pageNum && index<11){
        if(pageFirst+index==pageNow){
        	str += `<a class="active">`+(pageFirst+index)+'</a>'
        }else{
        str += "<a class='modalSearch' data-page='"+(pageFirst+index)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>"+(pageFirst+index)+"</a>";
        }
        index +=1
    }
    if(pageFirst+10>=pageNum){
        str += '<a>&raquo;</a>'
    }else{
        str += "<a class='modalSearch' data-page='"+(pageFirst+11)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>&raquo;</a>";
    }
    if(pageNow==pageNum){
        str += '<a>끝</a>'
    }else{
        str += "<a class='modalSearch' data-page='"+(pageNum)+"' data-query='"+inputQuery+"' data-language='"+inputLanguage+"'>&nbsp;끝&nbsp;</a>";
    }
        
    $('.modalPagination').html(str);
        
	if(!!document.querySelector('.modalPagination a')){
    	ModalEventListenerAllocator();
	}
        
  	};
	
	
	inputBox.addEventListener("propertychange", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
	inputBox.addEventListener("change", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
	inputBox.addEventListener("keyup", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
	inputBox.addEventListener("paste", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
	inputBox.addEventListener("input", debounce(function(){InputBoxSearch();}, 500, false));	 //자동완성을 위한 키업 이벤트리스너		-debounce필요
	
	
	
	function InputBoxSearch(){				//한줄평 5개 영화목록 서치
	const query = inputBox.value;
	if (!query || SearchMode.value != "movie" || inputBox.classList.contains("movieSelected")){
			$("#"+SearchResultsContainerId).empty();	
			return false;
		}else{
		  let inputUrl = '/movie/searchMovieList?query='+query+'&language='+language+'&page=1';
		  $.ajax({							//searchMovieList 출력
	        	type: 'GET',
	        	url: inputUrl,
	        	dataType : 'json',
	        	contentType : 'application/json', 
	        	success: function(data){
	        		$("#"+SearchResultsContainerId).empty();	
	        		if (data.total_results>0){
	        			let index=0;
	        			var str = '';
	            		while(index<5 && data.total_results>index){
	            			str +='<div class="search-result-container">';
							str += '<div class="search-result" tabindex:"'+(index+1)+'" data-id ="'+data.results[index].id+'" data-title="'+data.results[index].title+'">';
							if(!!data.results[index].poster_path){
		        				imageUrl = "https://image.tmdb.org/t/p/w92"+data.results[index].poster_path;
		        			}else{
		        				imageUrl = pageContext+`/resources/img/noImage.jpg`       		//사진이 없을때 이미지			
		        			}   
							str += '<div class="result-picture" style=\'background: url("'+imageUrl +'"); background-repeat: no-repeat; background-size : contain\'></div>';
							str += '<div class="result-nonPicture">';
							str += '<div class="result-title result-title-font">'+data.results[index].title+'</div>';
							if (!!data.results[index].release_date){
							str += '<div class="result-year result-font">'+data.results[index].release_date.substr(0,4)+'</div>'								
							}else{
							str += '<div class="result-year result-font">unknown</div>'
							}
							var genreAry = []
							data.results[index].genre_ids.forEach(function(item){
			        			genreAry.push(genreMap.get(item))
							})
							str += '<div class="result-genre result-font">'+genreAry.join(' ,')+'</div></div></div></div>'
	            			index +=1
	            		}
	            		str += '<div class="search-result-container" style="height : 30px;"><div id="search-result-more")">더 보기</div></div>';
						$("#"+SearchResultsContainerId).append(str);
	        		}
	        		if(!!document.getElementById('search-result-more')){
	        		var searchresultmore = document.getElementById('search-result-more');
	        		SearchResultMoreEventListenerAllocator(searchresultmore);
	        			
	        		}
	    			return false;
	        	}
	        
	        	,
	        	error: function(request, status, error){
	        		console.log(request, status, error)
	        	}
	        })
		}
	}
	
	
	
	

}

	


		

	