package com.soumyajit.blog_on.model;

import org.springframework.data.mongodb.core.mapping.Document;

import com.mongodb.lang.NonNull;

import nonapi.io.github.classgraph.json.Id;

@Document(collection = "blog")
public class Blog {
    
    @Id private String id;
    @NonNull private String username;
    @NonNull private String blogHeading;
    @NonNull private String blogText;
    @NonNull private String blogFile;
    @NonNull private long timesRead;

    public Blog(){  }

    public Blog(String id, String username, String blogHeading, String blogText, String blogFile, long timesRead) {
        this.id = id;
        this.username = username;
        this.blogHeading = blogHeading;
        this.blogText = blogText;
        this.blogFile = blogFile;
        this.timesRead = timesRead;
    }
    

    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getBlogHeading() {
        return blogHeading;
    }
    public void setBlogHeading(String blogHeading) {
        this.blogHeading = blogHeading;
    }
    public String getBlogText() {
        return blogText;
    }
    public void setBlogText(String blogText) {
        this.blogText = blogText;
    }
    public String getBlogFile() {
        return blogFile;
    }
    public void setBlogFile(String blogFile) {
        this.blogFile = blogFile;
    }
    public long getTimesRead() {
        return timesRead;
    }
    public void setTimesRead(long timesRead) {
        this.timesRead = timesRead;
    }

}
