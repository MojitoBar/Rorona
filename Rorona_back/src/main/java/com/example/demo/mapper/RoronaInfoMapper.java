package com.example.demo.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.model.RoronaInfo;

@Mapper
public interface RoronaInfoMapper {
	@Select("select * from roronainfo")
	List<RoronaInfo> getRoronaInfo();
	
	@Select("select * from notsudo")
	List<RoronaInfo> getNotsudo();
	
	@Insert("insert into roronainfo values(#{id}, #{name}, #{rule}, #{date}, #{description}, #{image}, #{color1}, #{color2})")
	int InsertRoronaInfo(@Param("id") int id, @Param("name") String name, @Param("rule") String rule, @Param("date") String date, @Param("description") String description, @Param("image") String image, @Param("color1")String color1, @Param("color2")String color2);
	

	@Update("update roronainfo set name=#{name}, rule=#{rule}, date=#{date}, description=#{description}, image=#{image}, color1=#{color1}, color2=#{color2} where id=#{id}")
	int UpdateRoronaInfo(@Param("id") int id, @Param("name") String name, @Param("rule") String rule, @Param("date") String date, @Param("description") String description, @Param("image") String image, @Param("color1")String color1, @Param("color2")String color2);
}