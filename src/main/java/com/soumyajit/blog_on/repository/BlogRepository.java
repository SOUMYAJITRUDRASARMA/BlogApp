package com.soumyajit.blog_on.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.soumyajit.blog_on.model.Blog;

public interface BlogRepository extends MongoRepository<Blog, String> {
    
    @Query("{username:'?0'}")
    List<Blog> findBlogsByUsername(String username);

    @Query("{username:'?0' , blogHeading:'?1'}")
    Blog findBlogByUsernameAndHeading(String username, String blogHeading);
}
