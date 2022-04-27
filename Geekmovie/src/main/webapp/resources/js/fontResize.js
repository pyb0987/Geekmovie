

function fontResize(){
if(window.innerWidth>1800){   //폰트 리사이징
				$("html").css("fontSize", "16px")
			}else if(window.innerWidth>1500){
				$("html").css("fontSize", "14.5px")
			}else if(window.innerWidth>1000){
				$("html").css("fontSize", "13px")
			}else if(window.innerWidth>700){
				$("html").css("fontSize", "11px")
			}
			else if(window.innerWidth>600){
				$("html").css("fontSize", "9.5px")
			}else{
				$("html").css("fontSize", "8px")
				}
				}