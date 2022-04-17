package com.geekmovie.movie.vo;

import java.sql.Date;
import java.util.List;


public class MovieDetailVo {
	public MovieDetailVo(){};
	
	
	private boolean adult;
	private String backdrop_path;
	//private String belongs_to_collection;
	private String budget;

	public List<Genres> genres;
	class Genres{
		private int id;
		private String name;

		public Genres(int id, String name) {
			super();
			this.id = id;
			this.name = name;
		}

		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		@Override
		public String toString() {
			return "Genres [id=" + id + ", name=" + name + "]";
		}
		
	}
	private String homepage;
	private int id;
	//private String imdb_id;
	//private String original_language;
	private String original_title;
	private String overview;
	private double popularity;
	private String poster_path;
	public List<Production_companies> production_companies;
	class Production_companies{
		private int id;
		private String logo_path;
		private String name;
		private String origin_country;
		
		
		public Production_companies(int id, String logo_path, String name, String origin_country) {
			super();
			this.id = id;
			this.logo_path = logo_path;
			this.name = name;
			this.origin_country = origin_country;
		}


		public int getId() {
			return id;
		}


		public void setId(int id) {
			this.id = id;
		}


		public String getLogo_path() {
			return logo_path;
		}


		public void setLogo_path(String logo_path) {
			this.logo_path = logo_path;
		}


		public String getName() {
			return name;
		}


		public void setName(String name) {
			this.name = name;
		}


		public String getOrigin_country() {
			return origin_country;
		}


		public void setOrigin_country(String origin_country) {
			this.origin_country = origin_country;
		}


		@Override
		public String toString() {
			return "Production_companies [id=" + id + ", logo_path=" + logo_path + ", name=" + name
					+ ", origin_country=" + origin_country + "]";
		}
		
		
		
	}
	public List<Production_countries> production_countries;
	class Production_countries{
		private String iso_3166_1;
		private String name;
		
		
		public Production_countries(String iso_3166_1, String name) {
			super();
			this.iso_3166_1 = iso_3166_1;
			this.name = name;
		}


		public String getIso_3166_1() {
			return iso_3166_1;
		}


		public void setIso_3166_1(String iso_3166_1) {
			this.iso_3166_1 = iso_3166_1;
		}


		public String getName() {
			return name;
		}


		public void setName(String name) {
			this.name = name;
		}


		@Override
		public String toString() {
			return "Production_countries [iso_3166_1=" + iso_3166_1 + ", name=" + name + "]";
		}
		
		
		
	}
	private Date release_date;
	//private String revenue;
	private int runtime;
	//public List<Spoken_languages> spoken_languages;
	//class Spoken_languages{
		//private String english_name;
		//private String iso_639_1;
		//private String name;
	//}
	private String status;
	//private String tagline;
	private String title;
	//private Boolean video;
	private double vote_average;
	private int vote_count;



	
	
	public MovieDetailVo(boolean adult, String backdrop_path, String budget, List<Genres> genres, String homepage,
			int id, String original_title, String overview, double popularity, String poster_path,
			List<Production_companies> production_companies, List<Production_countries> production_countries,
			Date release_date, int runtime, String status, String title, double vote_average, int vote_count) {
		super();
		this.adult = adult;
		this.backdrop_path = backdrop_path;
		this.budget = budget;
		this.genres = genres;
		this.homepage = homepage;
		this.id = id;
		this.original_title = original_title;
		this.overview = overview;
		this.popularity = popularity;
		this.poster_path = poster_path;
		this.production_companies = production_companies;
		this.production_countries = production_countries;
		this.release_date = release_date;
		this.runtime = runtime;
		this.status = status;
		this.title = title;
		this.vote_average = vote_average;
		this.vote_count = vote_count;
	}
	
	
	public boolean isAdult() {
		return adult;
	}


	public void setAdult(boolean adult) {
		this.adult = adult;
	}


	public String getBackdrop_path() {
		return backdrop_path;
	}


	public void setBackdrop_path(String backdrop_path) {
		this.backdrop_path = backdrop_path;
	}


	public String getBudget() {
		return budget;
	}


	public void setBudget(String budget) {
		this.budget = budget;
	}


	public List<Genres> getGenres() {
		return genres;
	}


	public void setGenres(List<Genres> genres) {
		this.genres = genres;
	}


	public String getHomepage() {
		return homepage;
	}


	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getOriginal_title() {
		return original_title;
	}


	public void setOriginal_title(String original_title) {
		this.original_title = original_title;
	}


	public String getOverview() {
		return overview;
	}


	public void setOverview(String overview) {
		this.overview = overview;
	}


	public double getPopularity() {
		return popularity;
	}


	public void setPopularity(double popularity) {
		this.popularity = popularity;
	}


	public String getPoster_path() {
		return poster_path;
	}


	public void setPoster_path(String poster_path) {
		this.poster_path = poster_path;
	}


	public List<Production_companies> getProduction_companies() {
		return production_companies;
	}


	public void setProduction_companies(List<Production_companies> production_companies) {
		this.production_companies = production_companies;
	}


	public List<Production_countries> getProduction_countries() {
		return production_countries;
	}


	public void setProduction_countries(List<Production_countries> production_countries) {
		this.production_countries = production_countries;
	}


	public Date getRelease_date() {
		return release_date;
	}


	public void setRelease_date(Date release_date) {
		this.release_date = release_date;
	}


	public int getRuntime() {
		return runtime;
	}


	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public double getVote_average() {
		return vote_average;
	}


	public void setVote_average(double vote_average) {
		this.vote_average = vote_average;
	}


	public int getVote_count() {
		return vote_count;
	}


	public void setVote_count(int vote_count) {
		this.vote_count = vote_count;
	}


	@Override
	public String toString() {
		return "MovieDetailVo [adult=" + adult + ", backdrop_path=" + backdrop_path + ", budget=" + budget + ", genres="
				+ genres + ", homepage=" + homepage + ", id=" + id + ", original_title=" + original_title
				+ ", overview=" + overview + ", popularity=" + popularity + ", poster_path=" + poster_path
				+ ", production_companies=" + production_companies + ", production_countries=" + production_countries
				+ ", release_date=" + release_date + ", runtime=" + runtime + ", status=" + status + ", title=" + title
				+ ", vote_average=" + vote_average + ", vote_count=" + vote_count + "]";
	}



}
