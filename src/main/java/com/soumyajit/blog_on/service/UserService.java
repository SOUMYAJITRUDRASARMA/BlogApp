package com.soumyajit.blog_on.service;

import java.util.List;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    public boolean isAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if(authentication == null || AnonymousAuthenticationToken.class.isAssignableFrom(authentication.getClass())) return false;
        else return authentication.isAuthenticated();
    }

    public String getRole() {
        List<String> roleList = SecurityContextHolder.getContext().getAuthentication().getAuthorities().stream().map(a -> a.getAuthority()).toList();
        if(roleList.isEmpty()) return null;
        else return roleList.get(0);
    }

    public String getUsername() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if(authentication == null || authentication instanceof AnonymousAuthenticationToken) return null;
        else return authentication.getName();
    }
    
}
