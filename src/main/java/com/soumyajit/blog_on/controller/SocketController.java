package com.soumyajit.blog_on.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RestController;

import com.soumyajit.blog_on.model.Blog;
import com.soumyajit.blog_on.model.BlogUpload;
import com.soumyajit.blog_on.repository.BlogRepository;
import com.soumyajit.blog_on.service.FileService;

@RestController
public class SocketController {

    @Autowired BlogRepository blogRepository;
    @Autowired FileService fileService;
    
    @MessageMapping("/add_blog")
    @SendTo("/topic/blog_added")
    public Blog handleAddBlog(BlogUpload blogUpload) {
        if(!blogUpload.getFileName().isEmpty()) System.out.println("Received (ADD) -> " + blogUpload.getFileName() + " | Size = " + blogUpload.getBlogFileContents().length);
        // try { if(!blogUpload.getFileName().isEmpty()) System.out.println("Received (ADD) -> " + blogUpload.getFileName() + " | Size = " + blogUpload.getBlogFileContents().length); } 
        // catch (IOException e) { e.printStackTrace(); Blog blog = new Blog(); blog.setUsername(blogUpload.getUsername()); blog.setId(""); return blog; }

        Blog blog = new Blog();
        blog.setUsername(blogUpload.getUsername());
        blog.setBlogHeading(blogUpload.getBlogHeading());
        blog.setBlogText(blogUpload.getBlogText());
        blog.setTimesRead(0);

        if(blogRepository.findBlogByUsernameAndHeading(blogUpload.getUsername(), blogUpload.getBlogHeading()) != null) {
            blog.setId(null);
            blog.setUsername(blogUpload.getUsername());
            return blog;
        }
        else {
            if(!blogUpload.getFileName().isEmpty()) {
                String extension, savedFileName = blog.getUsername() + "_" + blog.getBlogHeading();
                if(!blogUpload.getFileName().contains(".")) extension = "";
                extension = blogUpload.getFileName().substring(blogUpload.getFileName().lastIndexOf(".") + 1);
                savedFileName += "." + extension;

                // try{ fileService.saveFileToStaticUserFiles(blogUpload.getBlogFileContents(), savedFileName); } 
                try{ fileService.saveFileToDevelopmentStaticUserFiles(blogUpload.getBlogFileContents(), savedFileName); } 
                catch(IOException e){ e.printStackTrace(); blog.setId(""); return blog; }
                blog.setBlogFile(savedFileName);
            }
            else blog.setBlogFile("");

            blog.setId(blogRepository.save(blog).getId());
            return blog;
        }
    }

    @MessageMapping("/update_blog")
    @SendTo("/topic/blog_updated")
    public Blog handleUpdateBlog(BlogUpload blogUpload) {
        if(!blogUpload.getFileName().isEmpty()) System.out.println("Received (UPDATE) -> " + blogUpload.getFileName() + " | Size = " + blogUpload.getBlogFileContents().length);
        // try { if(!blogUpload.getFileName().isEmpty()) System.out.println("Received (ADD) -> " + blogUpload.getFileName() + " | Size = " + blogUpload.getBlogFileContents().length); } 
        // catch (IOException e) { e.printStackTrace(); Blog blog = new Blog(); blog.setUsername(blogUpload.getUsername()); blog.setId(""); return blog; }

        Blog blog = new Blog();
        blog.setId(blogUpload.getId());
        blog.setUsername(blogUpload.getUsername());
        blog.setBlogHeading(blogUpload.getBlogHeading());
        blog.setBlogText(blogUpload.getBlogText());

        // Blog foundBlog = blogRepository.findBlogByUsernameAndHeading(blogUpload.getUsername(), blogUpload.getBlogHeading());
        Blog foundBlog = blogRepository.findById(blog.getId()).orElse(null);
        if(foundBlog == null) {
            blog.setId(null);
            blog.setUsername(blogUpload.getUsername());
            return blog;
        }
        else if(!blog.getBlogHeading().equals(foundBlog.getBlogHeading()) && blogRepository.findBlogByUsernameAndHeading(blogUpload.getUsername(), blogUpload.getBlogHeading()) != null) {
            blog.setId("-1");
            blog.setUsername(blogUpload.getUsername());
            return blog;
        }
        else {
            blog.setTimesRead(foundBlog.getTimesRead());
            if(!blogUpload.getFileName().isEmpty()) {
                String extension, savedFileName = blog.getUsername() + "_" + blog.getBlogHeading();
                if(!blogUpload.getFileName().contains(".")) extension = "";
                extension = blogUpload.getFileName().substring(blogUpload.getFileName().lastIndexOf(".") + 1);
                savedFileName += "." + extension;

                // try{ fileService.saveFileToStaticUserFiles(blogUpload.getBlogFileContents(), savedFileName); } 
                try{ fileService.saveFileToDevelopmentStaticUserFiles(blogUpload.getBlogFileContents(), savedFileName); } 
                catch(IOException e){ e.printStackTrace(); blog.setId(""); return blog; }
                blog.setBlogFile(savedFileName);
            }
            else blog.setBlogFile(foundBlog.getBlogFile());

            // blog.setId(blogRepository.save(blog).getId());
            blogRepository.save(blog);
            return blog;
        }
    }

    @MessageMapping("/give_all_blog/{username}")
	@SendTo("/topic/get_all_blog/{username}")
	public List<Blog> handleSendAllBlog(@DestinationVariable("username") String username) {
		List<Blog> payload = blogRepository.findAll();
		System.out.println("[get_all_blog] Sending Payload -->  " + payload);
		return payload;
	}

    @MessageMapping("/give_all_creator_blog/{username}")
	@SendTo("/topic/get_all_creator_blog/{username}")
	public List<Blog> handleSendAllCreatorBlog(@DestinationVariable("username") String username) {
		List<Blog> payload = blogRepository.findBlogsByUsername(username);
		System.out.println("[get_all_creator_blog] Sending Payload -->  " + payload);
		return payload;
	}

    @MessageMapping("/delete_blog")
	@SendTo("/topic/blog_deleted")
	public Blog handleDeleteBlog(Blog blog) {
		// blog id = id to be deleted , blog username = who requested it ...
        Blog findBlog = blogRepository.findById(blog.getId()).orElse(null);
        if(findBlog == null){ blog.setId(null); return blog; }
        else{ blogRepository.deleteById(blog.getId()); return blog; }
	}

    @MessageMapping("/view_blog")
	@SendTo("/topic/blog_viewed")
    public Blog handleBlogViewed(String id) {
        if(id.startsWith("\"")) id = id.substring(1);
        if(id.endsWith("\"")) id = id.substring(0, id.length() - 1);
        Blog blog = blogRepository.findById(id).orElse(null);
        System.out.println("ID Received = " + id + " , Blog Found = " + blog);
        if(blog != null) {
            blog.setTimesRead(blog.getTimesRead() + 1);
            blogRepository.save(blog);
            return blog;
        }
        else {
            blog = new Blog();
            blog.setId("");
            return blog;
        }        
    }

}
