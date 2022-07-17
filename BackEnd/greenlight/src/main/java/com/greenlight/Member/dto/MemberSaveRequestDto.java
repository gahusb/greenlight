package com.greenlight.Member.dto;

import com.greenlight.Member.domain.Member;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class MemberSaveRequestDto {
    private String id;
    private String password;
    private String name;
    private boolean donated;

    @Builder
    public MemberSaveRequestDto(String id, String password, String name, boolean donated){
        this.id = id;
        this.password = password;
        this.name=name;
        this.donated=donated;
    }

    public Member toEntity() {
        return Member.builder()
                .id(id)
                .password(password)
                .name(name)
                .donated(donated)
                .build();
    }
}
