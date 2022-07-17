package com.greenlight.Member.domain;

import com.greenlight.BaseTimeEntity;
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
public class Member extends BaseTimeEntity {
    @Id//PK
    @GeneratedValue(strategy = GenerationType.IDENTITY)// DB가 알아서 autoincrement
    private Long PK;
    private String id;
    private String password;
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
