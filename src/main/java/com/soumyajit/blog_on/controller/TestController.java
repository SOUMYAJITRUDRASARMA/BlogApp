package com.soumyajit.blog_on.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestController {
    
    @GetMapping("/t1")
    public String t1()
    {
        return "Lol ... Test 1 !!!";
    }

    @GetMapping("/t2")
    public String t2()
    {
        return "Lol ... Test 2 !!!";
    }

}
