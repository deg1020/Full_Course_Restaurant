package restaurant;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.imgscalr.Scalr;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.FinalFactory;





public class RestaurantDao {
	int size=1024*1024*10;					// 업로드할 용량 사이즈를 10MB로 지정
	String encode = "utf-8";				// 인코딩 형식을 utf-8로 지정
	String sDirectory = "C:/Users/이동환/workspace/FinalProject/WebContent/restaurant/download/";	
	// 사진 저장 경로
	String sDirectory2 = "C:\\Users\\이동환\\workspace\\FinalProject\\WebContent\\restaurant\\download\\";
	// 절대 경로
	String thumbPath = "C:/Users/이동환/workspace/FinalProject/WebContent/restaurant/thumbnail/";
	// 섬네일 저장 경로
	
	SqlSession ss;			// sql문을 호출해주는 객체 			 
	
	//페이지 분리와 관련된 변수들
	
	int listSize 	= 6;	// 한 페이지에서 보여줄 데이터 갯수
	int blockSize 	= 4;	// 한 페이지에서 보여줄 블록 갯수
	int totSize 	= 0;	// 검색된 전체 데이터 갯수 
	int totPage 	= 0;	// 검색된 전체 페이지 수	=Math.ceil(totSize/listSize)
	int totBlock 	= 0;	// 검색된 전체 블록 수	=Math.ceil(totPage/blockSize)
	int nowPage 	= 1;	// 현재 페이지 번호
	int nowBlock 	= 1;	// 현재 몇 번째 블록인지 =Math.ceil(nowPage/blockSize)
	int startPage	= 1;	// 한 블록의 시작할 페이지 번호	=endPage-blockSize +1
	int endPage		= 0;	// 한 블록의 마지막 페이지 번호	=blockSize*nowBlock
	int startNo 	= 1;	// 현재 페이지의 데이터 시작 번호 =endNo - listSize +1
	int endNo		= 0;	// 현재 페이지의 데이터 마지막 번호 =nowPage*listSize
		
	
	public RestaurantDao() {			
		ss = FinalFactory.getFactory().openSession();		// 객체가 생성되면 db 연결
	}
	
	
	/*음식점 등록 페이지 */
	
	public void insert(HttpServletRequest req) {	// 입력페이지 입력버튼 누르면 실행되는 메소드
		RestaurantVo rvo = new RestaurantVo();		// 음식점 정보 객체 생성
		rvo.setMsg("성공적으로 등록되었습니다.");			// 처리 결과 메시지 설정
		try {
			MultipartRequest multi = new MultipartRequest(req, sDirectory, size, encode, new DefaultFileRenamePolicy());
			// 전송할 파일명을 가지고 있는 객체, 서버상의 절대경로, 최대 업로드될 파일 크기, 인코딩 방식, 중복파일처리
			if(multi.getParameter("serial") != null) {		// multi 객체에 PK인 serial이 있으면
				rvo.setSerial(Integer.parseInt(multi.getParameter("serial")));
				// serial을 정수형으로 캐스팅한 후에 rvo객체의 serial에 저장
			}
			rvo.setRname(multi.getParameter("rname"));			// Rname = 음식점 이름
			rvo.setFindStr(multi.getParameter("findStr"));		// FindStr = 검색어
			rvo.setMid(multi.getParameter("mid"));				// Mid = 회원 테이블과 연결해주는 FK
			
			/*사진 첨부 파일 부분*/
			
			
			Map<String, String> map = new HashMap<String, String>();	
			// 음식점 사진 파일 담을 map
			Enumeration<String> e = multi.getFileNames();			
			// Enumeration 인터페이스는 객체들의 집합(Vector)에서 각각의 객체들을 한순간에 하나씩 처리할 수 있는 메소드를 제공하는 켈렉션이다.
			// multi객체에서 전송 받은 파일 이름을 가져와서 e에 저장
			while(e.hasMoreElements()) {						// Enumeration에서 객체를 한개씩 꺼내옴
				String tag = (String)e.nextElement();			// Enumeration 내의 다음 요소를 반환값을 tag에 저장
				String value = multi.getOriginalFileName(tag);	// multi객체에서 파일 원래 이름을 value에 저장
				if(value == null) continue;						// 파일이 없으면 while문 종료
				String key = multi.getFilesystemName(tag);		// multi객체에서 저장된 파일 이름을 key에 저장
				
				/* 섬네일  */
				
				if(tag.equals("rphoto_main") && key!=null){		
					// 음식점 메인 사진과 파일 이름이 존재하면 ( 음식점 메인사진만 섬네일을 만듬 )	
					BufferedImage srcImg = ImageIO.read(new File(sDirectory2 + key));
					// srcImg 에 사진 파일을 저장

		            // 썸네일 크기 입니다.
		            int dw = 400, dh = 300;
		            int ow = srcImg.getWidth();		// 사진 크기 변경 전 넓이 
		            int oh = srcImg.getHeight();	// 사진 크기 변경 전 높이

		            // 늘어날 길이를 계산하여 패딩합니다.
		            int pd = 0;
		            if (ow > oh) {					// 가로 사진이면
		            	pd = (int) (Math.abs((dh * ow / (double) dw) - oh) / 2d);	
		            	// Math.abs는 양수 음수 관계없이 절대값만 반환하는 메소드
		            } else {						// 세로 사진이면
		                pd = (int) (Math.abs((dw * oh / (double) dh) - ow) / 2d);
		            }

		            // 이미지 크기가 변경되었으므로 다시 구합니다.
		            ow = srcImg.getWidth();			
		            oh = srcImg.getHeight();

		            // 썸네일 비율로 크롭할 크기를 구합니다.
		            int nw = ow;				// 사진 크기 변경 후 넓이
		            int nh = (ow * dh) / dw;	// 변경후 넓이 * 300 / 400
		            if (nh > oh) {				// nh가 크기 변경 후 사진의 높이 보다 크면 
		               nw = (oh * dw) / dh;		// 넓이 = ( 변경 후 높이 * 400 ) / 300
		               nh = oh;					// 높이 = 변경 후 높이 그대로
		            }

		            // 늘려진 이미지의 중앙을 썸네일 비율로 크롭 합니다.
		            BufferedImage cropImg = Scalr.crop(srcImg, (ow - nw) / 2, (oh - nh) / 2, nw, nh);

		            // 리사이즈(썸네일 생성)
		            BufferedImage destImg = Scalr.resize(cropImg, dw, dh);

		            String thumbName = thumbPath + "thumb_" + key;	// 경로와 사진 이름을 합쳐서 thumbName으로 저장
		            File thumbFile = new File(thumbName);			// 파일 객체 생성
		            ImageIO.write(destImg, "png", thumbFile);		// 입력할 이미지, 이미지 형식, 저장 경로 + 이름
		            System.gc();									// 가비지 콜렉터 호출
		        }
		            
		        if(value == null) continue;							// 파일이 없으면 while문 종료
				map.put(key, tag);									// 맵에 파일 이름이랑 태그 이름 저장
				
			}
			rvo.setMap(map);										// 사진들의 태그 이름과 파일명이 들어있는 맵
			rvo.setRmName(multi.getParameterValues("rmName"));		// 메뉴 이름
			rvo.setRmExplain(multi.getParameterValues("rmExplain"));// 메뉴 설명
			rvo.setRmPrice(multi.getParameterValues("rmPrice"));	// 메뉴 가격
			
			/*가게 상세 설명*/
			
			rvo.setRtimeOpen(Integer.parseInt(multi.getParameter("rtimeOpen")));	// 음식점 오픈 시간
			rvo.setRtimeClose(Integer.parseInt(multi.getParameter("rtimeClose")));	// 음식점 마감 시간
			rvo.setRholiday(multi.getParameter("rholiday"));						// 음식점 휴일
			rvo.setRbathroom(multi.getParameter("rbathroom"));						// 음식점 화장실
			rvo.setRdrink(multi.getParameter("rdrink"));							// 음식점 주류,음료
			rvo.setRfacilities(multi.getParameter("rfacilities"));					// 음식점 시설
			rvo.setRmenus(multi.getParameter("rmenus"));							// 음식점 대표 메뉴들
			rvo.setRinfo(multi.getParameter("rinfo"));								// 음식점 간단한 소개
			rvo.setRtable(Integer.parseInt(multi.getParameter("rtable")));			// 테이블 수 ( 예약을 위해 정수형 타입으로 지정 )
			rvo.setRphone(multi.getParameter("rphone"));							// 음식점 전화번호
			
			/*지도와 주소 부분*/
			String address = multi.getParameter("rjuso");							// 음식점 전체 주소
			
			// 지도 자동 검색을 위한 주소 분리
			rvo.setRaddress1(multi.getParameter("raddress1"));						// 음식점 주소(시/도)
			rvo.setRaddress2(multi.getParameter("raddress2"));						// 음식점 주소(군/구)
			rvo.setRjuso(multi.getParameter("rjuso"));								// 나머지 주소
			
			int r = ss.insert("restaurant.insert", rvo);		// 음식점 정보 입력하는 쿼리
			if(r<1){
				rvo.setMsg("맛집 등록 중 오류 발생");					// 쿼리 입력 오류 발생 시 메시지 설정
				ss.rollback();									// 쿼리문 취소
			}	
				ss.commit();									// 오류 없을 시에 쿼리문 확정
			for(int i =0; i<rvo.getRmName().length;i++) {			// 메뉴 갯수 만큼
				RestaurantMenuVo rmvo =new RestaurantMenuVo();		// 메뉴 객체 생성
				rmvo.setRmName(rvo.getRmName()[i]);					// rvo에 있는 메뉴 이름 rmvo에 저장
				rmvo.setRmExplain(rvo.getRmExplain()[i]);			// rvo에 있는 메뉴 설명 rmvo에 저장
				rmvo.setRmPrice(rvo.getRmPrice()[i]);				// rvo에 있는 메뉴 가격 rmvo에 저장
				int r2=ss.insert("restaurant.insert2",rmvo);		// 메뉴 정보 db에 저장하는 쿼리
				if(r2<1){											// 입력 오류 발생 시
					rvo.setMsg("메뉴저장중 오류 발생");					// 메시지 설정
					ss.rollback();									// 쿼리문 취소
				}
				ss.commit();										// 문제 없을 시에 쿼리문 확정
			}
			
		}catch(Exception ex) {										// 음식점 등록 중에 예외 발생 시
			ex.printStackTrace();									// 문제 출력
			rvo.setMsg("exception 예외 발생");							// 메시지 설정
			ss.rollback();											// 쿼리문 취소
		}
	}
	
	
	
	/*음식점 목록 List 페이지 */
	
	public void pageCompute(String findStr){ //try문장 안에서 함수 호출해야함
		totSize = ss.selectOne("restaurant.page", findStr);		// 검색한 결과 총 갯수 불러오는 쿼리
		
		totPage = (int)Math.ceil(totSize/(double)listSize);		// 전체 페이지 수 
		totBlock = (int)Math.ceil(totPage/(double)blockSize);	// 전체 블럭 수 (페이지 몇개당 한블럭)
		
		nowBlock = (int)Math.ceil(nowPage/(double)blockSize);	// 현재 몇 번째 블럭인지
		
		endPage = blockSize * nowBlock;			// 현재 블럭의 마지막 페이지 번호
		startPage = endPage - blockSize + 1;	// 현재 블럭의 시작 페이지 번호
		
		if(endPage > totPage) endPage = totPage;	// 마지막 블럭의 마지막페이지가 전체 페이지수 보다 크면 보정

		endNo = nowPage * listSize;		// 선택한 페이지에서 보여지는 데이터의 마지막 번호
		startNo = endNo - listSize + 1;	// 선택한 페이지에서 보여지는 데이터의 첫번째 번호

		if(endNo > totSize) endNo = totSize; 
		// jstl을 사용하지 않을경우 공백이 나타나기 때문에 보정해야함
		
	}
	
	
	public List<RestaurantVo> select(RestaurantVo vo){				// 목록페이지 누르면 실행되는 메소드
		List<RestaurantVo> list = new ArrayList<RestaurantVo>();	// RestaurantVo 타입의 list 생성
		
		nowPage = vo.getNowPage();			// 매개변수로 전달 받은 vo에서 현재 페이지 번호를 가져와서 nowPage에 저장
		pageCompute(vo.getFindStr());		// 검색어로 페이지 분리 메서드 호출
			
		vo.setStartNo(startNo);				// 페이지에 나타낼 데이터 시작 번호 vo에 저장
		vo.setEndNo(endNo);					// 페이지에 나타낼 데이터 끝 번호 vo에 저장
		
		if(vo.getOrderBy().equals("조회순")) {				// vo객체의 orderby가 조회순이면
			list = ss.selectList("restaurant.select3", vo);	// 데이터를 조회순으로 정렬한 쿼리문 실행 결과를 list에 저장 		
		}else if(vo.getOrderBy().equals("등록순")) {			// vo객체의 orderby가 등록순이면 (초기값은 등록순)
			list = ss.selectList("restaurant.select4", vo);	// 데이터를 등록순으로 정렬한 쿼리문 실행 결과를 list에 저장
		}
		return list;										// list 전달
	}
	
	public List<RestaurantPhotoVo> sel(List<RestaurantVo> list){			// 메인사진을 컨트롤러에 전달해주는 메소드				
		//리스트에서 여러개의 serial을 꺼내서 rvo에 담을 방법 생각하기
		List<RestaurantPhotoVo> photoList = new ArrayList<RestaurantPhotoVo>(); // PhotoVo타입의 list 생성	
		
		for(int i=0; i<list.size(); i++) {									// 해당 음식점의 모든사진 갯수 만큼
			RestaurantPhotoVo rpvo = new RestaurantPhotoVo(); 				// 사진 저장할 객체 생성
			rpvo = ss.selectOne("restaurant.sel", list.get(i).getSerial()); 
			// 매개변수의 serial로 음식점 메인사진 파일명과 Pserial을 가져와서 rpvo에 저장
			photoList.add(rpvo);
			// rpvo를 list에 저장
		}

		return photoList;		// list를 반환
	}


	
	
	
	
	/*상세보기 View 페이지*/
	
	public RestaurantVo view(RestaurantVo vo) {			// 목록페이지에서 음식점을 클릭하면 실행되는 메소드
		RestaurantVo rvo = ss.selectOne("restaurant.view", vo.getSerial());	
		// 선택한 음식점의 serial로 db에서 음식점의 모든 정보를 가져온다음 rvo에 저장 
		ss.update("updateHitCnt", vo.getSerial());		// 조회수 1을 증가시키는 쿼리
		ss.commit();									// 쿼리문 확정
		return rvo;										// rvo 반환
	}
	
	public List<String> photoView(RestaurantVo vo) {	// 메인사진
		List<String> photoList 							// serial로 db에 있는 메인사진 이름을 가져와서 photoList에 저장
				= ss.selectList("restaurant.photoView",vo.getSerial());
		return photoList;								// photoList 반환
	}
	
	public List<String> photoView3(RestaurantVo vo) {	// 서브사진1~5
		List<String> photoList2 						// serial로 db에 있는 서브사진1~5 이름을 가져와서 photoList2에 저장
				= ss.selectList("restaurant.photoView2",vo.getSerial());
	
		return photoList2;								// photoList2 반환
	}
	
	public List<String> photoView2(RestaurantVo vo){	// 메뉴 사진
		List<RestaurantPhotoVo> rmAttFileList = new ArrayList<RestaurantPhotoVo>();	
		// 메뉴 사진 이름 담을 RestaurantPhoto타입의 rmAttFileList 객체 생성
		rmAttFileList = ss.selectList("restaurant.photoView3", vo.getSerial());
		// serial로 db에 있는 메뉴 사진 이름들을 가져와서 rmAttFileList에 저장
		Map<String,String> map =new HashMap<String,String>();
		// 태그 이름과 파일 이름을 담을 map 생성
		
		for(int i=0;i<rmAttFileList.size();i++) {				// 메뉴 사진 갯수 만큼
			String key = rmAttFileList.get(i).getTagName();		// 태그 이름을 key에 저장
			String value = rmAttFileList.get(i).getRmAttFile();	// 파일 이름을 value에 저장
			map.put(key, value);								// key와 value를 map에 저장
		}
		
		List<String> list = new ArrayList<String>();	// 메뉴 사진과 태그 이름에 맞게 반환해줄 list 생성
		for(int i=0; i<map.size(); i++) {				// map안의 데이터 갯수 만큼		
			String temp=map.get("rmAttFile"+i);			// 메뉴사진0번 = rmAttFile0 으로 갯수만큼 저장
			list.add(i, temp);							// 리스트 i번째에 rmAttFile(i) 번째 파일 이름 저장
		}
		
		return list;									// list 반환
	}
	
	public List<RestaurantMenuVo> menuView(RestaurantVo vo){	// 음식점 메뉴 정보 가져오는 메소드
		List<RestaurantMenuVo> menuList 						
				= ss.selectList("restaurant.menuView", vo.getSerial());
		// 메뉴 마다 이름, 설명, 가격이 저장된 list를 담을 menuList 
		return menuList;
	}
	
	
	
	
	
	
	/* 음식점 수정 페이지 */
	
	public RestaurantVo modifyReady(RestaurantVo vo) {	// 수정할 음식점 정보 가져오는 메소드		
		RestaurantVo rvo = ss.selectOne("restaurant.view", vo.getSerial());	
		// 수정버튼 누를시 해당 serial로 db에서 음식점 정보를 가져온다음 rvo에 저장
		return rvo;
	}

	
	/* 수정페이지에서 수정완료 버튼 누른 다음 실행 될 메소드 */
	
	public void modify(HttpServletRequest req){		// servlet에서 보내온 정보를 취득하기 위해서는 httpServletRquest를 사용한다
		RestaurantVo rvo = new RestaurantVo();		// db에 저장할 음식점 정보 담을 객체 생성
		rvo.setMsg("성공적으로 등록되었습니다.");			// 처리 결과 메시지 설정
		
		try {
			MultipartRequest multi = new MultipartRequest(	
					req, 							// 전송할 파일명 가지고 있는 객체 
					sDirectory,						// 저장 경로
					size, 							// 파일 최대 크기 
					encode, 						// 인코딩 방식
					new DefaultFileRenamePolicy()	// 파일 이름 자동 재설정 메소드
					);
			
			if(multi.getParameter("serial") != null) {		// serial 값이 존재하면
				rvo.setSerial(Integer.parseInt(multi.getParameter("serial")));	// rvo에 serial(음식점 고유번호) 저장
			}
			rvo.setRname(multi.getParameter("rname"));		// 음식점 이름 rvo에 저장 
			rvo.setFindStr(multi.getParameter("findStr"));	// 검색어 rvo에 저장 ( 검색어 유지를 위해서 )
			rvo.setMid(multi.getParameter("mid"));			// 회원 아이디를 rvo 저장
			
			
			
			/* 음식점 메뉴 정보 */
			rvo.setRmName(multi.getParameterValues("rmName"));			// 메뉴 이름 rvo에 저장
			rvo.setRmExplain(multi.getParameterValues("rmExplain"));	// 메뉴 설명 rvo에 저장
			rvo.setRmPrice(multi.getParameterValues("rmPrice"));		// 메뉴 가격 rvo에 저장
			
			/*가게 상세 설명*/
			rvo.setRtimeOpen(Integer.parseInt(multi.getParameter("rtimeOpen")));	// 오픈시간 rvo에 저장
			rvo.setRtimeClose(Integer.parseInt(multi.getParameter("rtimeClose")));	// 마감시간 rvo에 저장
			rvo.setRholiday(multi.getParameter("rholiday"));						// 휴일 rvo에 저장
			rvo.setRbathroom(multi.getParameter("rbathroom"));						// 화장실정보 rvo에 저장
			rvo.setRdrink(multi.getParameter("rdrink"));							// 주류정보 rvo에 저장
			rvo.setRfacilities(multi.getParameter("rfacilities"));					// 시설정보 rvo에 저장
			rvo.setRmenus(multi.getParameter("rmenus"));							// 대표메뉴정보 rvo에 저장
			rvo.setRinfo(multi.getParameter("rinfo"));								// 음식점 설명 rvo에 저장
			
			if(multi.getParameter("rhit") != null){								// 조회수가 존재하면
				rvo.setRhit(Integer.parseInt(multi.getParameter("rhit")));		// 조회수 rvo에 저장
			}
			if(multi.getParameter("rtable")!=null){								// 테이블 수가 존재하면
				rvo.setRtable(Integer.parseInt(multi.getParameter("rtable")));	// 테이블 수 rvo에 저장
			}
			
			rvo.setRphone(multi.getParameter("rphone"));			// 전화번호 rvo에 저장
			rvo.setRaddress1(multi.getParameter("raddress1"));		// 주소(시/도) rvo에 저장
			rvo.setRaddress2(multi.getParameter("raddress2"));		// 주소(군/구) rvo에 저장
			rvo.setRjuso(multi.getParameter("rjuso"));				// 나머지 주소 rvo에 저장
	
			/*메뉴 지우는 쿼리 */
			// 원래 입력되어있던 메뉴가 없으면 오류
			ss.delete("restaurant.modifyDelete", rvo.getSerial());	
			// serial에 해당하는 메뉴 이름, 가격, 설명 지우는 쿼리
			ss.commit();
			

			// 음식점 정보 업데이트 하는 쿼리
			int r2 = ss.update("restaurant.rvoModify", rvo);
			if(r2<1) rvo.setMsg("맛집 수정 후 등록 중 오류 발생");
			ss.commit();
			
			// 새로 입력된 메뉴로 변경하는 부분
			if(rvo.getRmName() != null) {							// 메뉴가 새로 추가되었으면			
				for(int i =0; i<rvo.getRmName().length;i++) {		// 메뉴 갯수 만큼
					RestaurantMenuVo rmvo =new RestaurantMenuVo();	// 메뉴 이름, 설명, 가격 저장할 객체 생성
					rmvo.setRmName(rvo.getRmName()[i]);				// 메뉴 이름 rmvo에 저장
					rmvo.setRmExplain(rvo.getRmExplain()[i]);		// 메뉴 설명 rmvo에 저장
					rmvo.setRmPrice(rvo.getRmPrice()[i]);			// 메뉴 가격 rmvo에 저장
					rmvo.setPserial(rvo.getSerial());				// 음식점 번호 rmvo의 pserial에 저장
					int r3=ss.insert("restaurant.modifyInsert",rmvo);	// 메뉴 테이블에 메뉴 이름,설명,가격 입력
					if(r3<1){											// 오류발생시
						rvo.setMsg("메뉴저장중 오류 발생");					// 메시지 설정
						ss.rollback();									// 쿼리문 취소
					}
					ss.commit();										// 쿼리문 확정
				}
			}
			
			/*사진 첨부 파일 부분*/
			Enumeration<String> e = multi.getFileNames();		
			// Enumeration 인터페이스는 객체들의 집합(Vector)에서 각각의 객체들을 
			// 한순간에 하나씩 처리할 수 있는 메소드를 제공하는 켈렉션 
			while(e.hasMoreElements()) {							// e에 들어있는 객체를 하나씩 꺼내는 반복문
				RestaurantPhotoVo rpvo = new RestaurantPhotoVo();	// 사진 저장 객체 생성
				String tag = (String)e.nextElement();				// 태그 이름
				String value = multi.getOriginalFileName(tag);		// 파일 업로드 이름
				if(value == null) continue;							// 파일이 없으면 반복문 종료
				String key = multi.getFilesystemName(tag);			// 파일 저장 이름
				
					
				// 수정할 음식점 사진 파일, 태그 이름 담을 map
				rpvo.setPserial(rvo.getSerial());	// 음식점 고유번호 rpvo에 저장
				rpvo.setTagName(tag);				// 태그 이름 rpvo에 저장
				rpvo.setRmAttFile(key);				// 사진 이름 rpvo에 저장
				
				
				// 기존 사진 파일을 삭제하기 위해서 파일 이름을 가져오는 쿼리 부분
				// 파라미터 : pserial, tag 이름 
				RestaurantPhotoVo deletePhoto = new RestaurantPhotoVo();	// 지울 사진을 담을 객체
				
				// 원래 메뉴에 사진을 변경 하는 경우 
				try {
					deletePhoto = ss.selectOne("restaurant.photoFileDelete2", rpvo); 
					// rpvo에 들어있는 pserial, 태그 이름으로 	사진 이름, serial 가져오는 쿼리
					
					// 기존 사진 이름을 가져와서 restaurant 폴더에 있는 기존 사진 삭제
					String delFile = deletePhoto.getRmAttFile();	 // 삭제할 파일 이름	
					File file = new File(sDirectory + delFile);		 // 경로+파일이름으로 file 생성
					if(file.exists()) file.delete();				 // 해당 파일이 존재하면 삭제
					
					// 기존 사진 tagName과 pserial로 데이터베이스에서 삭제
					int r5 =ss.delete("restaurant.modifyDelete3", rpvo); 
					// rpvo에 저장된 pserial과 tagName에 해당하는 사진 데이터를 db에서 삭제하는 쿼리 
					if(r5<1) rvo.setMsg("맛집 메뉴 정보 삭제 중 오류 발생");
					
					// 태그 이름과 시리얼로 테이블 데이터 업데이트하기
					rpvo.setPserial(rvo.getSerial());
					rpvo.setTagName(tag);
					rpvo.setRmAttFile(key);
					
					// 기존에 있던 메뉴에 새로운 사진으로 수정하는 쿼리
					int r4=ss.update("restaurant.modifyUpdate2", rpvo);
					if(r4<1)rvo.setMsg("사진 수정 중 오류 발생");
					ss.commit();
					
				}catch(Exception ex1) {
					// 원래 메뉴를 지우지 않고 메뉴를 더 추가하는 경우
					int r6 = ss.insert("restaurant.modifyInsert3", rpvo);
					if(r6<1) rvo.setMsg("새로운 메뉴 사진 입력 중 오류 발생 ");
					ex1.printStackTrace();
				}
				
				
				
				
				
				if(tag.equals("rphoto_main") && key!=null){
		           BufferedImage srcImg = ImageIO.read(new File(sDirectory2 + key));

		            // 썸네일 크기 입니다.
		            int dw = 400, dh = 300;
		            int ow = srcImg.getWidth();
		            int oh = srcImg.getHeight();

		            // 늘어날 길이를 계산하여 패딩합니다.
		            int pd = 0;
		            if (ow > oh) {
		               pd = (int) (Math.abs((dh * ow / (double) dw) - oh) / 2d);
		            } else {
		               pd = (int) (Math.abs((dw * oh / (double) dh) - ow) / 2d);
		            }

		            // 이미지 크기가 변경되었으므로 다시 구합니다.
		            ow = srcImg.getWidth();
		            oh = srcImg.getHeight();

		            // 썸네일 비율로 크롭할 크기를 구합니다.
		            int nw = ow;
		            int nh = (ow * dh) / dw;
		            if (nh > oh) {
		               nw = (oh * dw) / dh;
		               nh = oh;
		            }

		            // 늘려진 이미지의 중앙을 썸네일 비율로 크롭 합니다.
		            BufferedImage cropImg = Scalr.crop(srcImg, (ow - nw) / 2, (oh - nh) / 2, nw, nh);

		            // 리사이즈(썸네일 생성)
		            BufferedImage destImg = Scalr.resize(cropImg, dw, dh);

		            String thumbName = thumbPath + "thumb_" + key;
		            File thumbFile = new File(thumbName);
		            ImageIO.write(destImg, "png", thumbFile);
		            System.gc();
		        }
		            
		        if(value == null) continue;
				
			}
		
			
			
		}catch(Exception ex) {
			ex.printStackTrace();
			rvo.setMsg("exception 예외 발생");
			ss.rollback();
		}

	}
	
	
	
	public RestaurantVo delete(RestaurantVo vo){
		RestaurantVo rvo = new RestaurantVo();
		
		List<RestaurantPhotoVo> deletePhotoList = new ArrayList<RestaurantPhotoVo>(); 
		deletePhotoList = ss.selectList("restaurant.photoFileDelete", rvo.getSerial());
						
		
		int r = ss.delete("restaurant.modifyDelete", vo.getSerial());
		if(r<1) rvo.setMsg("맛집 메뉴 정보 삭제 중 오류 발생");
		
		int r1 = ss.delete("restaurant.modifyDelete2", vo.getSerial());
		if(r1<1) rvo.setMsg("맛집 사진 삭제 중 오류 발생1");
		
		int r2 = ss.delete("restaurant.delete", vo.getSerial());
		if(r2<1) rvo.setMsg("음식점 정보 삭제 중 오류 발생");
		ss.commit();
		
		return rvo;
	}


	public int getListSize() {
		return listSize;
	}


	public void setListSize(int listSize) {
		this.listSize = listSize;
	}


	public int getBlockSize() {
		return blockSize;
	}


	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}


	public int getTotSize() {
		return totSize;
	}


	public void setTotSize(int totSize) {
		this.totSize = totSize;
	}


	public int getTotPage() {
		return totPage;
	}


	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}


	public int getTotBlock() {
		return totBlock;
	}


	public void setTotBlock(int totBlock) {
		this.totBlock = totBlock;
	}


	public int getNowPage() {
		return nowPage;
	}


	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}


	public int getNowBlock() {
		return nowBlock;
	}


	public void setNowBlock(int nowBlock) {
		this.nowBlock = nowBlock;
	}


	public int getStartPage() {
		return startPage;
	}


	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}


	public int getEndPage() {
		return endPage;
	}


	public void setEndPage(int endPage) {
		this.endPage = endPage;
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
	
	
	
	
	
}



