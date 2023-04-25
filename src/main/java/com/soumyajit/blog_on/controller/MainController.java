package com.soumyajit.blog_on.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.soumyajit.blog_on.model.Blog;
import com.soumyajit.blog_on.repository.BlogRepository;
import com.soumyajit.blog_on.service.UserService;

import jakarta.annotation.Nullable;

@Controller
@RequestMapping("/")
public class MainController {

    @Autowired UserService userService;
    @Autowired BlogRepository blogRepository;
    
    @GetMapping("/home")
    public String home() {
        return "index";
    }

    @GetMapping("/login")
    public String login(ModelMap modelMap, @Nullable @RequestParam("error") String error) {
        if(userService.isAuthenticated()) {
            String role = userService.getRole();
            if(role != null) {
                if(role.equals("ROLE_CREATOR")) return "redirect:/creator/dashboard";
                else if(role.equals("ROLE_ADMIN")) return "redirect:/admin/dashboard";
            }
        }

        if(error != null && error.equals("true")) modelMap.addAttribute("result", true);
        else modelMap.addAttribute("result", false);
        return "login";
    }

    // @PostMapping("/login_error")
    // public String login_error(ModelMap modelMap) {
    //     modelMap.addAttribute("result", false);
    //     return "login";
    // }
    
    @GetMapping("/viewblogs") 
    @PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_CREATOR')")
    public String viewBlogs(ModelMap modelMap, @Nullable @RequestParam("id") String id) {
        modelMap.addAttribute("username", userService.getUsername());
        String role = userService.getRole();
        modelMap.addAttribute("role", (role == null)? "???": (role.equals("ROLE_CREATOR"))? "Creator": (role.equals("ROLE_ADMIN"))? "Admin": ("<" + role + ">"));

        if(id != null) {
            Blog blog = blogRepository.findById(id).orElse(null);

            if(blog == null) return "blog_not_found";

            // modelMap.addAttribute("blog", blog);
            
            // // Handled in socket ...
            // blog.setTimesRead(blog.getTimesRead() + 1);
            // blogRepository.save(blog);

            modelMap.addAttribute("blogId", blog.getId());
            modelMap.addAttribute("blogUsername", blog.getUsername());
            modelMap.addAttribute("blogHeading", blog.getBlogHeading());
            modelMap.addAttribute("blogText", blog.getBlogText().replace("\n", "<br>"));
            modelMap.addAttribute("blogFile", blog.getBlogFile());
            modelMap.addAttribute("blogTimesRead", blog.getTimesRead());

            return "viewblogpage";
        }

        return "viewblogs";
    }

    @GetMapping("/access_denied")
    public String accessDenied() {
        return "access_denied";
    }

}
