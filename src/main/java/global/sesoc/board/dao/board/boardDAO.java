package global.sesoc.board.dao.board;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.board.vo.board;

@Repository
public class boardDAO {

	@Autowired
	private SqlSession session;

	public int insertBoard(board board) {
		boardMapper mapper = session.getMapper(boardMapper.class);
		int result = 0;

		try {
			result = mapper.insert(board);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}

//	public ArrayList<board> selectAll1(HashMap<String, Object> map) {
//		boardMapper mapper = session.getMapper(boardMapper.class);
//		ArrayList<board> list = null;
//
//		try {
//			list = mapper.selectAll(map);
//		} catch (Exception e) {
//			e.getStackTrace();
//		}
//		return list;
//	}
	
//	public ArrayList<board> currentPage(HashMap<String, Object> map) {
//		boardMapper mapper = session.getMapper(boardMapper.class);
//		ArrayList<board> list = null;
//
//		try {
//			list = mapper.currentPage(map);
//		} catch (Exception e) {
//			e.getStackTrace();
//		}
//		return list;
//	}

//	public ArrayList<board> search(HashMap<String, Object> map) {
//		boardMapper mapper = session.getMapper(boardMapper.class);
//		ArrayList<board> list = null;
//		
//		try {
//			list = mapper.search(map);
//		} catch (Exception e) {
//			e.getStackTrace();
//		}
//		return list;
//	}

	public board select(int boardno) {
		boardMapper mapper = session.getMapper(boardMapper.class);
		board vo = null;

		try {
			vo = mapper.select(boardno);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return vo;
	}

	public int delete(board board) {
		boardMapper mapper = session.getMapper(boardMapper.class);
		int result = 0;

		try {
			result = mapper.delete(board);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}

	public int update(board board) {
		boardMapper mapper = session.getMapper(boardMapper.class);
		int result = 0;

		try {
			result = mapper.update(board);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return result;
	}

	public void count(board board) {
		boardMapper mapper = session.getMapper(boardMapper.class);

		try {
			mapper.count(board);
		} catch (Exception e) {
			e.getStackTrace();
		}
	}

	public int getBoardCount(String select, String aim) {
		boardMapper mapper = session.getMapper(boardMapper.class);
		int totalRecordCount = 0;
		
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("select", select);
			map.put("aim", aim);
			
			totalRecordCount = mapper.getBoardCount(map);
		} catch (Exception e) {
			e.getStackTrace();
		}
		return totalRecordCount;
	}
	
	public ArrayList<board> selectAll(String select, String aim, int startRecord, int countPerPage) {
		boardMapper mapper = session.getMapper(boardMapper.class);
		ArrayList<board> list = null;

		try {
			RowBounds rb = new RowBounds(startRecord, countPerPage);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("select", select);
			map.put("aim", aim);
			
			list = mapper.selectAll(map, rb);
		} catch (Exception e) {
			e.getStackTrace();
		}
		System.out.println(list);
		return list;
	}
}
