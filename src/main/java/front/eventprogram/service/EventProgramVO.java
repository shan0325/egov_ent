package front.eventprogram.service;



import lombok.Data;


@Data
public class EventProgramVO {

	private Long id; // 아이디
	private String gubun; // 프로그램 구분코드(교육, 행사)
	private String title; // 프로그램명
	private String content; // 내용
	private String startDate; // 프로그램 시작일시
	private String endDate; // 프로그램 종료일시
	private String reqStartDate; // 접수 시작일시
	private String reqEndDate; // 접수 종료일시
	private Integer reqMaxPersonNumber; // 신청최대인원수
	private Integer reqtimeMaxPersonNumber; // 신청시받을최대인원수
	private String host; // 주최
	private String location; // 위치
	private String tel; // 문의처
	private String targetPerson; // 대상자
	private String useYn; // 사용유무
	private String regUserId; // 등록자 아이디
	private String regDate; // 등록일시
	private String modDate; // 수정일시
	private String mainImgAtchFileId; // 메인이미지 파일 아이디
	private String atchFileId; // 첨부파일 파일 아이디
	
}
