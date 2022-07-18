package com.greenlight.Chat.controller;

import com.greenlight.Chat.model.Chat;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;

@RequiredArgsConstructor
public class ChatMessageController {
    private final SimpMessageSendingOperations simpMessageSendingOperations;

    @MessageMapping("/chat/message")
    public void message(Chat chat){
        if(Chat.MessageType.ENTER.equals(chat.getMessageType()))
            chat.setMessage("["+ chat.getSender() + "]님이 입장하셨습니다.");
        simpMessageSendingOperations.convertAndSend("/room/chat/room", chat);
    }
}
