package global.sesoc.board.dao.member;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.board.vo.member;

@Repository
public class memberDAO {

	@Autowired
	private SqlSession session;
	
	public int signup(member member) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		int result = 0;
		
		try {
			result = mapper.signup(member);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public member login(String id) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		member vo = null;
		
		try {
			vo = mapper.login(id);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return vo;
	}
	
	public int check(member member) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		int result = 0;
		
		try {
			result = mapper.check(member);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public void delete(String id, String pw) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("pw", pw);
			mapper.delete(map);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	public void update(member member) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		
		try {
			mapper.update(member);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}
}
