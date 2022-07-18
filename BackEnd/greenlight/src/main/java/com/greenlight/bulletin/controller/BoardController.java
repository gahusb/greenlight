package com.greenlight.bulletin.controller;

import com.greenlight.Member.dto.MemberResponseDto;
import com.greenlight.Member.dto.MemberSaveRequestDto;
import com.greenlight.Member.dto.MemberUpdateRequestDto;
import com.greenlight.Member.service.MemberService;
import com.greenlight.bulletin.dto.BoardSaveRequestDto;
import com.greenlight.bulletin.dto.BoardUpdateRequestDto;
import com.greenlight.bulletin.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class BoardController {
    private final BoardService boardService;

    @PostMapping("/board")
    public Long save(@RequestBody BoardSaveRequestDto boardSaveRequestDto){
        return boardService.save(boardSaveRequestDto);
    }

    @PutMapping("/board/{boardId}")
    public Long update(@PathVariable Long boardId, @RequestBody BoardUpdateRequestDto boardUpdateRequestDto){
        return boardService.update(boardId, boardUpdateRequestDto);
    }
}
