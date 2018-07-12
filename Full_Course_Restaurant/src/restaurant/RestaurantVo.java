package restaurant;

import java.util.HashMap;
import java.util.Map;

public class RestaurantVo {
	int 	serial;						// 음식점 테이블의 고유번호 PK
	String 	rname		= "";			// 음식점 이름
	int	rtimeOpen;						// 오픈시간
	int	rtimeClose;						// 마감시간
	String	rholiday	= "";			// 휴일정보
	String	rbathroom	= "";			// 화장실 정보
	String	rdrink		= "";			// 주류 정보
	String	rfacilities = "";			// 시설 정보
	 String	raddress1	= "";			// 주소(시/도)
	 String	raddress2	= "";			// 주소(군/구)
	String	rdate		= "";			// 게시글 입력, 수정 날짜
	int		rhit;						// 조회수
	String	rpwd		= "";			// 게시글 등록 비밀번호
	
	String 	mid			= "";			// 회원 아이디
	int		mserial;					// 회원 테이블의 PK
	String	rjuso		= "";			// 음식점 주소
	String  rmenus		= "";			// 음식점 대표 메뉴들
	String  rinfo		= "";			// 음식점 간략 설명
	
	int  rtable;						// 음식점 테이블 수
	String  rphone = "";				// 음식점 전화번호
	
	String 	findStr 	= "";			// 검색어
	String 	msg			= "";			// 처리 결과 메시지
	String  orderBy		= "등록순";		// 정렬방법
	String[] rmName;					// 메뉴 이름 저장할 배열
	String[] rmPrice;					// 메뉴 가격 저장할 배열
	String[] rmExplain;					// 메뉴 설명 저장할 배열
	String rmAttFile 	= "";			// 사진 파일명 
	int	pserial;						// 음식점 테이블과 다른 테이블을 연결시켜주는 외래키
	
	Map<String,String> map = new HashMap<String,String>(); // 사진 파일명과 태그이름을 담을 map
	
	int nowPage =1;						// 초기값 현재 페이지 = 1페이지
	int startNo = 0;					// 페이지 데이터 시작 번호
	int endNo   = 0;					// 페이지 데이터 끝 번호
	
	
	
	
	public int getPserial() {
		return pserial;
	}
	public void setPserial(int pserial) {
		this.pserial = pserial;
	}
	public String getRmAttFile() {
		return rmAttFile;
	}
	public void setRmAttFile(String rmAttFile) {
		this.rmAttFile = rmAttFile;
	}
	public Map<String, String> getMap() {
		return map;
	}
	public void setMap(Map<String, String> map) {
		this.map = map;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getMserial() {
		return mserial;
	}
	public void setMserial(int mserial) {
		this.mserial = mserial;
	}
	public String getRjuso() {
		return rjuso;
	}
	public void setRjuso(String rjuso) {
		this.rjuso = rjuso;
	}
	public int getSerial() {
		return serial;
	}
	public void setSerial(int serial) {
		this.serial = serial;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	
	public String getRholiday() {
		return rholiday;
	}
	public void setRholiday(String rholiday) {
		this.rholiday = rholiday;
	}
	public String getRbathroom() {
		return rbathroom;
	}
	public void setRbathroom(String rbathroom) {
		this.rbathroom = rbathroom;
	}
	public String getRdrink() {
		return rdrink;
	}
	public void setRdrink(String rdrink) {
		this.rdrink = rdrink;
	}
	public String getRfacilities() {
		return rfacilities;
	}
	public void setRfacilities(String rfacilities) {
		this.rfacilities = rfacilities;
	}
	public String getRaddress1() {
		return raddress1;
	}
	public void setRaddress1(String raddress1) {
		this.raddress1 = raddress1;
	}
	public String getRaddress2() {
		return raddress2;
	}
	public void setRaddress2(String raddress2) {
		this.raddress2 = raddress2;
	}
	public String getRdate() {
		return rdate;
	}
	public void setRdate(String rdate) {
		this.rdate = rdate;
	}
	public int getRhit() {
		return rhit;
	}
	public String getRphone() {
		return rphone;
	}
	public void setRphone(String rphone) {
		this.rphone = rphone;
	}
	public void setRtable(int rtable) {
		this.rtable = rtable;
	}
	public void setRhit(int rhit) {
		this.rhit = rhit;
	}
	public String getRpwd() {
		return rpwd;
	}
	public void setRpwd(String rpwd) {
		this.rpwd = rpwd;
	}
	
	public String getFindStr() {
		return findStr;
	}
	public void setFindStr(String findStr) {
		this.findStr = findStr;
	}
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public String[] getRmName() {
		return rmName;
	}
	public void setRmName(String[] rmName) {
		this.rmName = rmName;
	}
	public String[] getRmPrice() {
		return rmPrice;
	}
	public void setRmPrice(String[] rmPrice) {
		this.rmPrice = rmPrice;
	}
	public String[] getRmExplain() {
		return rmExplain;
	}
	public void setRmExplain(String[] rmExplain) {
		this.rmExplain = rmExplain;
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}

	public String getRmenus() {
		return rmenus;
	}
	public void setRmenus(String rmenus) {
		this.rmenus = rmenus;
	}
	public String getRinfo() {
		return rinfo;
	}
	public void setRinfo(String rinfo) {
		this.rinfo = rinfo;
	}
	public String getOrderBy() {
		return orderBy;
	}
	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public int getRtimeOpen() {
		return rtimeOpen;
	}
	public void setRtimeOpen(int rtimeOpen) {
		this.rtimeOpen = rtimeOpen;
	}
	public int getRtimeClose() {
		return rtimeClose;
	}
	public void setRtimeClose(int rtimeClose) {
		this.rtimeClose = rtimeClose;
	}
	public int getRtable() {
		return rtable;
	}
	
	
}
