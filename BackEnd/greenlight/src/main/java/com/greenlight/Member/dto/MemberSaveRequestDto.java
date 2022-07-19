package com.greenlight.Member.dto;

import com.greenlight.Member.domain.Member;
import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class MemberSaveRequestDto {
    private String id;
    private String password;
    private String name;
    private boolean donated;

    public Member toEntity() {
        return Member.builder()
                .id(id)
                .password(password)
                .name(name)
                .donated(donated)
                .build();
    }
}
