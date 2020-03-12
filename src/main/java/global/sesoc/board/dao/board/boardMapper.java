package global.sesoc.board.dao.board;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.board.vo.board;

public interface boardMapper {

	public int insert(board board);
//	public ArrayList<board> selectAll(HashMap<String, Object> map);
//	public ArrayList<board> currentPage(HashMap<String, Object> map);
//	public ArrayList<board> search(HashMap<String, Object> map);
	public board select(int boardno);
	public int delete(board board);
	public int update(board board);
	public void count(board board);
	public int getBoardCount(HashMap<String, Object> map);
	public ArrayList<board> selectAll(HashMap<String, Object> map, RowBounds rb);
}
