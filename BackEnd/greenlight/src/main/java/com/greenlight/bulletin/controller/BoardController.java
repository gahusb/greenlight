package com.greenlight.bulletin.controller;

import com.greenlight.bulletin.dto.BoardResponseDto;
import com.greenlight.bulletin.dto.BoardSaveRequestDto;
import com.greenlight.bulletin.dto.BoardUpdateRequestDto;
import com.greenlight.bulletin.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class BoardController {
    private final BoardService boardService;

    /* CREATE */
    @PostMapping("/board/{memberId}")
    public Long save(@PathVariable String memberId, @RequestBody BoardSaveRequestDto boardSaveRequestDto){
        return boardService.save(memberId, boardSaveRequestDto);
    }
    /* READ */
    @GetMapping("/board/{memberId}/{boardId}")
    public BoardResponseDto read(@PathVariable String memberId, @PathVariable Long boardId){
        return boardService.findById(memberId, boardId);
    }


    /* UPDATE */
    @PutMapping("/board/{memberId}/{boardId}")
    public Long update(@PathVariable String memberId, @PathVariable Long boardId, @RequestBody BoardUpdateRequestDto boardUpdateRequestDto){
        return boardService.update(memberId, boardId, boardUpdateRequestDto);
    }

    /* DELETE */
    @DeleteMapping("/board/{memberId}/{boardId}")
    public ResponseEntity delete(@PathVariable String memberId, @PathVariable Long boardId){
        boardService.delete(memberId, boardId);
        return ResponseEntity.ok(boardId);
    }
}
