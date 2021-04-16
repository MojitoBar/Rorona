package com.example.demo.Controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.mapper.RoronaInfoMapper;
import com.example.demo.model.RoronaInfo;

@RestController
public class RoronaInfoController {

	private RoronaInfoMapper mapper;
	
	public RoronaInfoController(RoronaInfoMapper mapper) {
		this.setMapper(mapper);
	}

	@GetMapping("/roronainfo/all")
	public List<RoronaInfo> getRoronaInfo(){
		return mapper.getRoronaInfo();
	}
	
	@GetMapping("/notsudo/all")
	public List<RoronaInfo> getNotsudo(){
		return mapper.getNotsudo();
	}
	
	@PutMapping("/roronainfo/{id}")
	public void putRoronaInfo(@PathVariable("id") int id, 
			@RequestParam("name") String name,
			@RequestParam("rule") String rule, 
			@RequestParam("date") String date, 
			@RequestParam("description") String description,
			@RequestParam("image") String image,
			@RequestParam("colo1") String color1,
			@RequestParam("color2") String color2
			) {
		mapper.InsertRoronaInfo(id, name, rule, date, description, image, color1, color2);
	}
	
	@PostMapping("/roronainfo/{id}")
	public void postRoronaInfo(@PathVariable("id") int id, 
			@RequestParam("name") String name, 
			@RequestParam("rule") String rule,
			@RequestParam("date") String date, 
			@RequestParam("description") String description,
			@RequestParam("image") String image,
			@RequestParam("colo1") String color1,
			@RequestParam("color2") String color2
			) {
		mapper.UpdateRoronaInfo(id, name, rule, date, description, image, color1, color2);
	}
	
	public RoronaInfoMapper getMapper() {
		return mapper;
	}

	public void setMapper(RoronaInfoMapper mapper) {
		this.mapper = mapper;
	}
}
