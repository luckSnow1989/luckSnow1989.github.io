package com.yooli.cbs.api.consumer.front.common;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @Project: cbs-api
 * @Title: LogUtil
 * @Description:日志统一输出类
 * @author: xue.zhang
 * @date: 2018年9月10日上午11:31:58
 * @company: alibaba
 * @Copyright: Copyright (c) 2017
 * @version v1.0
 */
public final class LogUtil {
	
	private static final Logger logger = LoggerFactory.getLogger(LogUtil.class);
	
	public static void info(OperationLogDto operationLogDto) {
		logger.info(operationLogDto.toString());
	}
	
}
