package com.example.demo.model;

public class RoronaInfo {
	private int id;
	private String name;
	private String rule;
	private String date;
	private String description;
	private String image;
	private String color1;
	private String color2;
	
	public RoronaInfo(int id, String name, String rule, String date, String description, String image, String color1, String color2) {
		super();
		this.id = id;
		this.name = name;
		this.rule = rule;
		this.date = date;
		this.description = description;
		this.image = image;
		this.color1 = color1;
		this.color2 = color2;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getRule() {
		return rule;
	}

	public void setRule(String rule) {
		this.rule = rule;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getColor2() {
		return color2;
	}

	public void setColor2(String color2) {
		this.color2 = color2;
	}

	public String getColor1() {
		return color1;
	}

	public void setColor1(String color1) {
		this.color1 = color1;
	}
}
