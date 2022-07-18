package com.greenlight.bulletin.domain;

import com.greenlight.BaseTimeEntity;
import com.greenlight.Member.domain.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
@Builder
@AllArgsConstructor
public class Comment extends BaseTimeEntity {
    @Id//PK
    @GeneratedValue(strategy = GenerationType.IDENTITY)// DB가 알아서 autoincrement
    private Long PK; // 댓글 ID

    @Column(columnDefinition = "TEXT", nullable = false)
    private String comment; // 댓글 내용

    @ManyToOne
    @JoinColumn(name = "board_pk")
    private Board board;

    @ManyToOne
    @JoinColumn(name = "member_pk")
    private Member member; // 사용자 ID

    public void update(String comment){
        this.comment = comment;
    }
}
