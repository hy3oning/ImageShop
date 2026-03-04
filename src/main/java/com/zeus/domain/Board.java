package com.zeus.domain;

import java.util.Date;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class Board {

	private Integer boardNo;
	@NotBlank(message = "제목은 필수입니다.")
	private String title;
	@NotBlank(message = "내용은 필수입니다.")
	private String content;
	private String writer;
	private Date regDate;
	private Date updDate;
}
