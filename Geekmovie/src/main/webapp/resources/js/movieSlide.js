
    $(document).ready(function(){			 
		    	
		let movieContainerWidth = 8000-window.innerWidth;		
		let movieInnerContainerWidth = 4000;
		
    	

    	function movieContainerResize() {						//movieContainer 리사이징 함수
			$(".movie-container").width(8000-window.innerWidth+'px');
			$(".movie-container").offset({left : -4000+window.innerWidth});
			$(".movie-innerContainer").offset({left : 0});
			movieContainerWidth = 8000-window.innerWidth;		
        }
    	
		movieContainerResize() 										//최초 1회 리사이징 실행
		window.addEventListener('resize', movieContainerResize);				//윈도우 사이즈 변경때마다 리사이징 실행

		let TrendIsDragging = null;		//moviebox drag 변수 설정
		let TrendOriginLeft = null;
		let TrendOriginX = null;
		let PopularIsDragging = null;		
		let PopularOriginLeft = null;
		let PopularOriginX = null;
				
		const TrendMovieInnerContainer = document.querySelector("#trend-movie .movie-container .movie-innerContainer");	
		const PopularMovieInnerContainer = document.querySelector("#popular-movie .movie-container .movie-innerContainer");
		
		TrendMovieInnerContainer.addEventListener("mousedown",(e) => {				//마우스 클릭시 드래그 실행
			TrendIsDragging = true;
			TrendOriginX = e.clientX;
			TrendOriginLeft = TrendMovieInnerContainer.offsetLeft;
		});
		
		PopularMovieInnerContainer.addEventListener("mousedown",(e) => {				//마우스 클릭시 드래그 실행
			PopularIsDragging = true;
			PopularOriginX = e.clientX;
			PopularOriginLeft = PopularMovieInnerContainer.offsetLeft;
		});

		document.addEventListener("mousemove", (e) => {					//마우스 클릭 후 드래그 중 실행
			if(TrendIsDragging){
				const TrendDiffX = e.clientX - TrendOriginX;
				const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
				let dragging = Math.min(Math.max(0, TrendOriginLeft+TrendDiffX),endOfXPoint)
				TrendMovieInnerContainer.style.left = dragging+"px";
			}
			if(PopularIsDragging){
				const PopularDiffX = e.clientX - PopularOriginX;
				const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
				let dragging = Math.min(Math.max(0, PopularOriginLeft+PopularDiffX),endOfXPoint)
				PopularMovieInnerContainer.style.left = dragging+"px";
			}
		});

		document.addEventListener("mouseup", (e) => {			//드래그 후 마우스 놓을때 실행
			TrendIsDragging = false;
			PopularIsDragging = false;
		})

		})