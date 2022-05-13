<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <head>
 <style>
        footer{
    	height : 200px;
        padding: 25px;
    	top : 0;
    	left : 0;
       width: 100%;
        background-color: black;
        align-items: center;
        display: flex;
    flex-direction: column;
    justify-content: space-around;
    border-top: solid 20px darkred;
    margin-top : 20px;
}
        nav a{
            color : white;
            font-size: 1.3rem;
            margin : 0 20px;
        }
        .product span{
            color : white;
            font-size: 0.7rem;
        }

        .productWrap{
                height: 50px;
        }
        .productorWrap{
            display: flex;
            transform: translateX(-30px);
        }
        .copyright span{
            color : white;
        }
    </style>
</head>
<body>
    <footer>

        <nav>
        <a href="https://github.com/pyb0987/Geekmovie">Github</a> <a>|</a>
        <a href="https://www.themoviedb.org/?language=ko">TMDB</a>
        
        </nav>
        <div class="productorWrap">
            <div class="product productor"><span>제작자 : &nbsp;</span></div>
            <div class="productWrap">
            <div class="product">
            <span>박영빈 | pyb0987@naver.com</span>
            </div>
            <div class="product">
            <span>박태훈 | geami7@naver.com</span>
            </div>
            <div class="product">
            <span>이준우 | leejunwoo200@naver.com</span>
            </div>
        </div>
        </div> 
        <div class="copyright">
            <span>CopyRight 2022. <strong>GeekMovie</strong>. All rights reserved.</span>
        </div>   
        
        
        
        </footer>
</body>
</html>
