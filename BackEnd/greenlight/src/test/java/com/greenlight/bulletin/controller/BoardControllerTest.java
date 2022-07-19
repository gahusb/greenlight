package com.greenlight.bulletin.controller;

import com.greenlight.Member.dto.MemberSaveRequestDto;
import com.greenlight.bulletin.domain.Board;
import com.greenlight.bulletin.dto.BoardResponseDto;
import com.greenlight.bulletin.dto.BoardSaveRequestDto;
import com.greenlight.bulletin.dto.BoardUpdateRequestDto;
import com.greenlight.bulletin.repository.BoardRepository;
import com.greenlight.bulletin.repository.CommentRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.*;

import java.util.List;

import static com.mysql.cj.conf.PropertyKey.logger;
import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class BoardControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate testRestTemplate;

    @Autowired
    private BoardRepository boardRepository;

    @Test
    public void 게시판등록() throws Exception{
        //given
        String title = "게시판이름";
        String content = "게시판내용";
        String memberId = "cashbee";
        BoardSaveRequestDto boardSaveRequestDto =
                BoardSaveRequestDto.builder()
                        .title(title)
                        .content(content)
                        .memberId(memberId)
                        .build();
        String url = "http://localhost:" + port + "/board/cashbee";


        //when
        ResponseEntity<Long> responseEntity = testRestTemplate.postForEntity(url, boardSaveRequestDto, Long.class);


        //then
        assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(responseEntity.getBody()).isGreaterThan(0L);

        List<Board> boardList = boardRepository.findAll();
        assertThat(boardList.get(boardList.size() - 1).getContent()).isEqualTo(content);
        assertThat(boardList.get(boardList.size() - 1).getTitle()).isEqualTo(title);
        assertThat(boardList.get(boardList.size() - 1).getMemberId()).isEqualTo(memberId);
    }

    @Test
    public void 게시판수정() throws Exception{
        //given

        String title = "게시판이름9";
        String content = "게시판내용9";
        BoardUpdateRequestDto boardUpdateRequestDto =
                BoardUpdateRequestDto.builder()
                        .title(title)
                        .content(content)
                        .build();
        String url = "http://localhost:" + port + "/board/cashbee/1";
        HttpEntity<BoardUpdateRequestDto> boardUpdateRequestDtoHttpEntity
                = new HttpEntity<>(boardUpdateRequestDto);


        //when
        ResponseEntity<Long> responseEntity = testRestTemplate.exchange(url, HttpMethod.PUT, boardUpdateRequestDtoHttpEntity, Long.class);


        //then
        assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(responseEntity.getBody()).isGreaterThan(0L);

        List<Board> boardList = boardRepository.findAll();
        assertThat(boardList.get(0).getContent()).isEqualTo(content);
        assertThat(boardList.get(0).getTitle()).isEqualTo(title);
    }

    @Test
    public void 게시판조회() throws Exception{
        //given
        String title = "게시판이름9";
        String content = "게시판내용9";
        String memberId = "cashbee";

        String url = "http://localhost:" + port + "/board/cashbee/1";


        //when
        ResponseEntity<BoardResponseDto> responseEntity =
                testRestTemplate.getForEntity(url, BoardResponseDto.class);
        BoardResponseDto respDto = responseEntity.getBody();


        //then
        assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);

        List<Board> boardList = boardRepository.findAll();
        assertThat(respDto.getContent()).isEqualTo(content);
        assertThat(respDto.getTitle()).isEqualTo(title);
        assertThat(respDto.getMemberId()).isEqualTo(memberId);
    }

    @Test
    public void 게시판삭제() throws Exception{
        //given
//        String title = "게시판이름9";
//        String content = "게시판내용9";
//        String memberId = "cashbee";
        Board board = boardRepository.save(
                Board.builder()
                        .title("제목삭제")
                        .content("내용삭제")
                        .memberId("아이디")
                        .build()
        );
        Long savedPk = board.getPK();

        String url = "http://localhost:" + port + "/board/cashbee/" + savedPk;

        HttpEntity<Board> entity = new HttpEntity<>(board);

        //when
        ResponseEntity<Long> responseEntity =
                testRestTemplate.exchange(url, HttpMethod.DELETE, entity, Long.class);

        //then
        assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);

        assertThat(responseEntity.getBody()).isEqualTo(savedPk);
    }
}
