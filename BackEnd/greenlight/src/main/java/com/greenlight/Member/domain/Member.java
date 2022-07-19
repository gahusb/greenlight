package com.greenlight.Member.domain;

import com.greenlight.BaseTimeEntity;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class Member extends BaseTimeEntity {
    @Id//PK
    @Column(name = "pk")
    @GeneratedValue(strategy = GenerationType.IDENTITY)// DB가 알아서 autoincrement
    private Long PK;
    @Column(nullable = false, length = 30, unique = true)
    private String id;
    @Column(nullable = false)
    private String password;
    @Column(nullable = false)
    private String name;
    private boolean donated;

    @Builder
    public Member(String id, String password, String name, boolean donated){
        this.id = id;
        this.password = password;
        this.name = name;
        this.donated = donated;
    }

    public void update(String password, String name, boolean donated){
        this.password = password;
        this.name = name;
        this.donated = donated;
    }
}
