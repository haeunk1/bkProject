package com.bkProject.p1.controller;

import com.bkProject.p1.FTPControl;
import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PageHandler;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.SearchCondition;
import com.bkProject.p1.service.PostService;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.SocketException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class TestController {
    @Autowired
    PostService postService;

    @GetMapping("/test")
    public String test() throws Exception {
        return "viewTest";
    }

    @GetMapping("/test2")
    public String test2() throws Exception {
        return "viewTest2";
    }
    private int port = 21;
    private final String user = "asdf";
    private final String pw = "1234";
    private final String server = "192.168.8.223";
//@GetMapping("/display2")
    public void testtttt(String fileName) throws Exception{
        FTPClient ftp = null;
        try {
            ftp = new FTPClient();
            ftp.setControlEncoding("UTF-8");
            ftp.connect(server,port);
            ftp.login(user,pw);
            ftp.changeWorkingDirectory("/dbdump");
            //ftp.changeWorkingDirectory("/dbdump");
            File f = new File("d:\\dbdump", "oradump1_200605.tmp");
            //File f = new File("d:\\dbdump", "oradump1_200605.tmp");
            FileOutputStream fos = null;
            try {
                fos = new FileOutputStream(f);
                boolean isSuccess = ftp.retrieveFile("oradump1.tmp", fos);
                //boolean isSuccess = ftp.retrieveFile("oradump1.tmp", fos);
                if (isSuccess) {
                    System.out.println("성공");
                } else {
                    System.out.println("실패");
                }
            }catch(IOException ex) {
                System.out.println(ex.getMessage());
            } finally { if (fos != null) try { fos.close(); } catch(IOException ex) {} } ftp.logout(); } catch (
                SocketException e) { System.out.println("Socket:"+e.getMessage()); } catch (IOException e) { System.out.println("IO:"+e.getMessage()); } finally { if (ftp != null && ftp.isConnected()) { try { ftp.disconnect(); } catch (IOException e) {} } }



            }
        }





