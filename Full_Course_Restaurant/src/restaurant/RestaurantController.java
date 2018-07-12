package restaurant;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class RestaurantController {
	RestaurantDao dao;			// RestaurantDao 타입의 dao 객체 생성
	
	
	public RestaurantController(RestaurantDao dao) {	// dao를 매개변수로 생성자 생성
		this.dao = dao;									// 매개변수로 받은 dao를 이 클래스의 dao에 입력
	}
	
	@RequestMapping(value="/insertR.donghwan")	// 맛집 등록시 결과로 목록 페이지로 이동		
												// url 요청 값이 insertR.donghwan 이면 밑에 함수 실행
	public void insertR(HttpServletRequest req, HttpServletResponse resp){	
		// HttpServletRequest는 클라이언트의 요청과 관련된 정보와 동작을 가지고 있는 객체
		// HttpServletResponse는 응답할 Client에 대한 정보와 동작을 가지고 있는 객체

		dao.insert(req);		//dao객체의 insert메서드를 호출
		PrintWriter pw;			//PrinterWriter클래스는 기본 데이터형이나 객체를 쓰기 위한 클래스이다
		try {
			pw = resp.getWriter();							// resp객체의 html형식의 응답을 pw객체에 저장
			pw.println("<script>alert");					// pw스트림에 스크립트를 여는 텍스트  기록
			pw.println("location.href='list.donghwan';");	// url을 list.donghwan으로 요청하는 텍스트를 기록
			pw.println("</script>");						// pw스트림에 스크립트를 닫는 텍스트 기록
			pw.flush();										// 스트림에 기록(저장)된 정보를 씀
		} catch (IOException e) {					// 예외 발생시
			// TODO Auto-generated catch block
			e.printStackTrace();					// 에러 메시지의 발생 근원지를 찾아서 단계별로 에러를 출력한다
		}	
	}
	
	@RequestMapping(value="/insert.donghwan")	// 맛집 등록 버튼 누를시에 입력 페이지로 이동
												// url 요청값이 insert.donghwan이면 밑에 함수 실행
	public ModelAndView insert(RestaurantVo vo){	
		ModelAndView mv = new ModelAndView();	
		// ModelAndView클래스는 컨트롤러의 처리 결과를 보여 줄 뷰와 뷰에 전달할 값을 저장하는 용도
		mv.setViewName("insert");		// mv객체의 이름을 insert로 설정
		
		return mv;						// 함수를 호출한 곳에 mv객체를 반환
	}
	
	@RequestMapping(value="/list.donghwan")		// 홈페이지에서 맛집 카테고리를 누르면 목록페이지로 이동	
												// url 요청값이 list.donghwan이면 밑에 함수 실행
	public ModelAndView list(RestaurantVo vo){	
		ModelAndView mv = new ModelAndView();	// 컨트롤러의 처리 결과를 보여줄 뷰와 뷰에 전달할 값을 저장하는 용도
		List<RestaurantVo> list = dao.select(vo);	
		// dao객체의 select 메서드를 실행하고 그 결과값을 list에 저장
		// select 메서드는 페이지 분리 기능, 정렬 기능, 맛집 목록 데이터를 가져오는 기능을 한다.
		List<RestaurantPhotoVo> photoList = dao.sel(list);
		// dao객체의 sel 메서드를 실행하고 그 결과값을 photoList에 저장
		// sel 메서드는 조회 페이지의 맛집들의 메인 사진들을 가져오는 기능을 한다.
		
		if(photoList != null){			// photoList가 null이 아니면
			for(int i=0; i<photoList.size(); i++) {		// photolist에 사진이 들어있는 만큼
				list.get(i).setRmAttFile(photoList.get(i).getRmAttFile());
				// photolist에 담긴 맛집 메인사진 이름을 list에 담음
				list.get(i).setPserial(photoList.get(i).getPserial());
				// photolist에 담긴 가게의 PK를 list에 담음
				// 하나의 객체로 묶어주는 것이 사용할 때 편리
			}
		}
		
		mv.addObject("dao", dao);		// 페이지 분리 기능을 위한 dao
		mv.addObject("list", list);		// 맛집 정보, 사진 등이 담겨 있는 리스트
		mv.setViewName("list");			// 뷰 이름을 list로 지정
		
		return mv;						// mv 반환
	}
	
	@RequestMapping(value="/view.donghwan")			// 목록페이지에서 맛집 한 곳을 클릭한 경우 상세보기 페이지로 이동
													// url 요청 값이 view.donghwan이면 밑에 메소드를 실행
	public ModelAndView view(RestaurantVo vo){	
		ModelAndView mv = new ModelAndView();		// 컨트롤러 처리 결과를 보여줄 뷰와 뷰에 전달할 값을 저장하는 객체
		mv.setViewName("view");						// 뷰 이름을 view로 지정
		RestaurantVo rvo = dao.view(vo);			// dao객체의 view 메서드 호출 후 반환 값을 rvo에 저장
		List<String> rphotoList = dao.photoView(vo);		// 맛집 메인 사진 이름 가져오기
		List<String> menuPhotoList = dao.photoView2(vo);	// 맛집 서브 사진1~5 이름 가져오기
		List<String> rphotoList2 = dao.photoView3(vo);		// 맛집 메뉴 사진 가져오기
		List<RestaurantMenuVo> menuList = dao.menuView(vo);	// 메뉴 이름, 가격, 설명 가져오기
		
		mv.addObject("rvo", rvo);							// 음식점 전체 정보
		mv.addObject("rphotoList", rphotoList);				// 음식점 메인
		mv.addObject("rphotoList2", rphotoList2);			// 음식점 서브
		mv.addObject("menuList", menuList);					// 음식점 메뉴 정보
		mv.addObject("menuPhotoList", menuPhotoList);		// 음식점 메뉴 사진
		// mv객체에 음식점 정보, 메인사진, 서브사진, 메뉴정보, 메뉴사진 객체를 추가
		
		return mv;			// mv 반환
	}
	
	@RequestMapping(value="/modify.donghwan")		// 상세보기 페이지에서 자신의 글을 수정 버튼 누를시에 수정페이지로 이동
													// url 요청 값이 modify.donghwan이면 밑에 메소드를 실행
	public ModelAndView modify(RestaurantVo vo){	
		ModelAndView mv = new ModelAndView();		// 컨트롤러 처리 결과 뷰, 뷰에 전달할 저장값 저장하는 객체
		
		RestaurantVo rvo = dao.modifyReady(vo);				// 수정할 음식점의 저장된 정보를 불러오는 메서드
		List<String> rphotoList = dao.photoView(vo);		// 수정할 음식점의 메인 사진 이름 가져오기
		List<String> menuPhotoList = dao.photoView2(vo);	// 수정할 음식점의 서브 사진1~5 이름 가져오기
		List<String> rphotoList2 = dao.photoView3(vo);		// 수정할 음식점의 메뉴 사진 이름 가져오기
		List<RestaurantMenuVo> menuList = dao.menuView(vo);	// 수정할 읏믹점의 메뉴 정보 가져오기
		
		mv.addObject("rvo", rvo);						// 음식점 전체 정보 뷰에 저장
		mv.addObject("rphotoList", rphotoList);			// 음식점 메인	뷰에 저장
		mv.addObject("rphotoList2", rphotoList2);		// 음식점 서브	뷰에 저장
		mv.addObject("menuList", menuList);				// 음식점 메뉴 정보 뷰에 저장
		mv.addObject("menuPhotoList", menuPhotoList);	// 음식점 메뉴 사진 뷰에 저장
		
		
		mv.setViewName("modify");						// 뷰 이름을 modify로 지정

		return mv;										
	}
	
	@RequestMapping(value="/modifyR.donghwan")		// 수정페이지에서 수정 버튼을 누를경우 변경된 내용이 저장되고 목록페이지로 이동
													// url 요청값이 modifyR.donghwan일 경우 메서드 실행
	public void modifyR(HttpServletRequest req, HttpServletResponse resp){
		dao.modify(req);									// 수정한 음식점의 정보를 저장해주는 메소드
		
		PrintWriter pw;										//PrinterWriter클래스는 기본 데이터형이나 객체를 쓰기 위한 클래스이다
		try {												
			pw = resp.getWriter();							// resp객체의 html형식의 응답을 pw객체에 저장
			pw.println("<script>alert");					// pw에 스크립트를 열고 alert을 텍스트로 기록
			pw.println("location.href='list.donghwan';");	// pw에 목록페이지로 이동하는 url을 텍스트로 기록
			pw.println("</script>");						// pw에 스크립트를 닫는 텍스트를 기록
			pw.flush();										// pw에 기록된 내용을 씀(실행)
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	
	@RequestMapping(value="/delete.donghwan")		// 상세보기 페이지에서 삭제 버튼을 누를 경우
													// url 요청값이 delete.donghwan일 경우 메소드 실행
	public ModelAndView delete(RestaurantVo vo){
		ModelAndView mv = new ModelAndView();		// 컨트롤러 처리 결과로 보여줄 뷰와 뷰에 전달할 저장값을 저장하는 객체
		RestaurantVo rvo = dao.delete(vo);			// 삭제할 음식점의 삭제와 결과를 알려주는 메소드
		
		mv.addObject("rvo", rvo);					// rvo를 뷰에 전달
		mv.setViewName("delete");					// 뷰 이름을 delte로 저장
		return mv;
	}
	
	
}
