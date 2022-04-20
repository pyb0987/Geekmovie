function movieSlideOne(movieContainer){		
		let movieInnerContainer = movieContainer.children[0]
		
		let movieContainerWidth = 8000-window.innerWidth;		
		let movieInnerContainerWidth = 4000;
		

    	function movieContainerResize(movieContainer,movieInnerContainer) {						//movieContainer 리사이징 함수
			movieContainer.style.width = 8000-window.innerWidth+'px';
			movieContainer.style.left = -4000+window.innerWidth;
			movieInnerContainer.style.left = 0;
			movieContainerWidth = 8000-window.innerWidth;		
        }
    	
		movieContainerResize(movieContainer,movieInnerContainer) 										//최초 1회 리사이징 실행
		window.addEventListener('resize', movieContainerResize(movieContainer,movieInnerContainer));				//윈도우 사이즈 변경때마다 리사이징 실행

		let isDragging = null;		//moviebox drag 변수 설정
		let originLeft = null;
		let originX = null;
		
		movieInnerContainer.addEventListener("mousedown",(e) => {				//마우스 클릭시 드래그 실행
			isDragging = true;
			originX = e.clientX;
			originLeft = movieInnerContainer.offsetLeft;
		});
		

		document.addEventListener("mousemove", (e) => {					//마우스 클릭 후 드래그 중 실행
			if(isDragging){
				const diffX = e.clientX - originX;
				const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
				let dragging = Math.min(Math.max(0, originLeft+diffX),endOfXPoint)
				movieInnerContainer.style.left = dragging+"px";
			}
		});

		document.addEventListener("mouseup", (e) => {			//드래그 후 마우스 놓을때 실행
			isDragging = false;
		})

        }
        