package com.greenlight.bulletin.repository;

import com.greenlight.bulletin.domain.Comment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface  CommentRepository extends JpaRepository<Comment, Long> {
}
