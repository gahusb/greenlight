package com.greenlight.bulletin.controller;

import com.greenlight.bulletin.repository.CommentRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class CommentControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate testRestTemplate;

    @Autowired
    private CommentRepository commentRepository;

    @Test
    public void 댓글등록() throws Exception{
        //given
        String title = "댓글이름";
        String content = "댓글내용";

        //wehn

        //then
    }
}
