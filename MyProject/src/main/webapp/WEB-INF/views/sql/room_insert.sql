DROP SEQUENCE ROOM_SEQ;
CREATE SEQUENCE ROOM_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE;
-- 회원 생성 

-- VALUES(방번호(PK), 방이름(UQ), 가격, 등급, 이미지파일 이름목록(,로 구분), 최대숙박인원, 방 사이즈
-- 방사이즈는 1,2,3,4,5의 등급을 두겠습니다. 5등급이 가장 큰 방이라고 가정하겠습니다.
-- 최대 숙박인원, 방 이름은 더 플라자 호텔의 것들을 참고, 모방했습니다.
-- 이미지파일은 준비가 되지 않았으니 NULL로 입력하였습니다. 
-- 추후에 SPRING을 통해 파일을 등록하면서 동시에 입력하는 것이 좋겠습니다.

-- 이미지파일은 추후 수정
INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '스위트 킹베드', 290000, 5, 'resources/images/room5/room5_1.PNG', 'resources/images/room5/rooms5/rooms5_1.PNG', 'resources/images/room5/rooms5/rooms5_2.PNG', 'resources/images/room5/rooms5/rooms5_3.PNG', 'resources/images/room5/rooms5/rooms5_4.PNG', 'resources/images/room5/rooms5/rooms5_5.PNG', 8, 5);
INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '스위트 트윈베드', 330000, 5, 'resources/images/room5/room5_2.PNG', 'resources/images/room5/rooms5/rooms5_1.PNG', 'resources/images/room5/rooms5/rooms5_2.PNG', 'resources/images/room5/rooms5/rooms5_3.PNG', 'resources/images/room5/rooms5/rooms5_4.PNG', 'resources/images/room5/rooms5/rooms5_5.PNG', 8, 5);
INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '스위트 럭셔리 킹베드', 350000, 5, 'resources/images/room5/room5_3.PNG', 'resources/images/room5/rooms5/rooms5_1.PNG', 'resources/images/room5/rooms5/rooms5_2.PNG', 'resources/images/room5/rooms5/rooms5_3.PNG', 'resources/images/room5/rooms5/rooms5_4.PNG', 'resources/images/room5/rooms5/rooms5_5.PNG', 8, 5);
INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '스위트 클럽룸', 300000, 5, 'resources/images/room5/room5_4.PNG', 'resources/images/room5/rooms5/rooms5_1.PNG', 'resources/images/room5/rooms5/rooms5_2.PNG', 'resources/images/room5/rooms5/rooms5_3.PNG', 'resources/images/room5/rooms5/rooms5_4.PNG', 'resources/images/room5/rooms5/rooms5_5.PNG', 8, 5);
INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '스위트 클럽 트윈', 320000, 5, 'resources/images/room5/room5_5.PNG', 'resources/images/room5/rooms5/rooms5_1.PNG', 'resources/images/room5/rooms5/rooms5_2.PNG', 'resources/images/room5/rooms5/rooms5_3.PNG', 'resources/images/room5/rooms5/rooms5_4.PNG', 'resources/images/room5/rooms5/rooms5_5.PNG', 8, 5);

COMMIT;


--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '디럭스 킹베드', 220000, 4, NULL, 8, 4);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '디럭스 트윈베드', 230000, 4, NULL, 8, 4);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '디럭스 스위트 킹베드', 4, 250000, NULL, 8, 4);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '디럭스 클럽룸', 240000, 4, NULL, 8, 4);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '디럭스 클럽 트윈', 250000, 4, NULL, 8, 4);

--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '슈페리어 킹베드', 190000, 3, NULL, 8, 3);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '슈페리어 트윈베드', 200000, 3, NULL, 8, 3);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '슈페리어 스위트 킹베드', 220000, 3, NULL, 8, 3);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '슈페리어 클럽룸', 210000, 3, NULL, 8, 3);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '슈페리어 클럽 트윈', 220000, 3, NULL, 8, 3);

--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '더블 플라자1', 190000, 2, NULL, 8, 2);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '더블 플라자2', 200000, 2, NULL, 8, 2);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '더블 플라자3', 220000, 2, NULL, 8, 2);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '더블 클럽룸1', 210000, 2, NULL, 8, 2);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '더블 클럽룸2', 220000, 2, NULL, 8, 2);

--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '싱글 플라자1', 190000, 1, NULL, 8, 1);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '싱글 플라자2', 200000, 1, NULL, 8, 1);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '싱글 플라자3', 220000, 1, NULL, 8, 1);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '싱글 클럽룸1', 210000, 1, NULL, 8, 1);
--INSERT INTO ROOM VALUES(ROOM_SEQ.NEXTVAL, '싱글 클럽룸2', 220000, 1, NULL, 8, 1);
