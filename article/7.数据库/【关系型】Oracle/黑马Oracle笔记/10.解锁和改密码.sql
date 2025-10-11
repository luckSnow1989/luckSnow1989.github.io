1. 管理员登录
c:\>sqlplus sys/你的密码 as sysdba  (密码认证)
c:\>sqlplus / as sysdba             (主机认证  优先)


2. 解锁
SQL>alter user scott account unlock;

3. 改密码
SQL>alter user scott identified by 新密码;