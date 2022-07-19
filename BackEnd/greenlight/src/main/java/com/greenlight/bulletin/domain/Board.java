package com.greenlight.bulletin.domain;

import com.greenlight.BaseTimeEntity;
import com.greenlight.Member.domain.Member;
import lombok.*;

import javax.persistence.*;
import java.util.List;

@Getter
@NoArgsConstructor
@Entity
@Data
@Builder
@AllArgsConstructor
public class Board extends BaseTimeEntity {
    @Id//PK
    @Column(name = "pk")
    @GeneratedValue(strategy = GenerationType.IDENTITY)// DB가 알아서 autoincrement
    private Long PK; // 글 ID

    @Column(length = 500, nullable = false)
    private String title; // 글 제목

    @Column(columnDefinition = "TEXT", nullable = false)
    private String content; // 글 내용

    private String memberId;

    @OneToMany(mappedBy = "board", fetch = FetchType.EAGER, cascade = CascadeType.REMOVE)
    @OrderBy("PK asc")
    private List<Comment> comments;

    public void update(String title, String content, List<Comment> comments){
        this.title = title;
        this.content = content;
        this.comments = comments;
    }
}
