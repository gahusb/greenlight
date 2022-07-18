package com.greenlight.bulletin.dto;

import com.greenlight.Member.domain.Member;
import com.greenlight.bulletin.domain.Board;
import com.greenlight.bulletin.domain.Comment;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Builder
@AllArgsConstructor
public class CommentSaveRequestDto {
    private Long PK;
    private String comment;
    private Board board;
    private Member member;

    public Comment toEntity() {
        return Comment.builder()
                .PK(PK)
                .comment(comment)
                .board(board)
                .member(member)
                .build();
    }
}
