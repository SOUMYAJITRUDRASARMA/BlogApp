package com.soumyajit.blog_on.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import com.soumyajit.blog_on.model.User;

public interface UserRepository extends MongoRepository<User, String> {
    
    @Query("{username:'?0'}")
    User findUserByUsername(String username);

}
