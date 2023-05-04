package com.ld.gg.dto;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
public class SessionDto {
	private String logType;
	private String email;
	private String ipAddress;
	private String requestURI;
	private String httpMethod;
	private String userAgent;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private String sessionDate;

}
