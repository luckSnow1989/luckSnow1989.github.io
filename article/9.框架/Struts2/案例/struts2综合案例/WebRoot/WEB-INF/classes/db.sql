create database struts;
use struts;
create table user(
	id varchar(100) primary key,
	username varchar(100) not null unique,
	nick varchar(100),
	password varchar(100),
	sex varchar(10),#0 Ů 1��
	birthday date,
	education varchar(100),#�о��� ���� ר��
	telephone varchar(100),
	hobby varchar(100),#����,����,�Է�
	path varchar(100),#�ϴ��ļ������·��
	filename varchar(100),#uuid_oldfilename.jpeg
	remark varchar(255)
);