package com.greenlight.bulletin.dto;

import com.greenlight.Member.domain.Member;
import com.greenlight.bulletin.domain.Board;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class BoardSaveRequestDto {
    private Long PK;
    private String title;
    private String content;
    private Member member;

    public Board toEntity() {
        return Board.builder()
                .PK(PK)
                .title(title)
                .content(content)
                .member(member)
                .build();
    }
}
