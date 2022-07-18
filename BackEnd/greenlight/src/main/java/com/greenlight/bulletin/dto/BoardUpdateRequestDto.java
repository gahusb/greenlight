package com.greenlight.bulletin.dto;

import com.greenlight.Member.domain.Member;
import com.greenlight.bulletin.domain.Board;
import com.greenlight.bulletin.domain.Comment;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor

public class BoardUpdateRequestDto {
    private String title;
    private String content;
    private List<Comment> comments;

    @Builder
    public BoardUpdateRequestDto(String title, String content, List<Comment> comments) {
        this.title = title;
        this.content = content;
        this.comments = comments;
    }
}
