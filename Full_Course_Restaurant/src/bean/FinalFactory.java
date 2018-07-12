package bean;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class FinalFactory {
	private static SqlSessionFactory factory;	
	// 애플리케이션을 실행하는 동안 재빌드 하지않고 존재해야하므로 Static으로 생성 

	static{
		try {
			Reader reader = Resources.getResourceAsReader("mybatis_config.xml");	
			//Reader 클래스는 Character 단위의 입력을 대표하는 최상위 추상 클래스이다
			//mybatis_config.xml에는 연결할 데이터베이스 환경 내용이 들어있다

			factory = new SqlSessionFactoryBuilder().build(reader); // reader안의 내용으로 factory 생성
		} catch (IOException e) {		// 예외 발생 시
			e.printStackTrace();		// 에러 메시지의 발생 근원지를 찾아서 단계별로 에러를 출력한다. 
		}
	}
	
	public static SqlSessionFactory getFactory() {	// dao에서 사용하기 위해 getter 생성
		return factory;
	}
}
