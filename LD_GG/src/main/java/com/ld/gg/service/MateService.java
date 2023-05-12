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
		log.info("{}", mList);
		return mList;
	}
	public List<MateDto> getReplyList(int mate_id) throws Exception {
		List<MateDto> mReplyList = mDao.getReplyList(mate_id);
		log.info("리플리스트"+ mReplyList);
		return mReplyList;
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
	public boolean mateModify(MateDto mDto) {
		log.info(mDto+"mateModify-Dto");
		try {
			Integer mateModifyResult = mDao.mateModify(mDto);
			if (mateModifyResult != 0) {
				log.info(mateModifyResult+"mateModifyResult");
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

	public int mateReplyInsert(MateDto mDto) {
		try {
			Integer insertResult = mDao.mateReplyInsert(mDto);
			if (insertResult != 0) {
				log.info(insertResult+"insertResult");
				int replyInsertResult =1;
				return replyInsertResult;
			} else {
				int replyInsertResult =2;
				return replyInsertResult;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			int replyInsertResult =4;
			return replyInsertResult;
		}

	}
	public MateDto getSelectReplyList(int mate_r_id) {
		MateDto SelectReplyList = mDao.getMateDetails(mate_r_id);
		return SelectReplyList;
		
	}
}
