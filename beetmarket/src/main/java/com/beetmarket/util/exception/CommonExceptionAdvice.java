package com.beetmarket.util.exception;

import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

//자동 생성
//@Controller, @Service, @RestController, @Repository, @~Advice
@ControllerAdvice
@Log4j
public class CommonExceptionAdvice {
	
		@ExceptionHandler(Exception.class)
		public String except(Exception ex,Model model) {
			log.error("Exception......"+ex.getMessage());
			//jsp로 ex를 전달
			model.addAttribute("exception",ex);
			log.error(model);
			
			return "error/error_page";
		}
		
		@ExceptionHandler(NoHandlerFoundException.class)
		@ResponseStatus(HttpStatus.NOT_FOUND)
		public String handle404(NoHandlerFoundException ex) {
			return "error/custom404";
		}

}
