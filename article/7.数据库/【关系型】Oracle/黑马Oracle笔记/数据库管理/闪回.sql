һ�����ص�Ӧ�ó���
	1.����ɾ�����ݣ�����commit��
	2.����drop table��
	3.�����ñ��ϵ���ʷ��¼��
	4.��γ���һ���Ѿ��ύ��������
	
�������ص�����
	1.���ر�(flashback table)��������˵���ȥ��һ��ʱ����ϡ�
	2.����ɾ��(flashback drop)������oracle����վ
	3.���ذ汾��ѯ(flashback version query)�����ϵ���ʷ��¼
	4.���������ѯ(flashback transaction query)����ȡһ��undo_sql
	5.�������ݿ�()�������ݿ���˵���ȥ�ϵ�һ��ʱ����
	6.���ع鵵��־

�������صĺô�
	1.�ָ��У����ؼ����Ǹ����ԵĽ���
	2.��ͳ�Ļָ�������Ч�ʵͣ�������
		(1).�����������ݿ����һ�������ļ��Ļָ����������ָ������������
		(2).�����ݿ���־��ÿ���޸Ķ����뱻���
	3.�����ٶȿ�
		(1).ͨ���к�����Ѹı��������
		(2).�����ָ����ı������
	4.�������������
		(1).û�и��Ӽ��ֵĶಽ����
		
�ġ����ر�(flashback table)
	1.ʵ���Ͼ��ǽ����е����ݿ��ٵĻָ�����ȥ��һ�������ϵͳ�ı��SCN�ϡ�ʵ�ֱ�����أ���Ҫʹ��undo��Ϣ(������ռ���ص�undo)
		(1)����ʹ�ã�show parameter undo ,�˽������Ϣ��
		name				type		value
		------------------------------------
		undo_managent 		string		auto
		undo_retention		integer		900			--->������������ݱ�����ʱ��900s,15���ӣ�
													--->�޸ĵ����alter system set undo_retention=1200 scope=both;
		undo_tablespace		string		undotbs1
		(2)scope��ȡֵ,��ʾ�޸�֮�����õķ�Χ������ʱЧ
			memoery,�޸��ڴ��еģ������ݿ��������޸ĵ���Ϣ�ظ�
			spfile,�޸�ϵͳ�����ļ������ǲ���ֱ��ʹ�ã���������֮����Ч
			both,��������
	
		(3)ϵͳ�ı��SCN
			select to_char(sysdate ,'yyyy-mm-dd hh24:mi:ss:mm') ��ǰʱ��, timestamp_to_scn(sysdate) scn from dual;
			����һ��scn,��2234571��
			
	2.ִ�б�����أ���Ҫ�û���Ȩ��:flashback any table;
		ִ��sql����:grant flashback any table to scott;
	
	3.�﷨��(��Ҫ�������ƶ����ܣ�alter table ���� enable row movement);
		flashback table [�û���.]<table_name>
		to scn 2893625
	
	4.��λ����ò��������һ��ʱ���scn?
		
	
	������
		--1.������֮ǰ��ĳһ��ʱ�䣬���scn2893625
		select timestamp_to_scn(to_date('2016-07-06 21:10:00','yyyy-mm-dd hh24:mi:ss')) from dual;
		--2.�������ƶ�����
		alter table person enable row movement;
		--3.���ص�ĳ��ʱ��
		flashback table hr.person to scn 2893625;
  
	5.ע�⣺
		(1)���ͳ�����ݣ����ܱ�����
		(2)��ǰ�������ʹ����Ķ��󣬲��ᱻ����
		(3)ϵͳ���ܱ�����
		(4)���ܿ�Խddl����
		(5)�ᱻд�뾯����־
		(6)��������������������
  
  
�塢����ɾ��(flashback drop)��
	1.ע�⣺
		(1)����oracle����վ���ָ�ɾ���Ķ���
		(2)ֻ�ܶ���ͨ�û�������
		(3)����Ա��û�л���վ��
		
	2.��ʾ����վ����Ķ���show recyclebin
	  ��ջ���վ��purge recyclebin
	  ����ɾ����drop table ���� purge
		
	3.�ָ�ɾ����
		(1)flashback table ���� to before drop [rename to �±���];
		(2)flashback table '����վ�ڵı���' to before drop [rename to �±���];
  
  
�������ذ汾��ѯ(flashback version query)�����ϵ���ʷ��¼
	select id, name, versions_operation,versions_starttime,versions_endtime,versions_xid
	from PERSON
	versions between timestamp minvalue and maxvalue
  
�ߡ����������ѯ
	1.��ҪȨ�ޣ�select any transaction
	2.ͨ�����ذ汾��ѯ��ã�xid,����id
		select id, name, versions_operation,versions_starttime,versions_endtime,versions_xid
		from PERSON
		versions between timestamp minvalue and maxvalue
	�磺xid='0400215454545454'
	3.select operation,undo_sql from flashback_transcation_query where xid='';
	�õ���undo_sql�������Ƕ��sql,����ִ�У����ɳ�������
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
