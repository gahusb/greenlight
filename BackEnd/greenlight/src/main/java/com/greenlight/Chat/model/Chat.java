package com.greenlight.Chat.model;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Getter
@Setter
public class Chat {

    public enum MessageType{
        ENTER, TALK
    }
    private MessageType messageType;
    @Id
    @GeneratedValue
    @Column(name = "chat_id")
    private Long id;

    private String sender;

    @Column(columnDefinition = "TEXT")
    private String message;

    @CreatedDate
    @Column(updatable = false)
    private LocalDateTime sendData;

    @Builder
    public Chat(String sender, String message){
        this.sender = sender;
        this.message = message;
        this.sendData = LocalDateTime.now();
    }

    /***
     *
     * 채팅 생성
     * @Param room: 채팅 방
     * @Param sender: 보낸 이
     * @Param message: 내용
     * @return Chat Entity
     *
     */
    public static Chat createChat(String sender, String message){
        return Chat.builder()
                .sender(sender)
                .message(message)
                .build();
    }
}
