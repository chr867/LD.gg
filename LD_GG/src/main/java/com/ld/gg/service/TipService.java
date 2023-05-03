package com.ld.gg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ld.gg.dao.TipDao;
import com.ld.gg.dto.TipDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TipService {
	@Autowired
	private TipDao tDao;

	public boolean tipWrite(TipDto tDto) {
		try {
			Integer insertResult = tDao.insertTip(tDto);
			
			if(insertResult != 0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}

	public List<TipDto> getTipList() throws Exception{
		List<TipDto> tList = tDao.getBoardList();
		log.info("{}",tList);
		return tList;
	}

	public List<TipDto> getSearchList(String keyword) throws Exception{
		List<TipDto> sList = tDao.getSearchList(keyword);
		log.info("{}",sList);
		return sList;
	}

	public TipDto getTipDetails(int t_b_num) throws Exception{
		return tDao.getTipDetails(t_b_num);
		
	}

	public void updateView(TipDto tipDetails) throws Exception{
		tDao.updateView(tipDetails);
		
	}
	
	public int recomUpdate(TipDto tDto) {
		try {
			Integer recomInfo = tDao.recomInfo(tDto);
			log.info("추천정보 결과:"+recomInfo);
			if(recomInfo == null) {
				log.info("추천 인서트 시작");
				log.info("{}",tDto);
				int recomInsertResult = tDao.insertRecom(tDto);
				log.info("추천 인서트 결과 : "+recomInsertResult);
				if(recomInsertResult != 0) {
					return 1;
				}else {
					return 4;
				}
			}else {
				log.info("추천 딜리트 시작");
				int recomDeleteResult = tDao.deleteRecom(tDto);
				log.info("추천 딜리트 결과 : "+recomDeleteResult);
				if(recomDeleteResult != 0) {
					return 2;
				}else {
					return 4;
				}
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return 4;
		}
	}

	public TipDto getTipinfo(int t_b_num) {
		try {
			return tDao.getTipinfo(t_b_num);
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return null;
		}
	}

	public boolean ModifyTip(TipDto tDto) {
		try {
			int updateResult = tDao.updateModifyTip(tDto);
			log.info("공략글 수정 결과 :"+updateResult);
			if(updateResult != 0) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return false;
		}
	}
	
	public int replyInsert(TipDto tDto) {
		try {
			int insertResult = tDao.replyInsert(tDto);
			log.info("댓글 인서트 결과:"+insertResult);
			if(insertResult != 0) {
				return 1;
			}else {
				return 2;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return 4;
		}
	}

	public List<TipDto> getReplyList(int t_b_num) {
		try {
			List<TipDto> rList = tDao.getReplyList(t_b_num);
			return rList;
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return null;
		}
	}

	public int tipDelete(int t_b_num) {
		try {
			int deleteResult = tDao.deleteTip(t_b_num);
			
			if(deleteResult != 0) {
				return 1;
			}else {
				return 2;
			}
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return 4;
		}
	}

	public TipDto getReplyinfo(int t_r_num) {
		return tDao.getReplyinfo(t_r_num);
	}

	public int replyDelete(int t_r_num) {
		try {
			int deleteResult = tDao.deleteReply(t_r_num);
			
			if(deleteResult != 0) {
				return 1;
			}else 
				return 2;
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
			return 4;
		}
	}


	
}
