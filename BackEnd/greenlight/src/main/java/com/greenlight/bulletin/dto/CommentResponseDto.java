package com.greenlight.bulletin.dto;

import com.greenlight.Member.domain.Member;
import com.greenlight.bulletin.domain.Comment;
import lombok.Getter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Getter
public class CommentResponseDto {
    private Long PK;
    private String comment;
    private String memberId;
    private Long boardId;
    private LocalDateTime createdDate;
    private LocalDateTime modifiedDate;


    public CommentResponseDto(Comment comment){
        this.PK = comment.getPK();
        this.comment = comment.getComment();
        this.memberId = comment.getMemberId();
        this.boardId = comment.getBoard().getPK();
        this.createdDate = comment.getCreatedDate();
        this.modifiedDate = comment.getModifiedDate();
    }
}
