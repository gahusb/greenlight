package com.greenlight.bulletin.service;

import com.greenlight.bulletin.domain.Board;
import com.greenlight.bulletin.dto.BoardSaveRequestDto;
import com.greenlight.bulletin.dto.BoardUpdateRequestDto;
import com.greenlight.bulletin.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@RequiredArgsConstructor
@Service
public class BoardService {
    private final BoardRepository boardRepository;

    @Transactional
    public Long save(BoardSaveRequestDto boardSaveRequestDto){
        return boardRepository.save(boardSaveRequestDto.toEntity()).getPK();
    }

    @Transactional
    public Long update(Long PK, BoardUpdateRequestDto boardUpdateRequestDto){
        Board board = boardRepository.findById(PK)
                .orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. PK="+PK));
        board.update(
                boardUpdateRequestDto.getTitle(),
                boardUpdateRequestDto.getContent(),
                boardUpdateRequestDto.getComments());
        return PK;
    }
}
