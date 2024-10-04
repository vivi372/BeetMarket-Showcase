
CREATE OR REPLACE PROCEDURE manage_cart AS
BEGIN
    -- 장바구니 항목 삭제
    DELETE FROM basket
    WHERE writeDate+30 < SYSDATE;
    --포인트샵 장바구니 삭제(하루마다 삭제)
    DELETE FROM pointshopbasket
    WHERE writeDate+1 < SYSDATE;    
    --구매 확정(30일 마다)
    update orders set orderstate = '구매확정'
    where orderNo = 
    (select orderNo from orders where orderDate+30<sysdate and orderstate not in('구매확정','취소요청','환불요청','요청처리'));
    --구매 확정 포인트 지급
    insert into pointList(pointlist_no,point_entity , point_delta ,id)
    select point_seq.nextval pointlist_no,'주문 구매 확정' point_entity,point_delta,id from (
        select orderPrice*(goodssaverate+sale_rate)/100 point_delta,id from(
                select o.orderPrice,o.id ,(
                    select goodssaverate from goods where goodsNo=o.goodsNo
                ) goodssaverate,(
                     select s.sale_rate from membership s,member m where m.id=o.id and m.shipno = s.shipno
                ) sale_rate 
                from orders o where orderNo in
            (select orderNo from orders where orderDate + 30<sysdate and (not orderstate='구매확정' or not orderstate='취소요청' or not orderstate='환불요청' or not orderstate='요청처리'))
        )
    );
    COMMIT;
END; -- 스케줄러 실행시 동작할 프로시저 생성
/
BEGIN
    DBMS_SCHEDULER.create_job(
        job_name        => 'manage_cart_job', --잡 이름(마음대로)
        job_type        => 'PLSQL_BLOCK', -- 고정
        job_action      => 'BEGIN manage_cart; END;', --  BEGIN 위에 생성한 프로시저 이름; END;
        start_date      => SYSTIMESTAMP, --시작 시간(지금 부터)
        repeat_interval => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0', -- 실행 주기(매일매일 마다 실행)
        enabled         => TRUE -- 고정
    );
END;
/
BEGIN
    DBMS_SCHEDULER.drop_job(job_name => 'manage_cart_job'); -- 스케줄러 삭제
END;
/
SELECT JOB_NAME, SCHEDULE_TYPE, START_DATE, REPEAT_INTERVAL, LAST_START_DATE, NEXT_RUN_DATE, ENABLED
FROM USER_SCHEDULER_JOBS;
