package restaurant;

public class RestaurantMenuVo {
	int		serial;					// 음식점 메뉴 테이블의 고유번호 PK
	int		pserial;				// 음식점 테이블의 PK serial
	String	rmName		= "";		// 메뉴 이름
	String	rmExplain	= "";		// 메뉴 설명
	String	rmPrice		= "";		// 메뉴 가격
	

	public int getSerial() {
		return serial;
	}
	public void setSerial(int serial) {
		this.serial = serial;
	}
	public int getPserial() {
		return pserial;
	}
	public void setPserial(int pserial) {
		this.pserial = pserial;
	}
	public String getRmName() {
		return rmName;
	}
	public void setRmName(String rmName) {
		this.rmName = rmName;
	}
	public String getRmExplain() {
		return rmExplain;
	}
	public void setRmExplain(String rmExplain) {
		this.rmExplain = rmExplain;
	}
	public String getRmPrice() {
		return rmPrice;
	}
	public void setRmPrice(String rmPrice) {
		this.rmPrice = rmPrice;
	}
	
	
}
