package global.sesoc.board.dao.guestbook;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.board.vo.guestbook;

@Repository
public class guestbookDAO {

	@Autowired
	private SqlSession session;
	
	public int insertGuest(guestbook guest) {
		guestbookMapper mapper = session.getMapper(guestbookMapper.class);
		int result = 0;
		
		try {
			result = mapper.insert(guest);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public ArrayList<guestbook> selectAll() {
		guestbookMapper mapper = session.getMapper(guestbookMapper.class);
		ArrayList<guestbook> list = null;
		
		try {
			list = mapper.selectAll();
		} catch (Exception e) {
			e.getStackTrace();
		}
		return list;
	}
	
	public ArrayList<guestbook> search(HashMap<String, Object> map) {
		guestbookMapper mapper = session.getMapper(guestbookMapper.class);
		ArrayList<guestbook> list = null;
		
		try {
			list = mapper.search(map);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return list;
	}
	
	public guestbook select(int seqno) {
		guestbookMapper mapper = session.getMapper(guestbookMapper.class);
		guestbook vo = null;
		
		try {
			vo = mapper.select(seqno);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return vo;
	}
	
	public void delete(int seqno) {
		guestbookMapper mapper = session.getMapper(guestbookMapper.class);
		
		try {
			mapper.delete(seqno);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	public void update(guestbook guest) {
		guestbookMapper mapper = session.getMapper(guestbookMapper.class);
		
		try {
			mapper.update(guest);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
}
