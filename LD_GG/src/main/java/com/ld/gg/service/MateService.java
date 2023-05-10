package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.MateDao;
import com.ld.gg.dto.MateDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MateService {
	@Autowired
	private MateDao mDao;

	public List<MateDto> getMateList() throws Exception {
		List<MateDto> mList = mDao.getBoardList();
		log.info("겟메이트서비스탔어용");
		log.info("{}", mList);
		return mList;
	}

	public boolean mateWrite(MateDto mDto) {
		try {
			Integer insertResult = mDao.insertMate(mDto);
			if (insertResult != 0) {
				log.info(insertResult+"insertResult");
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}

	}

	public MateDto getMateDetails(int mate_id) {
		MateDto MateDetails = mDao.getMateDetails(mate_id);
		return MateDetails;
	}
}
