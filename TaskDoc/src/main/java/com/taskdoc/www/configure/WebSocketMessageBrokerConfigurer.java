package com.taskdoc.www.configure;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.AbstractWebSocketMessageBrokerConfigurer;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketMessageBrokerConfigurer extends AbstractWebSocketMessageBrokerConfigurer {

	@Override
	public void configureMessageBroker(MessageBrokerRegistry config) {
		// 메시지 브로커가 /topic/이 들어가는 구독자들에게 메시지를 전달해준다
		config.enableSimpleBroker(
				"/topic",
				"/chat",
				"/notice",
				"/project",
				"/webproject");

		// 클라이언트가 서버에게 /app 을 붙이고 메시지를 전달할 주소
		config.setApplicationDestinationPrefixes("/app");
	}

	
	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		// 클라이언트(javascript)가 서버에 접속할 Endpoint를설정한다.엔드포인트는 여러개 추가가능하다 .
		// client에서 Websocket대신 향상된 SockJS로 접속하려면 .withSockJS.()를 붙여준다.!
		registry.addEndpoint("/goStomp").setAllowedOrigins("*").withSockJS()
		.setClientLibraryUrl("//cdn.jsdelivr.net/sockjs/1/sockjs.min.js");
		System.out.println("websocket 접속");
	}

}
