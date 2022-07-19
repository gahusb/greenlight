package com.greenlight.bulletin.dto;

import com.greenlight.Member.domain.Member;
import com.greenlight.bulletin.domain.Board;
import lombok.*;

@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
@Data
public class BoardSaveRequestDto {
    private Long PK;
    private String title;
    private String content;
    private String memberId;

    public Board toEntity() {
        return Board.builder()
                .PK(PK)
                .title(title)
                .content(content)
                .memberId(memberId)
                .build();
    }
}
