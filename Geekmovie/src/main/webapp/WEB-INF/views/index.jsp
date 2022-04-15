
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<style>
		.movie-container{
			display : flex;
		}
	
		.movie-picture{
			width : 100px;
			height : 150px;
		}
	</style>
</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
    //const keyword = document.querySelector("#keyword")
    
    $(document).ready(function(){
    	
    	
    	
        $.ajax({
        	type: 'GET',
        	url: '/popularMovie?page=1&language=ko-KR',
        	dataType : 'json',
        	success: function(data){
        		console.log(data["results"])
        		var movies = data["results"]
        		
        		console.log(movies[0]);
        		
        	}
        
        	,
        	error: function(request, status, error){
        		console.log(request, status, error)
        	}
        	
        	
        })
    })
    </script>
<body>
<h1> ABCDEFG </h1>

<div class=movie-container>
<div class=movie-picture></div>
<div class=movie-picture></div>
<div class=movie-picture></div>
<div class=movie-picture></div>
</div>

</body>
</html>
