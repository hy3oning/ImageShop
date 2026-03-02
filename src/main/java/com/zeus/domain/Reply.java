package com.zeus.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Reply {
	private Integer replyNo;
	private Integer boardNo;
	private String content;
	private String writer;
	private Date regDate;
	private Date updDate;
}
