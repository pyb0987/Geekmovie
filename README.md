<h2># Geekmovie</h2>

<h4>TMDB 웹사이트에서 제공하는 영화정보 API를 기반으로 만든 영화 리뷰 커뮤니티 사이트입니다.<br>
Spring, MySQL을 이용하여 제작하였습니다.</h4>
<br><br>
ppt파일 : 영화사이트 프로젝트ppt - 0516<br>
ppt폰트파일 : kopub
<br><br>
제작기간 : 2022.04.17~2022.05.15(1달)<br>
제작인원 : 3명<br>
사용프레임워크 : Spring 4.2D<br>
DB : MySQL<br>
외부 DB(TMDb) api를 연동하여 영화 정보 제공<br><br>

<h5>* 메인화면</h5>
<img src="img/indexShow.gif" width="900"/>
<img src="img/HeaderShow.gif" width="900"/>
헤더 : 검색기능, 로그인<br>
페이지 크기에 따른 폰트 및 엘리먼트 리사이징 plain script로 구현<br>
슬라이드 구현 : 레이지 로딩 적용<br>
모든 영화 포스터 : DB테이블을 연동한 좋아요와 찜기능<br>
게시글 : 추천수가 10 이상인 리뷰와 자유게시글 표시<br>
<br><br>

<h5>* 영화 검색</h5>
<img src="img/MovieSearchShow.gif" width="900"/>
헤더에서 영화를 검색했을 때 오는 페이지<br>
검색한 쿼리와 관련된 영화 20개씩 제공<br>
페이징, 좋아요, 찜기능 구현<br>
클릭시 영화 디테일로 이동<br>
<br><br>

<h5>* 영화 디테일</h5>
<img src="img/MovieDetailShow.gif" width="900"/>
관련영화 링크 제공<br>
외부링크의 평점과 본 사이트의 평점 제공(참여자가 3명 이상일 경우에)<br>
한줄평과 관련된 리뷰 표시<br>
