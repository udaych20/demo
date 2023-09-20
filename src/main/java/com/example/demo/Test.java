package com.example.demo;
import org.springframework.stereotype.Component;


@Component
public class Test{
	@jakarta.annotation.PostConstruct
	public void test(){
		long i = 0;
		while(true) {
			System.out.println("Hi - " + ++i);
			try {
				Thread.sleep(1000l);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}