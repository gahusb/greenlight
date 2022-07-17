package com.greenlight.Member.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberUpdateRequestDto {
    private String password;
    private String name;
    private boolean donated;

    @Builder
    public MemberUpdateRequestDto(String password, String name, boolean donated){
        this.password = password;
        this.name = name;
        this.donated = donated;
    }
}
