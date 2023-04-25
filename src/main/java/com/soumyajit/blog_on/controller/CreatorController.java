package com.soumyajit.blog_on.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.soumyajit.blog_on.model.User;
import com.soumyajit.blog_on.repository.UserRepository;
import com.soumyajit.blog_on.service.UserService;

@Controller
@RequestMapping("/creator")
public class CreatorController {

    @Autowired
    private UserRepository userRepository;
    @Autowired UserService userService;
    
    @GetMapping("/login")
    public String login(ModelMap model) {
        model.addAttribute("result", false);
        return "creator_login";
    }

    @GetMapping("/signup")
    public String signup(ModelMap model) {
        model.addAttribute("result", 0);
        return "creator_signup";
    }

    @GetMapping("/dashboard")
    @PreAuthorize("hasRole('ROLE_CREATOR')")
    public String dashboard(ModelMap model) {
        model.addAttribute("username", userService.getUsername());
        return "creator_dashboard";
    }

    @PostMapping("/signup")
    public String signupPost(ModelMap model, @RequestParam("username") String username, @RequestParam("password") String password) {
        System.out.println("--> ADMIN SIGNUP -> Username: " + username + " , Password: " + password);

        User searchUser = userRepository.findUserByUsername(username);
        boolean result;
        if(searchUser != null) {
            result = false;
        }
        else {
            result = true;
            User saveUser = new User(username, password, "ROLE_CREATOR");
            userRepository.save(saveUser);
        }

        model.addAttribute("result", ((result)? 1: 2));
        return "admin_signup";
    }

}
