package com.greenlight.Member.repository;

import com.greenlight.Member.domain.Member;
import com.greenlight.Member.repository.MemberRepository;
import org.aspectj.lang.annotation.After;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;
import java.util.List;
import static org.assertj.core.api.Assertions.assertThat;


@SpringBootTest
public class MemberRepositoryTest {

    @Autowired
    MemberRepository memberRepository;

    @After("execution(*.com.greenlight.repository.MemberRepository.save(..))")
    public void cleanUp(){
        memberRepository.deleteAll();
    }

    @Test
    public void 회원저장_불러오기(){
        //given
        String name = "홍길동";
        boolean donated = true;

        memberRepository.save(
                Member.builder()
                        .name(name)
                        .donated(donated)
                        .build()
        );
        //when
        List<Member> memberList = memberRepository.findAll();
        
        //then
        Member member = memberList.get(memberList.size() - 1);
        assertThat(member.getName()).isEqualTo(name);
        assertThat(member.isDonated()).isEqualTo(donated);
    }

    @Test
    public void BaseTime등록(){
        //given
        LocalDateTime now = LocalDateTime.of(2022, 7, 17, 15, 47, 0);
        memberRepository.save(Member.builder()
                        .name("마우스")
                        .donated(true)
                        .build());

        //when
        List<Member> memberList = memberRepository.findAll();


        //then
        Member member = memberList.get(memberList.size() - 1);

        System.out.println(">>>>>>>>> createDate="+member.getCreatedDate() + ", modifiedDate=" + member.getModifiedDate());

        assertThat(member.getCreatedDate()).isAfter(now);
        assertThat(member.getModifiedDate()).isAfter(now);
    }
}
