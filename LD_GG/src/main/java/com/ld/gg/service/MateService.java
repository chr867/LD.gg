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
	public boolean replyMateModify(MateDto mDto) {
		log.info(mDto+"replyMateModify-Dto");
		try {
			Integer replyMateModifyResult = mDao.replyMateModify(mDto);
			if (replyMateModifyResult != 0) {
				log.info(replyMateModifyResult+"replyMateModifyResult");
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
	public MateDto getMateInfo(int mate_id) {
		MateDto MateInfo = mDao.getMateInfo(mate_id);
		return MateInfo;
	}
	public MateDto getReplyInfo(int mate_id) {
		MateDto MateReplyInfo = mDao.getReplyInfo(mate_id);
		return MateReplyInfo;
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
	/*public MateDto getSelectReplyList(int mate_r_id) {
		MateDto SelectReplyList = mDao.getMateDetails(mate_r_id);
		return SelectReplyList;
		
	}*/
	public int mateDelete(int mate_id) {
		log.info(mate_id+"mate_id");
		try {
			Integer mateDeleteResult = mDao.mateDelete(mate_id);
			log.info(mateDeleteResult+"mateDeleteResult");
			if (mateDeleteResult != 0) {
				log.info(mateDeleteResult+"mateDeleteResult");
				return 1;
			} else {
				log.info("메이트 서비스 델리트 실패");
				return 2;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return 4;
		}

	}
	public MateDto getReplySelect(int mate_id) {
		MateDto getReplySelect = mDao.getReplySelect(mate_id);
		log.info("getReplySelect"+getReplySelect);
		return getReplySelect;
	}


}
