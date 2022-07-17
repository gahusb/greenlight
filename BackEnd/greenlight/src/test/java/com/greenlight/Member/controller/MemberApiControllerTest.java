package com.greenlight.Member.controller;

import com.greenlight.Member.domain.Member;
import com.greenlight.Member.dto.MemberSaveRequestDto;
import com.greenlight.Member.dto.MemberUpdateRequestDto;
import com.greenlight.Member.repository.MemberRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class MemberApiControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate testRestTemplate;

    @Autowired
    private MemberRepository memberRepository;

//    @After("")
//    public void clear() throws Exception{
//        memberRepository.deleteAll();
//    }

    @Test
    public void 회원등록() throws Exception{
        //given
        String name = "에어팟";
        boolean donated = true;
        MemberSaveRequestDto memberSaveRequestDto = MemberSaveRequestDto.builder()
                .id("leedjik")
                .password("greenlight")
                .name(name)
                .donated(donated)
                .build();

        String url = "http://localhost:" + port + "/member/create";


        //when
        ResponseEntity<Long> responseEntity = testRestTemplate.postForEntity(url, memberSaveRequestDto, Long.class);
        //then
        assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(responseEntity.getBody()).isGreaterThan(0L);

        List<Member> all = memberRepository.findAll();
        assertThat(all.get(all.size() - 1).getName()).isEqualTo(name);
        assertThat(all.get(all.size() - 1).isDonated()).isEqualTo(donated);
    }

    @Test
    public void 회원수정() throws Exception {
        //given
        Member member = memberRepository.save(Member.builder()
                        .name("위스터디")
                        .donated(true)
                        .build());

        Long testId = member.getPK();
        String testName = "위스터디2";
        boolean testDonated = false;

        MemberUpdateRequestDto memberUpdateRequestDto =
                MemberUpdateRequestDto.builder()
                        .name(testName)
                        .donated(testDonated)
                        .build();

        String url = "http://localhost:" + port + "/member/create/" + testId;
        HttpEntity<MemberUpdateRequestDto> updateRequestDtoHttpEntity = new HttpEntity<>(memberUpdateRequestDto);

        //when
        ResponseEntity<Long> responseEntity = testRestTemplate
                .exchange(url, HttpMethod.PUT, updateRequestDtoHttpEntity, Long.class);

        //then
        assertThat(responseEntity.getStatusCode())
                .isEqualTo(HttpStatus.OK);
        assertThat(responseEntity.getBody()).isGreaterThan(0L);

        List<Member> all = memberRepository.findAll();
        assertThat(all.get(all.size() - 1).getName()).isEqualTo(testName);
        assertThat(all.get(all.size() - 1).isDonated()).isEqualTo(testDonated);
    }
}
