
var movieContainerWidth;	
var movieInnerContainerWidth;
var movieWidth;

var movieContainerResize = function() {						//movieContainer 리사이징 함수  - Resize하면 실행되는 함수 안에 넣을것
	if(window.innerWidth>1800){
		movieWidth=220;
	}else if(window.innerWidth>1500){
		movieWidth=210;
	}else if(window.innerWidth>=1000){
		movieWidth=200;
	}else if(window.innerWidth >=700){
		movieWidth=190;
	}else if(window.innerWidth >=600){
		movieWidth=180;
	}else{
		movieWidth=170;}
	movieContainerWidth = movieWidth*40-window.innerWidth;	
	movieInnerContainerWidth = movieWidth*20;
	$(".movies-container").width(movieContainerWidth+'px');
	$(".movies-container").offset({left:-movieWidth*20+window.innerWidth});
	$(".movies-innerContainer").width(movieInnerContainerWidth);
	$(".movies-innerContainer").each(function(index, item){
	if(Number(item.style.left.replace('px',''))>movieWidth*20-window.innerWidth){
		item.style.left=movieWidth*20-window.innerWidth+'px'; }
		})
	$(".movie-container").width(movieWidth+'px');	
}
		    		
  
			  
function movieSlideController(mc){			//적용하려는 개별 movie-container를 찾아서 선언할 것
	var mic =mc.children[0];
	mic.style.left=movieWidth*20-window.innerWidth;
	let isDragging = null;	
	let originLeft = null;
	let originX = null;
			
	function movieSlideCheck(mic){
		mic.addEventListener("mousedown",(e) => {				//마우스 클릭시 드래그 실행
		isDragging = true;
		originX = e.clientX;
		originLeft = mic.offsetLeft;
		});

	document.addEventListener("mousemove", (e) => {					//마우스 클릭 후 드래그 중 실행
		if(isDragging){
			const diffX = e.clientX - originX;
			const endOfXPoint = movieContainerWidth - movieInnerContainerWidth;
			let dragging = Math.min(Math.max(0, originLeft+diffX),endOfXPoint)
			mic.style.left = dragging+"px";
			}
		});
				

	document.addEventListener("mouseup", (e) => {			//드래그 후 마우스 놓을때 실행
		isDragging = false;})
	}
			
	return movieSlideCheck(mic);
}

