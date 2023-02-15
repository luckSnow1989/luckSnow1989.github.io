/*
��;����������ֻ������Ƿ���ȷ
���룺
s���ַ���
���أ�
���ͨ����֤����true,���򷵻�false


*/
function checkMobile(s){
var regu =/^[1][3][0-9]{9}$/;
var re = new RegExp(regu);
if (re.test(s)) {
        return true;
    }else{
       return false;
    }
}


/**
* �����������֤���Ƿ���ȷ
* ����:str  �ַ���
*  ����:true �� flase; true��ʾ��ʽ��ȷ
*/
function checkCard(str) {
    //15λ�����֤������ʽ
    var arg1 = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$/;
    //18λ�����֤������ʽ
    var arg2 = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[A-Z])$/;
    if (str.match(arg1) == null &amp;&amp; str.match(arg2) == null) {
        return false;
    }
    else {
        return true;
    }
}

/**
* ���������ַ��Ƿ���������ַ�
* ����:str  �ַ���
* ����:true �� flase; true��ʾ���������ַ�
* ��Ҫ����ע����Ϣ��ʱ����֤
*/
function checkQuote(str) {
    var items = new Array("~", "`", "!", "@", "#", "$", "%", "^", "&amp;", "*", "{", "}", "[", "]", "(", ")");
    items.push(":", ";", "'", "|", "\\", "&lt;", "&gt;", "?", "/", "&lt;&lt;", "&gt;&gt;", "||", "//");
    items.push("admin", "administrators", "administrator", "����Ա", "ϵͳ����Ա");
    items.push("select", "delete", "update", "insert", "create", "drop", "alter", "trancate");
    str = str.toLowerCase();
    for (var i = 0; i &lt; items.length; i++) {
        if (str.indexOf(items[i]) &gt;= 0) {
            return true;
        }
    }
    return false;
}

/**
* ��������URL��ַ�Ƿ���ȷ
* ����:str  �ַ���
*  ����:true �� flase; true��ʾ��ʽ��ȷ
*/
function checkURL(str) {
    if (str.match(/(http[s]?|ftp):\/\/[^\/\.]+?\..+\w$/i) == null) {
        return false
    }
    else {
        return true;
    }
}

/*
��;���������ĵ绰�����ʽ�Ƿ���ȷ
���룺
strPhone���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function checkPhone(strPhone) {
    var phoneRegWithArea = /^[0][1-9]{2,3}-[0-9]{5,10}$/;
    var phoneRegNoArea = /^[1-9]{1}[0-9]{5,8}$/;
    //var prompt = "������ĵ绰���벻��ȷ!"
    if (strPhone.length &gt; 9) {
        if (phoneRegWithArea.test(strPhone)) {
            return true;
        } else {
            //alert( prompt );
            return false;
        }
    } else {
        if (phoneRegNoArea.test(strPhone)) {
            return true;
        } else {
            //alert(prompt);
            return false;
        }

    }
}

/**��;��У��ip��ַ�ĸ�ʽ

���룺strIP��ip��ַ
���أ����ͨ����֤����true,���򷵻�false��
**/

function isIP(strIP) {
if (isNull(strIP)) return false;
var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/g //ƥ��IP��ַ��������ʽ
if(re.test(strIP))
{
if( RegExp.$1 &lt;256 &amp;&amp; RegExp.$2&lt;256 &amp;&amp; RegExp.$3&lt;256 &amp;&amp; RegExp.$4&lt;256) return true;
}
return false;
}
/*
��;����������ַ����Ƿ�Ϊ�ջ���ȫ�����ǿո�
���룺str
���أ�
���ȫ�ǿշ���true,���򷵻�false
*/
function isNull( str ){
if ( str == "" ) return true;
var regu = "^[ ]+$";
var re = new RegExp(regu);
return re.test(str);
}

/*
��;�������������ֵ�Ƿ����������ʽ
���룺str ������ַ���
���أ����ͨ����֤����true,���򷵻�false
*/
function isInteger( str ){
var regu = /^[-]{0,1}[0-9]{1,}$/;
return regu.test(str);
}


/*
��;����������ַ����Ƿ������������ʽ
���룺
s���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function isNumber( s ){
var regu = "^[0-9]+$";
var re = new RegExp(regu);
if (s.search(re) != -1) {
return true;
} else {
return false;
}
}
/*
��;����������ַ����Ƿ��Ǵ�С�������ָ�ʽ,�����Ǹ���
���룺
s���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function isDecimal( str ){
if(isInteger(str)) return true;
var re = /^[-]{0,1}(\d+)[\.]+(\d+)$/;
if (re.test(str)) {
if(RegExp.$1==0&amp;&amp;RegExp.$2==0) return false;
return true;
} else {
return false;
}
}
/*
��;�������������ֵ�Ƿ���϶˿ںŸ�ʽ
���룺str ������ַ���
���أ����ͨ����֤����true,���򷵻�false
*/
function isPort( str ){
return (isNumber(str) &amp;&amp; str&lt;65536);
}
/*
��;�������������ֵ�Ƿ����E-Mail��ʽ
���룺str ������ַ���
���أ����ͨ����֤����true,���򷵻�false
*/
function isEmail( str ){
var myReg = /^[-_A-Za-z0-9]+@([_A-Za-z0-9]+\.)+[A-Za-z0-9]{2,3}$/;
if(myReg.test(str)) return true;
return false;
}
/*
��;����������ַ����Ƿ���Ͻ���ʽ
��ʽ����Ϊ��С����������С����������λ
���룺
s���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function isMoney( s ){
var regu = "^[0-9]+[\.][0-9]{0,3}$";
var re = new RegExp(regu);
if (re.test(s)) {
return true;
} else {
return false;
}
}
/*
��;����������ַ����Ƿ�ֻ��Ӣ����ĸ�����ֺ��»������
���룺
s���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function isNumberOr_Letter( s ){//�ж��Ƿ������ֻ���ĸ
var regu = "^[0-9a-zA-Z\_]+$";
var re = new RegExp(regu);
if (re.test(s)) {
return true;
}else{
return false;
}
}
/*
��;����������ַ����Ƿ�ֻ��Ӣ����ĸ���������
���룺
s���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function isNumberOrLetter( s ){//�ж��Ƿ������ֻ���ĸ
var regu = "^[0-9a-zA-Z]+$";
var re = new RegExp(regu);
if (re.test(s)) {
return true;
}else{
return false;
}
}
/*
��;����������ַ����Ƿ�ֻ�ɺ��֡���ĸ���������
���룺
value���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function isChinaOrNumbOrLett( s ){//�ж��Ƿ��Ǻ��֡���ĸ���������
var regu = "^[0-9a-zA-Z\u4e00-\u9fa5]+$";
var re = new RegExp(regu);
if (re.test(s)) {
return true;
}else{
return false;
}
}
/*
��;���ж��Ƿ�������
���룺date�����ڣ�fmt�����ڸ�ʽ
���أ����ͨ����֤����true,���򷵻�false
*/
function isDate( date, fmt ) {
if (fmt==null) fmt="yyyyMMdd";
var yIndex = fmt.indexOf("yyyy");
if(yIndex==-1) return false;
var year = date.substring(yIndex,yIndex+4);
var mIndex = fmt.indexOf("MM");
if(mIndex==-1) return false;
var month = date.substring(mIndex,mIndex+2);
var dIndex = fmt.indexOf("dd");
if(dIndex==-1) return false;
var day = date.substring(dIndex,dIndex+2);
if(!isNumber(year)||year&gt;"2100" || year&lt; "1900") return false;
if(!isNumber(month)||month&gt;"12" || month&lt; "01") return false;
if(day&gt;getMaxDay(year,month) || day&lt; "01") return false;
return true;
}
function getMaxDay(year,month) {
if(month==4||month==6||month==9||month==11)
return "30";
if(month==2)
if(year%4==0&amp;&amp;year%100!=0 || year%400==0)
return "29";
else
return "28";
return "31";
}
/*
��;���ַ�1�Ƿ����ַ���2����
���룺str1���ַ�����str2�����������ַ���
���أ����ͨ����֤����true,���򷵻�false
*/
function isLastMatch(str1,str2)
{
var index = str1.lastIndexOf(str2);
if(str1.length==index+str2.length) return true;
return false;
}

/*
��;���ַ�1�Ƿ����ַ���2��ʼ
���룺str1���ַ�����str2�����������ַ���
���أ����ͨ����֤����true,���򷵻�false
*/
function isFirstMatch(str1,str2)
{
var index = str1.indexOf(str2);
if(index==0) return true;
return false;
}
/*
��;���ַ�1�ǰ����ַ���2
���룺str1���ַ�����str2�����������ַ���
���أ����ͨ����֤����true,���򷵻�false
*/
function isMatch(str1,str2)
{
var index = str1.indexOf(str2);
if(index==-1) return false;
return true;
}

/*
��;������������ֹ�����Ƿ���ȷ������Ϊ�������ڵĸ�ʽ��ȷ��
�ҽ�������&gt;=��ʼ����
���룺
startDate����ʼ���ڣ��ַ���
endDate���������ڣ��ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function checkTwoDate( startDate,endDate ) {
if( !isDate(startDate) ) {
alert("��ʼ���ڲ���ȷ!");
return false;
} else if( !isDate(endDate) ) {
alert("��ֹ���ڲ���ȷ!");
return false;
} else if( startDate &gt; endDate ) {
alert("��ʼ���ڲ��ܴ�����ֹ����!");
return false;
}
return true;
}
/*
��;����������Email�����ʽ�Ƿ���ȷ
���룺
strEmail���ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function checkEmail(strEmail) {
//var emailReg = /^[_a-z0-9]+@([_a-z0-9]+\.)+[a-z0-9]{2,3}$/;
var emailReg = /^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
if( emailReg.test(strEmail) ){
return true;
}else{
alert("�������Email��ַ��ʽ����ȷ��");
return false;
}
}


/*
��;����鸴ѡ��ѡ�е���Ŀ
���룺
checkboxID���ַ���
���أ�
���ظø�ѡ���б�ѡ�е���Ŀ
*/
function checkSelect( checkboxID ) {
var check = 0;
var i=0;
if( document.all(checkboxID).length &gt; 0 ) {
for( i=0; i&lt;document.all(checkboxID).length; i++ ) {
if( document.all(checkboxID).item( i ).checked ) {
check += 1;
}


}
}else{
if( document.all(checkboxID).checked )
check = 1;
}
return check;
}
function getTotalBytes(varField) {
if(varField == null)
return -1;
var totalCount = 0;
for (i = 0; i&lt; varField.value.length; i++) {
if (varField.value.charCodeAt(i) &gt; 127)
totalCount += 2;
else
totalCount++ ;
}
return totalCount;
}
function getFirstSelectedValue( checkboxID ){
var value = null;
var i=0;
if( document.all(checkboxID).length &gt; 0 ){
for( i=0; i&lt;document.all(checkboxID).length; i++ ){
if( document.all(checkboxID).item( i ).checked ){
value = document.all(checkboxID).item(i).value;
break;
}
}
} else {
if( document.all(checkboxID).checked )
value = document.all(checkboxID).value;
}
return value;
}

function getFirstSelectedIndex( checkboxID ){
var value = -2;
var i=0;
if( document.all(checkboxID).length &gt; 0 ){
for( i=0; i&lt;document.all(checkboxID).length; i++ ) {
if( document.all(checkboxID).item( i ).checked ) {
value = i;
break;
}
}
} else {
if( document.all(checkboxID).checked )
value = -1;
}
return value;
}
function selectAll( checkboxID,status ){
if( document.all(checkboxID) == null)
return;
if( document.all(checkboxID).length &gt; 0 ){
for( i=0; i&lt;document.all(checkboxID).length; i++ ){
document.all(checkboxID).item( i ).checked = status;
}
} else {
document.all(checkboxID).checked = status;
}
}
function selectInverse( checkboxID ) {
if( document.all(checkboxID) == null)
return;
if( document.all(checkboxID).length &gt; 0 ) {
for( i=0; i&lt;document.all(checkboxID).length; i++ ) {
document.all(checkboxID).item( i ).checked = !document.all(checkboxID).item( i ).checked;
}
} else {
document.all(checkboxID).checked = !document.all(checkboxID).checked;
}
}
function checkDate( value ) {
if(value=='') return true;
if(value.length!=8 || !isNumber(value)) return false;
var year = value.substring(0,4);
if(year&gt;"2100" || year&lt; "1900")
return false;
var month = value.substring(4,6);
if(month&gt;"12" || month&lt; "01") return false;
var day = value.substring(6,8);
if(day&gt;getMaxDay(year,month) || day&lt; "01") return false;
return true;
}
/*
��;������������ֹ�����Ƿ���ȷ������Ϊ�������ڵĸ�ʽ��ȷ��Ϊ��
�ҽ�������&gt;=��ʼ����
���룺
startDate����ʼ���ڣ��ַ���
endDate�� �������ڣ��ַ���
���أ�
���ͨ����֤����true,���򷵻�false
*/
function checkPeriod( startDate,endDate ) {
if( !checkDate(startDate) ) {
alert("��ʼ���ڲ���ȷ!");
return false;
} else if( !checkDate(endDate) ) {
alert("��ֹ���ڲ���ȷ!");
return false;
} else if( startDate &gt; endDate ) {
alert("��ʼ���ڲ��ܴ�����ֹ����!");
return false;
}
return true;
}
/*
��;�����֤ȯ�����Ƿ���ȷ
���룺
secCode:֤ȯ����
���أ�
���ͨ����֤����true,���򷵻�false
*/
function checkSecCode( secCode ) {
if( secCode.length !=6 ){
alert("֤ȯ���볤��Ӧ��Ϊ6λ");
return false;
}
if(!isNumber( secCode ) ){
alert("֤ȯ����ֻ�ܰ�������");

return false;
}
return true;
}
/****************************************************
function:cTrim(sInputString,iType)
description:�ַ���ȥ�ո�ĺ���
parameters:iType��1=ȥ���ַ�����ߵĿո�
2=ȥ���ַ�����ߵĿո�
0=ȥ���ַ�����ߺ��ұߵĿո�
return value:ȥ���ո���ַ���
****************************************************/
function cTrim(sInputString,iType)
{
var sTmpStr = ' ';
var i = -1;
if(iType == 0 || iType == 1)
{
while(sTmpStr == ' ')
{
++i;
sTmpStr = sInputString.substr(i,1);
}
sInputString = sInputString.substring(i);
}
if(iType == 0 || iType == 2)
{
sTmpStr = ' ';
i = sInputString.length;
while(sTmpStr == ' ')
{
--i;
sTmpStr = sInputString.substr(i,1);
}
sInputString = sInputString.substring(0,i+1);
}
return sInputString;
}
