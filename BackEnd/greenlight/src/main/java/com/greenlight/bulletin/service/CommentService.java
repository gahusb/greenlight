package com.greenlight.bulletin.service;

import com.greenlight.bulletin.domain.Board;
import com.greenlight.bulletin.domain.Comment;
import com.greenlight.bulletin.dto.CommentSaveRequestDto;
import com.greenlight.bulletin.dto.CommentUpdateRequestDto;
import com.greenlight.bulletin.repository.BoardRepository;
import com.greenlight.bulletin.repository.CommentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@RequiredArgsConstructor
@Service
public class CommentService {
    private final CommentRepository commentRepository;
    private final BoardRepository boardRepository;

    @Transactional
    public Long save(CommentSaveRequestDto commentSaveRequestDto){
        return commentRepository.save(commentSaveRequestDto.toEntity()).getPK();
    }

    // 댓글 수정 -> board에 저장된 댓글 리스트도 수정됨
    @Transactional
    public Long update(Long boardPK, Long commentPK, CommentUpdateRequestDto commentUpdateRequestDto){
        Board board = boardRepository.findById(boardPK)
                .orElseThrow(() -> new IllegalArgumentException("해당 댓글이 포함된 게시글이 없습니다. boardPK=" + boardPK));
        Comment comment = commentRepository.findById(commentPK)
                .orElseThrow(() -> new IllegalArgumentException("해당 댓글이 없습니다. commentPK="+commentPK));
        List<Comment> modifiedComments = board.getComments();
        modifiedComments.remove(comment);
        modifiedComments.add(comment);

        comment.update(
                commentUpdateRequestDto.getContent());
        board.update(
                board.getTitle(),
                board.getContent(),
                modifiedComments);
        return commentPK;
    }
}
