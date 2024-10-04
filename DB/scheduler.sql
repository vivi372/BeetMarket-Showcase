
CREATE OR REPLACE PROCEDURE manage_cart AS
BEGIN
    -- ��ٱ��� �׸� ����
    DELETE FROM basket
    WHERE writeDate+30 < SYSDATE;
    --����Ʈ�� ��ٱ��� ����(�Ϸ縶�� ����)
    DELETE FROM pointshopbasket
    WHERE writeDate+1 < SYSDATE;    
    --���� Ȯ��(30�� ����)
    update orders set orderstate = '����Ȯ��'
    where orderNo = 
    (select orderNo from orders where orderDate+30<sysdate and orderstate not in('����Ȯ��','��ҿ�û','ȯ�ҿ�û','��ûó��'));
    --���� Ȯ�� ����Ʈ ����
    insert into pointList(pointlist_no,point_entity , point_delta ,id)
    select point_seq.nextval pointlist_no,'�ֹ� ���� Ȯ��' point_entity,point_delta,id from (
        select orderPrice*(goodssaverate+sale_rate)/100 point_delta,id from(
                select o.orderPrice,o.id ,(
                    select goodssaverate from goods where goodsNo=o.goodsNo
                ) goodssaverate,(
                     select s.sale_rate from membership s,member m where m.id=o.id and m.shipno = s.shipno
                ) sale_rate 
                from orders o where orderNo in
            (select orderNo from orders where orderDate + 30<sysdate and (not orderstate='����Ȯ��' or not orderstate='��ҿ�û' or not orderstate='ȯ�ҿ�û' or not orderstate='��ûó��'))
        )
    );
    COMMIT;
END; -- �����ٷ� ����� ������ ���ν��� ����
/
BEGIN
    DBMS_SCHEDULER.create_job(
        job_name        => 'manage_cart_job', --�� �̸�(�������)
        job_type        => 'PLSQL_BLOCK', -- ����
        job_action      => 'BEGIN manage_cart; END;', --  BEGIN ���� ������ ���ν��� �̸�; END;
        start_date      => SYSTIMESTAMP, --���� �ð�(���� ����)
        repeat_interval => 'FREQ=DAILY; BYHOUR=0; BYMINUTE=0; BYSECOND=0', -- ���� �ֱ�(���ϸ��� ���� ����)
        enabled         => TRUE -- ����
    );
END;
/
BEGIN
    DBMS_SCHEDULER.drop_job(job_name => 'manage_cart_job'); -- �����ٷ� ����
END;
/
SELECT JOB_NAME, SCHEDULE_TYPE, START_DATE, REPEAT_INTERVAL, LAST_START_DATE, NEXT_RUN_DATE, ENABLED
FROM USER_SCHEDULER_JOBS;
