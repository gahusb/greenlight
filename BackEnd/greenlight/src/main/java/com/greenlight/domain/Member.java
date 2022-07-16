package com.greenlight.domain;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Getter
@NoArgsConstructor
@Entity
public class Member {
    @Id//PK
    @GeneratedValue(strategy = GenerationType.IDENTITY)// DB가 알아서 autoincrement
    private Long id;

    private String name;

    private boolean donated;

    @Builder
    public Member(String name, boolean donated){
        this.name = name;
        this.donated = donated;
    }
}
