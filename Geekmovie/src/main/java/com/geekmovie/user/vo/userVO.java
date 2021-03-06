package com.geekmovie.user.vo;

public class userVO {
	
	private String id;
	private String password;
	private String name;
	private String gender;
	private String birthday;
	
	public userVO() {
		
	}

	public userVO(String id, String password, String name, String gender, String birthday) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.gender = gender;
		this.birthday = birthday;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	@Override
	public String toString() {
		return "userVO [id=" + id + ", password=" + password + ", name=" + name + ", gender=" + gender + ", birthday="
				+ birthday + "]";
	}

	
}
