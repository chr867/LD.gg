package com.ld.gg.dto.admin;

import java.time.LocalDateTime;
import java.util.Date;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain=true)
@Alias("notice_reply")
public class NoticeReply {
  private int t_r_num;
  private int t_b_num;
  private String t_r_content;

  @DateTimeFormat(pattern="yyyy-MM-dd")
  private Date t_r_date;
}
