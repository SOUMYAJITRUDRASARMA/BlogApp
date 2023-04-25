package com.soumyajit.blog_on.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

@Service
public class FileService {
    
    public void saveFileToStaticUserFiles(byte[] data, String fileName) throws IOException {
        String parentFolder = ResourceUtils.getFile("classpath:static").getAbsolutePath() + "/user_files";
        // String parentFolder = "D:/JU/Class Resources/3rd Year 2nd Semester/Internet Technology Practical/Assignment 5/blog_on/src/main/java/com/soumyajit/blog_on/resources/static/user_files";
        System.out.println(" ----->    Saving file (" + fileName + ") of size = " + data.length + " to location = " + parentFolder);
        FileOutputStream fos = new FileOutputStream(new File(parentFolder + "/" + fileName));
        fos.write(data);
        fos.close();
    }

    public void saveFileToDevelopmentStaticUserFiles(byte[] data, String fileName) throws IOException {
        // String parentFolder = ResourceUtils.getFile("classpath:static").getAbsolutePath() + "/user_files";
        String parentFolder = "D:/JU/Class Resources/3rd Year 2nd Semester/Internet Technology Practical/Assignment 5/blog_on/src/main/resources/static/user_files";
        System.out.println(" ----->    Saving file (" + fileName + ") of size = " + data.length + " to location = " + parentFolder);
        FileOutputStream fos = new FileOutputStream(new File(parentFolder + "/" + fileName));
        fos.write(data);
        fos.close();
    }

}
