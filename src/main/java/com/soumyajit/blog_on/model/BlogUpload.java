package com.soumyajit.blog_on.model;

public class BlogUpload {

    private String id;
    private String username;
    private String blogHeading;
    private String blogText;
    private byte[] blogFileContents; // Map<String, Byte> , byte[]
    private String fileName;

    public BlogUpload(){  }
    
    public BlogUpload(String id, String username, String blogHeading, String blogText, byte[] blogFileContents, String fileName) {
        this.id = id;
        this.username = username;
        this.blogHeading = blogHeading;
        this.blogText = blogText;
        this.blogFileContents = blogFileContents;
        this.fileName = fileName;
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
    public byte[] getBlogFileContents() {
        return blogFileContents;
    }
    public void setBlogFileContents(byte[] blogFileContents) {
        this.blogFileContents = blogFileContents;
    }
    public String getFileName() {
        return fileName;
    }
    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    
}
