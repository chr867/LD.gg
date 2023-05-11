package com.ld.gg.controller.chat;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // StompEndpointRegistry : WebSocket endpoint 등록하는 클래스.
        registry.addEndpoint("/chat/chatroom").withSockJS(); // /chatroom으로 들어오는 클라이언트 endpoint로 등록.
        //withSockJS() : SockJS 활성화.
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // MessageBrokerRegistry : 메시지 브로커 등록하고 구성.
        registry.enableSimpleBroker("/topic"); // 메시지 브로커 활성화하는 메소드.
        registry.setApplicationDestinationPrefixes("/app"); // STOMP 클라이언트에서 보내는 메시지의 대상 주소를 정의하는데 사용되는 경로 prefix 설정.
    }


}
