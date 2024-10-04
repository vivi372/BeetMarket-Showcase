package com.beetmarket.aop;


import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	
	
	
	//실행하기 전후 전후
	@Around("execution(* com.beetmarket.*.service.*ServiceImpl.*(..))")
	//ProceedingJoinPoint - 실행 해야할 객체(ServiceImpl,param)
	public Object logTime(ProceedingJoinPoint pjp) throws Throwable {
		//시작 시간 저장
		long start = System.currentTimeMillis();
	
		log.info("##*************[AOP 실행 전 로그 출력]****************##");
		//실행되는 객체와 메서드의 이름 출력		
		log.info("## 실행 메서드: "+pjp.getSignature());
		//전달되는 파라메터 데이터 출력 
		for(int i=0;i<pjp.getArgs().length;i++) {
			Object obj = pjp.getArgs()[i];
			log.info("## 전달 데이터:"+((obj instanceof Object[])?Arrays.toString((Object[])obj):obj));			
		}
		log.info("##***************************************************##");
		//결과를 저장하는 변수
		Object result = null;
		
		//실행하는 부분 - 다른 AOP가 있으면 그쪽으로 가서 진행 처리하세요		
		result = pjp.proceed();
		
		log.info("##*************[AOP 실행 후 로그 출력]****************##");
		//실행 결과 데이터 출력
		log.info("## 결과 데이터 : "+result);
		
		//종료 시간 저장
		long end = System.currentTimeMillis();
		//종료 시간에 시작 시간을 빼서 동작 시간 계산
		log.info("## 소요 시간: "+(end - start));
		log.info("##***************************************************##");
		return result;
		
	}
	
}
