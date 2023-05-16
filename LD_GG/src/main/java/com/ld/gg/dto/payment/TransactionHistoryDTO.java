package com.ld.gg.dto.payment;

import java.time.LocalDateTime;
import org.apache.ibatis.type.Alias;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Accessors(chain=true)
@Alias("tx")
public class TransactionHistoryDTO {
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy년 MM월 dd일 HH:mm:ss")
	private LocalDateTime tx_date;
	private int points_sent;
	private int points_received;
	private String sender_id;
    private String receiver_id;
}

