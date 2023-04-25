package com.soumyajit.blog_on.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/session")
public class SessionController {

    @GetMapping("/expired")
    public String expired() {
        return "Your session has expired ...";
    }

    @GetMapping("/view")
    public String view(HttpSession session) {
        String attr, ans = "SID -> " + session.getId() + "<br><br>";
        var attrNames = session.getAttributeNames();
        while(attrNames.hasMoreElements()) {
            attr = attrNames.nextElement();
            ans += attr + " -> " + session.getAttribute(attr) + "<br>";
        }
        return ans;
    }
    
}
