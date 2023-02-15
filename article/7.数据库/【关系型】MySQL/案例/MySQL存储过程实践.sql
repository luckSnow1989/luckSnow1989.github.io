-- 一般选择使用存储过程，大多是由于程序出现问题，用于修复数据 、某些程序不方便处理、 程序实现成本大、 可能正常项目的运行周期内只会运行一次、也可能是使用SQL执行效率低，锁表时间长，影响线上效率等
-- 我们可以选择存储过程。

-- 案例一、 
-- 	查询YL_KX_LOAN_INFO_bak和YL_KX_REPAY_INFO_bak表组合生成新数据，插入到YL_OVERDUECASE_OTHER_INFO。
-- 	每次执行100条
-- 	适用场景： 数据量较小的情况下
DELIMITER $$ -- 这个是用来表示plsql程序的开始
DROP PROCEDURE IF EXISTS `YL_OVERDUECASE_OTHER_INFO_INSERT`$$ -- 删除旧的存储过程

CREATE DEFINER=`root`@`localhost` PROCEDURE `YL_OVERDUECASE_OTHER_INFO_INSERT`()
BEGIN
	DECLARE v_re INT;
	DECLARE rownum INT;
	SET v_re=0;
	outer_label:  BEGIN
	WHILE v_re >= 0 DO
		INSERT INTO YL_OVERDUECASE_OTHER_INFO(LOAN_NO, PRODUCT_NAME, MONTH_REPAYMENT) 
		(SELECT yl.`LOAN_NO`,yl.`PRODUCT_NAME`,yr.`MONTH_REPAYMENT` FROM YL_KX_LOAN_INFO_bak  yl INNER JOIN YL_KX_REPAY_INFO_bak yr ON yl.`LOAN_NO`=yr.`LOAN_NO` LIMIT v_re, 100) ;
		SELECT ROW_COUNT() INTO rownum;
		SET v_re = v_re + 100;
		IF (rownum <=0) THEN
			LEAVE  outer_label;
		END IF;
	END WHILE;
	END outer_label; 
END$$
DELIMITER ;


-- 案例二、 
-- 	查询YL_KX_LOAN_INFO_bak和YL_KX_REPAY_INFO_bak表组合生成新数据，插入到YL_OVERDUECASE_OTHER_INFO。
-- 	每次执行100条
-- 	适用场景： 数据量很大的情况下（前提是id的值必须的连续的）
BEGIN
	DECLARE minid BIGINT (20);
	DECLARE maxid BIGINT (20);
	DECLARE rnum INT;

	SET minid=0;
	SET maxid=5000;	
	SET rnum=1;
	
	WHILE rnum > 0 DO
	
		INSERT INTO YL_OVERDUECASE_OTHER_INFO(LOAN_NO, PRODUCT_NAME, MONTH_REPAYMENT) 
		(
			SELECT yl.`LOAN_NO`,yl.`PRODUCT_NAME`,yr.`MONTH_REPAYMENT` 
			FROM YL_KX_LOAN_INFO  yl INNER JOIN YL_KX_REPAY_INFO yr 
			ON yl.`LOAN_NO`=yr.`LOAN_NO` 
			WHERE yl.ID>=minid AND yl.ID<maxid
		) ; 
		
		SET minid=minid+5000;
		SET maxid=maxid+5000;	

		SELECT ROW_COUNT() INTO rnum;
	END WHILE; 
END



-- 案例三、
-- 数据迁移，插入后删除原始数据
BEGIN

	DECLARE minid BIGINT (20);
	DECLARE maxid BIGINT (20);

	SELECT min(id),	max(id) INTO minid,	maxid
	FROM	(
			SELECT id FROM elite_current_product_account
			WHERE	STATUS = 0 
			AND activate_end_date < DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%Y-%m-%d 00:00:00')
			AND id != 1
			ORDER BY id
			LIMIT 10000
		) t;


	WHILE minid IS NOT NULL
	AND maxid IS NOT NULL DO
		INSERT LOW_PRIORITY INTO elite_current_product_account_history 
		SELECT * FROM	elite_current_product_account
		WHERE	id BETWEEN minid AND maxid
		AND STATUS = 0
		AND activate_end_date < DATE_FORMAT(DATE_SUB(NOW(),INTERVAL 1 MONTH),'%Y-%m-%d 00:00:00')
		AND id != 1;

		DELETE LOW_PRIORITY FROM elite_current_product_account
		WHERE	id BETWEEN minid AND maxid
		AND STATUS = 0
		AND activate_end_date < DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%Y-%m-%d 00:00:00')
		AND id != 1;

		SELECT min(id),	max(id) INTO minid,	maxid
		FROM	(
				SELECT id FROM elite_current_product_account
				WHERE	STATUS = 0 
				AND activate_end_date < DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 1 MONTH),'%Y-%m-%d 00:00:00')
				AND id != 1
				ORDER BY id
				LIMIT 1000
			) t;
	END WHILE;
END

-- 案例四、
-- 大量update线上数据
BEGIN
    declare v_re int;
    SET v_re=1;
    WHILE v_re > 0
    DO
    update YL_MESSAGE_TEMPLATE set DATA_SOURCE='PHKX' where DATA_SOURCE='' limit 2000; -- 一次修改2000条
    SELECT ROW_COUNT() INTO v_re;
    END WHILE;
END




