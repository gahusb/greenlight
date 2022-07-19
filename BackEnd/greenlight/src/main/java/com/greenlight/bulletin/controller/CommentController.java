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

    @PostMapping("/board/comment/{memberId}/{boardId}")
    public Long save(@PathVariable String memberId, @RequestBody Long boardId, @RequestBody CommentSaveRequestDto commentSaveRequestDto){
        return commentService.save(memberId, boardId, commentSaveRequestDto);
    }

    @PutMapping("/board/comment/{memberId}/{commentId}/{boardId}/")
    public Long update(@PathVariable Long boardId, @PathVariable Long commentId, @RequestBody CommentUpdateRequestDto commentUpdateRequestDto){
        return commentService.update(boardId, commentId, commentUpdateRequestDto);
    }
}
