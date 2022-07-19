package com.greenlight.bulletin.dto;

import com.greenlight.Member.domain.Member;
import com.greenlight.bulletin.domain.Board;
import com.greenlight.bulletin.domain.Comment;
import lombok.*;

@Getter
@NoArgsConstructor
@Builder
@Data
@AllArgsConstructor
public class CommentSaveRequestDto {
    private Long PK;
    private String comment;
    private Board board;
    private String memberId;

    public Comment toEntity() {
        return Comment.builder()
                .PK(PK)
                .comment(comment)
                .board(board)
                .memberId(memberId)
                .build();
    }
}
