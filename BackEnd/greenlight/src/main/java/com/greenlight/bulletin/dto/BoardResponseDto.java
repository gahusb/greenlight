package com.greenlight.bulletin.dto;

import com.greenlight.Member.domain.Member;
import com.greenlight.bulletin.domain.Board;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardResponseDto {
    private Long PK;
    private String title;
    private String content;
    private String memberId;
    private List<CommentResponseDto> comments;

    public BoardResponseDto(Board board){
        this.PK = board.getPK();
        this.title = board.getTitle();
        this.content = board.getContent();
        this.memberId = board.getMemberId();
        this.comments = board.getComments().stream().map(CommentResponseDto::new).collect(Collectors.toList());
    }
}
