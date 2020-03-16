package global.sesoc.board.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class chat {
	private String roomid;
	private String id;
	private String message;
}
