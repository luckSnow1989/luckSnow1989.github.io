package com.webyun.orm.common.utils;

import org.springframework.beans.factory.config.PropertyPlaceholderConfigurer;

public class EncryptPropertyPlaceholderConfigurer extends PropertyPlaceholderConfigurer {
	
	@Override
    protected String convertProperty(String propertyName, String propertyValue) {
        if (isEncryptProperty(propertyName)) {
        	if(propertyName.equals("jdbc.password")){
        		System.out.println("可以对密码按照自己的规则进行加密解密");
        	}
            return Constants.databaseMap.get(propertyName);
        }
        return super.convertProperty(propertyName, propertyValue);
    }

    private boolean isEncryptProperty(String pname) {
        for (String name : Constants.DATABASE_PROPERTY_NAMES) {
            if (name.equals(pname)) {
                return true;
            }
        }
        return false;
    }
}
