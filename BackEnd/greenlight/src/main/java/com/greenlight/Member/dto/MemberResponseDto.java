package com.greenlight.Member.dto;

import com.greenlight.Member.domain.Member;
import lombok.Getter;

@Getter
public class MemberResponseDto {
    private Long PK;
    private String id;
    private String password;
    private String name;
    private boolean donated;

    public MemberResponseDto(Member member){
        this.PK = member.getPK();
        this.id = member.getId();
        this.password = member.getPassword();
        this.name = member.getName();
        this.donated = member.isDonated();
    }
}
