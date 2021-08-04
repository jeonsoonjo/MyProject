package com.my.myproject.config;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.my.myproject.command.board.BoardListCommand;
import com.my.myproject.command.board.DeleteBoardCommand;
import com.my.myproject.command.board.InsertBoardCommand;
import com.my.myproject.command.board.SearchBoardCommand;
import com.my.myproject.command.board.SelectNoticeCommand;
import com.my.myproject.command.board.ShowBoardCommand;
import com.my.myproject.command.board.UpdateBoardCommand;
import com.my.myproject.command.board.UpdateBoardPageCommand;
import com.my.myproject.command.member.AdminLoginCommand;
import com.my.myproject.command.member.ChangePwCommand;
import com.my.myproject.command.member.EmailAuthCommand;
import com.my.myproject.command.member.EmailCheckCommand;
import com.my.myproject.command.member.FindIdCommand;
import com.my.myproject.command.member.FindPwCommand;
import com.my.myproject.command.member.IdCheckCommand;
import com.my.myproject.command.member.JoinCommand;
import com.my.myproject.command.member.LeaveCommand;
import com.my.myproject.command.member.LoginCommand;
import com.my.myproject.command.member.LogoutCommand;
import com.my.myproject.command.member.PresentPwCheckCommand;
import com.my.myproject.command.member.UpdateMemberCommand;
import com.my.myproject.command.member.UpdatePwCommand;
import com.my.myproject.command.reply.GetChildListCommand;
import com.my.myproject.command.reply.GetReplyListCommand;
import com.my.myproject.command.reply.InsertReReplyCommand;
import com.my.myproject.command.reply.InsertReplyCommand;
import com.my.myproject.command.reservation.CancelRevCommand;
import com.my.myproject.command.reservation.EmailRevCodeCommand;
import com.my.myproject.command.reservation.MyReservationCommand;
import com.my.myproject.command.reservation.NonMemberRevListCommand;
import com.my.myproject.command.reservation.ReceiptCommand;
import com.my.myproject.command.reservation.ReceiptCommand2;
import com.my.myproject.command.reservation.RevInfoCommand;
import com.my.myproject.command.reservation.SelectRemainingRoom;
import com.my.myproject.command.reservation.SelectRoomCommand;
import com.my.myproject.command.room.DownloadRoomServiceMenuCommand;
import com.my.myproject.command.room.SelectRoomListCommand;
import com.my.myproject.command.room.SelectRoomViewCommand;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Configuration
public class BeanConfiguration { 

	/* 이 아래부터는 커넥션풀과 관련된 bean 생성*/
	@Bean
	public HikariConfig hikariConfig() {
		HikariConfig hikariConfig = new HikariConfig();
		hikariConfig.setDriverClassName("oracle.jdbc.OracleDriver");
		hikariConfig.setJdbcUrl("jdbc:oracle:thin:@127.0.0.1:1521:xe");
		hikariConfig.setUsername("SERVER_USER");
		hikariConfig.setPassword("1111");
		return hikariConfig;
	}
	
	@Bean(destroyMethod="close")
	public HikariDataSource hikariDataSource() {
		return new HikariDataSource(hikariConfig());
	}
	
	@Bean
	public SqlSessionFactory sqlSessionFactory() throws Exception {
		SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
		sqlSessionFactory.setDataSource(hikariDataSource());
		sqlSessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath:com/my/myproject/dao/mapper/*.xml"));
		return sqlSessionFactory.getObject();
	}
	
	@Bean
	public SqlSessionTemplate sqlSession() throws Exception {
		return new SqlSessionTemplate(sqlSessionFactory());
	}    
	
	/* Board 관련 */
	@Bean
	public InsertBoardCommand InsertBoardCommand() {
		return new InsertBoardCommand();
	}
	@Bean
	public BoardListCommand boardListCommand() {
		return new BoardListCommand();
	}
	@Bean
	public SearchBoardCommand searchBoardCommand() {
		return new SearchBoardCommand();		
	}
	@Bean
	public SelectNoticeCommand selectInformCommand() {
		return new SelectNoticeCommand();
	}
	@Bean
	public ShowBoardCommand showBoardCommand() {
		return new ShowBoardCommand();
	}
	@Bean
	public UpdateBoardPageCommand UpdateBoardPageCommand() {
		return new UpdateBoardPageCommand();
	}
	@Bean
	public UpdateBoardCommand updateBoardCommand() {
		return new UpdateBoardCommand();
	}
	@Bean
	public DeleteBoardCommand deleteBoardCommand() {
		return new DeleteBoardCommand();
	}
	
	/* Reply 관련 */
	@Bean
	public InsertReplyCommand insertReplyCommand() {
		return new InsertReplyCommand();
	}
	@Bean
	public GetReplyListCommand getReplyListCommand() {
		return new GetReplyListCommand();
	}
	@Bean
	public GetChildListCommand getChildListCommand() {
		return new GetChildListCommand();
	}
	@Bean
	public InsertReReplyCommand insertReReplyCommand() {
		return new InsertReReplyCommand();
	}
	
	/* member 관련 */
	@Bean
	public LoginCommand loginCommand() { // 로그인
		return new LoginCommand();
	}
	@Bean
	public LogoutCommand logoutCommand(){ // 로그아웃
		return new LogoutCommand();
	}
	@Bean
	public IdCheckCommand idCheckCommand() { // 아이디 체크
		return new IdCheckCommand();
	}
	@Bean
	public EmailCheckCommand emailCheckCommand() { // 이메일 체크
		return new EmailCheckCommand();
	}
	@Bean
	public EmailAuthCommand emailAuthCommand() { // 이메일 인증
		return new EmailAuthCommand();
	}
	@Bean
	public JoinCommand joinCommand() { // 회원가입
		return new JoinCommand();
	}
	@Bean
	public PresentPwCheckCommand presentPwCheckCommand(){ // 현재 비밀번호 확인
		return new PresentPwCheckCommand();
	}
	@Bean
	public UpdatePwCommand updatePwCommand(){ // 비밀번호 변경
		return new UpdatePwCommand();
	}
	@Bean
	public UpdateMemberCommand updateMemberCommand(){ // 회원정보 변경
		return new UpdateMemberCommand();
	}
	@Bean
	public FindIdCommand findIdCommand(){ // 아이디 찾기
		return new FindIdCommand();
	}
	@Bean
	public FindPwCommand findPwCommand(){ // 비밀번호 찾기
		return new FindPwCommand();
	}
	@Bean
	public ChangePwCommand changePwCommand(){ // 비밀번호 찾기&변경
		return new ChangePwCommand();
	}
	@Bean
	public LeaveCommand leaveCommand(){ // 회원탈퇴
		return new LeaveCommand();
	}
	@Bean
	public AdminLoginCommand adminLoginCommand() { // 관리자 로그인
		return new AdminLoginCommand();
	}
	
	/* reservation 관련 */ 
	@Bean
	public SelectRemainingRoom selectRemainingRoom() {
		return new SelectRemainingRoom();
	}

	@Bean
	public SelectRoomCommand selectRoomCommand() {
		return new SelectRoomCommand();
	}

	@Bean
	public ReceiptCommand receiptCommand() {
		return new ReceiptCommand();
	}
	@Bean
	public RevInfoCommand revInfoCommand() {
		return new RevInfoCommand();
	}
	@Bean
	public ReceiptCommand2 receiptCommand2() {
		return new ReceiptCommand2();
	}
	
	@Bean
	public MyReservationCommand myReservationCommand() {
		return new MyReservationCommand();
	}
	@Bean
	public CancelRevCommand cancelRevCommand() {
		return new CancelRevCommand();
	}
	@Bean
	public EmailRevCodeCommand emailRevCodeCommand() {
		return new EmailRevCodeCommand();
	}
	@Bean
	public NonMemberRevListCommand nonMemberRevListCommand() {
		return new NonMemberRevListCommand();
	}
	/* Room 관련*/
	@Bean
	public SelectRoomListCommand selectRoomListCommand() {
		return new SelectRoomListCommand();
	}
	
	@Bean
	public SelectRoomViewCommand selectRoomViewCommand() {
		return new SelectRoomViewCommand();
	}
	
	@Bean
	public DownloadRoomServiceMenuCommand downloadRoomServiceMenuCommand() {
		return new DownloadRoomServiceMenuCommand();
	}
	
}
