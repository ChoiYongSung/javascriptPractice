package com.practice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PracticeController {


	@RequestMapping("/practice")
	public String practice() {
		
		return "practice";
	}
}