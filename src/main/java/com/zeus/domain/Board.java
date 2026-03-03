package com.zeus.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Board {

	private Integer boardNo;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private Date updDate;
}
