package global.sesoc.board.dao.reply;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.board.vo.reply;

@Repository
public class replyDAO {

	@Autowired
	private SqlSession session;

	public int insertReply(reply reply) {
		replyMapper mapper = session.getMapper(replyMapper.class);
		int result = 0;

		try {
			result = mapper.insert(reply);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public int deleteReply(reply reply) {
		replyMapper mapper = session.getMapper(replyMapper.class);
		int result = 0;

		try {
			result = mapper.delete(reply);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public int modifyReply(reply reply) {
		replyMapper mapper = session.getMapper(replyMapper.class);
		int result = 0;

		try {
			result = mapper.modify(reply);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}
	
	public ArrayList<reply> selectAll(int boardno, int startRecord, int countPerPage) {
		replyMapper mapper = session.getMapper(replyMapper.class);
		ArrayList<reply> reply = null;

		try {
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			reply = mapper.selectAll(boardno, rb);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return reply;
	}
	
	public int getTotalCount(int boardno) {
		replyMapper mapper = session.getMapper(replyMapper.class);
		int count = 0;
		
		try {
			count = mapper.getTotalCount(boardno);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return count;
	}
	
	public ArrayList<Integer> count() {
		replyMapper mapper = session.getMapper(replyMapper.class);
		ArrayList<Integer> count = null;
		
		try {
			count = mapper.count();
		} catch (Exception e) {
			e.getStackTrace();
		}
		return count;
	}
}
