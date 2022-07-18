package com.greenlight.bulletin.controller;

import com.greenlight.bulletin.dto.CommentSaveRequestDto;
import com.greenlight.bulletin.dto.CommentUpdateRequestDto;
import com.greenlight.bulletin.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class CommentController {
    private final CommentService commentService;

    @PostMapping("/board/{id}/comment")
    public Long save(@RequestBody CommentSaveRequestDto commentSaveRequestDto){
        return commentService.save(commentSaveRequestDto);
    }

    @PutMapping("/board/{boardId}/comment/{commentId}")
    public Long update(@PathVariable Long boardId, @PathVariable Long commentId, @RequestBody CommentUpdateRequestDto commentUpdateRequestDto){
        return commentService.update(boardId, commentId, commentUpdateRequestDto);
    }
}
