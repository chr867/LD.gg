package com.ld.gg.dto.summoner;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("champ_record")
@Accessors(chain = true)
public class ChampRecordDto {

}
