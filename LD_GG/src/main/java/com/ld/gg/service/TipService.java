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

	public List<TipDto> getTipList() {
		List<TipDto> tList = tDao.getBoardList();
		log.info("{}",tList);
		return tList;
	}

	public List<TipDto> getSearchList(String keyword) {
		List<TipDto> sList = tDao.getSearchList(keyword);
		log.info("{}",sList);
		return sList;
	}

	public TipDto getTipDetails(int t_b_num) {
		return tDao.getTipDetails(t_b_num);
		
	}

	public void updateView(TipDto tipDetails) {
		tDao.updateView(tipDetails);
		
	}
	
}
