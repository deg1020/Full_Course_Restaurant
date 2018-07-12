package restaurant;

public class RestaurantPhotoVo {
	int		serial;					// 음식점 사진 테이블의 PK 
	int		pserial;				// 음식점 테이블의 PK
	String	tagName		= "";		// 사진이 들어갈 태그의 이름
	String	rmAttFile	= "";		// 사진 파일 이름

	
	
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
	public String getTagName() {
		return tagName;
	}
	public void setTagName(String tagName) {
		this.tagName = tagName;
	}
	public String getRmAttFile() {
		return rmAttFile;
	}
	public void setRmAttFile(String rmAttFile) {
		this.rmAttFile = rmAttFile;
	}
}
