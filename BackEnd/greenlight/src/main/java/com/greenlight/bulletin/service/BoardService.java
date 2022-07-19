package com.greenlight.bulletin.service;

import com.greenlight.Member.repository.MemberRepository;
import com.greenlight.bulletin.domain.Board;
import com.greenlight.bulletin.dto.BoardResponseDto;
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
    private final MemberRepository memberRepository;

    @Transactional
    public Long save(String memberId, BoardSaveRequestDto boardSaveRequestDto){
        boardSaveRequestDto.setMemberId(memberId);
        return boardRepository.save(boardSaveRequestDto.toEntity()).getPK();
    }

    @Transactional
    public BoardResponseDto findById(String memberId, Long boardId){
        Board board = boardRepository.findById(boardId)
                .orElseThrow(()-> new IllegalArgumentException("해당 게시글이 존재하지 않습니다. boardId=" + boardId));

        return new BoardResponseDto(board);
    }

    @Transactional
    public Long update(String memberId, Long boardId, BoardUpdateRequestDto boardUpdateRequestDto){
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. PK="+boardId));
        board.update(
                boardUpdateRequestDto.getTitle(),
                boardUpdateRequestDto.getContent(),
                boardUpdateRequestDto.getComments());
        return board.getPK();
    }

    @Transactional
    public void delete(String memberId, Long boardId){
        Board board = boardRepository.findById(boardId)
                .orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. boardId=" + boardId));
        boardRepository.delete(board);
    }
}
