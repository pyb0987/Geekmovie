
function movieLike(userId){
	$.fn.activeLikeMovie = function() {			// - 이미 눌린 좋아요 버튼 active효과주기	- clickBox에 적용
		if(userId!=""){
    			this.each(function(i,e){
    			let movieId = $(e).data('id');
         	   $.ajax({
    			   url: '/movie/Like/'+movieId+'?userId='+userId+'&mode='+1,		//좋아요 버튼부터
    			   method: "GET",
    	           success: function(data){
    	        	   if(data==1){		   
    	        	   $(e).children(".heartClick").addClass("is-active");
    	        	   }else if(data==0){
    		        	   $(e).children(".heartClick").removeClass("is-active"); 
    	        	   }
    	       		},
    	       		error: function(request, status, error){
    	        		console.log(request, status, error)
    	       		}
    	       		});
         	   $.ajax({
    			   url: '/movie/Like/'+movieId+'?userId='+userId+'&mode='+0,		//add 버튼
    			   method: "GET",
    	           success: function(data){
    	        	   if(data==1){		   
    	        	   $(e).children(".addClick").addClass("is-active");
    	        	   }else if(data==0){
    		        	   $(e).children(".addClick").removeClass("is-active"); 
    	        	   }
    	       		},
    	       		error: function(request, status, error){
    	        		console.log(request, status, error)
    	       		}
    	       		});
    		});
			}
    	}


	//if('${sessionScope.id}'!=''){
    //	 $(".clickBox").activeLikeMovie();
	//}
		
        $(document).on("click", ".heartClickClicker, .addClick", function(e){		//하트 버튼 누를때 이벤트
        	 if(userId==''){
 				var result = confirm("로그인이 필요한 서비스 입니다. \n로그인 페이지로 이동 하시겠습니까?");
 				if(result){
 				    location.href = 'user_join';
 				}
 			}else{
 				if ($(e.currentTarget).hasClass('heartClickClicker')){
 					var container = $(e.currentTarget).parent().parent();
 					var mode = 1;
 				}else{ 					
 					var container = $(e.currentTarget).parent();	
 					var mode = 0;
 				}
 				var movieId = container.data('id');
 				
	    		var likeData = {};
	    		likeData['mode'] = mode;
	    		likeData['userId'] = userId;
	    		console.log(movieId)
 				$.ajax({
					   url: '/movie/Like/'+movieId,
					   method: "POST",
					   data: JSON.stringify(likeData),
					   dataType: "json",
			           contentType:"application/json;charset=UTF-8",
			           success: function(data){
     
			           
			           if(mode == 1){
			        	   if(data==1){
			        	   $(e.currentTarget).parents(".heartClick").addClass("is-active");	
			        	   }else if(data==2){
			        		   $(e.currentTarget).parents(".heartClick").removeClass("is-active");	
			        	   }else{
			        		   console.log("오류가 발생했습니다.")
			        	   }
			           }else if(mode == 0){
			        	   if(data==1){
			        		$(e.currentTarget).addClass("is-active");	
			           		}else if(data==2){
			           		$(e.currentTarget).removeClass("is-active");	
				        	}else{
				        	console.log("오류가 발생했습니다.")
			           		}
			  		   }
			           }
 				})
 			}
        })
}