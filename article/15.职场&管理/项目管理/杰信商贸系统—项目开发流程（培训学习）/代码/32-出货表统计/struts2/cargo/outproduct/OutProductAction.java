package cn.itcast.web.struts2.cargo.outproduct;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFFooter;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.struts2.ServletActionContext;

import cn.itcast.entity.ContractProduct;
import cn.itcast.entity.ExtCproduct;
import cn.itcast.entity.dao.ContractDAO;
import cn.itcast.web.common.util.DownloadBaseAction;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.common.util.file.FileUtil;
import cn.itcast.web.common.util.file.PioUtil;
import cn.itcast.web.struts2._BaseStruts2Action;


public class OutProductAction extends _BaseStruts2Action {
	private String inputDate;
	
	public String getInputDate() {
		return inputDate;
	}

	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}

	public void print() throws Exception{
		ContractDAO oDao = (ContractDAO)this.getDao("daoContract");
//		List<ContractProduct> oList = oDao.find("from ContractProduct o where convert(varchar(10),o.contract.shipTime,126) like '"+inputDate+"%'");		//SQLServer
		List<ContractProduct> oList = oDao.find("from ContractProduct o where o.contract.shipTime like '"+inputDate+"%'");	//按船期过滤
		
		UtilFuns utilFuns = new UtilFuns();
		String rootPath = utilFuns.getROOTPath();
		
		String tempXlsFile = rootPath+"make/xlsprint/tOUTPRODUCT.xls";			//模板文件
		
		FileUtil fu = new FileUtil();
		String sPath = "/web/tmpfile/"+UtilFuns.sysDate()+"/";
		String sFile = fu.newFile(rootPath+sPath, "outproduct.xls");
		
		File dir = new File(rootPath+sPath);
		dir.mkdirs();	//创建多级目录
		
		String outFile = rootPath+sPath+sFile;
		
		PioUtil pioUtil = new PioUtil();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(tempXlsFile));
		HSSFFont songBoldFont16 = pioUtil.songBoldFont16(wb);		//设置字体
		HSSFFont defaultFont10 = pioUtil.defaultFont10(wb);			//设置字体

		HSSFSheet sheet = wb.getSheetAt(0);				//选择第一个工作簿
		//wb.setSheetName(0, "出货单");					//设置工作簿的名称
		
		//HSSFHeader header = sheet.getHeader();		//页眉
		HSSFFooter footer = sheet.getFooter();			//页脚
		
		wb.setRepeatingRowsAndColumns(0,1,8,0,1);		//将第一行作为标题，即每页都打印此行 sheetN,startCol,stopCol,startRow,stopRow
		
		//header.setCenter(inputDate.replace("-0", "-").replace("-", "年")+"月份出货表");
		//header.fontSize((short)16);
		
		footer.setRight("第"+HSSFFooter.page()+"页 共"+HSSFFooter.numPages()+"页     ");	//页数

		//sheet.setDefaultColumnWidth((short) 20); // 设置每列默认宽度
		
//		POI分页符有BUG，必须在模板文件中插入一个分页符，然后再此处删除预设的分页符；最后在下面重新设置分页符。
		sheet.setAutobreaks(false);
//		//int iRowBreaks[] = sheet.getRowBreaks();
//		sheet.removeRowBreak(3);
//		sheet.removeRowBreak(4);
//		sheet.removeRowBreak(5);
//		sheet.removeRowBreak(6);

		String extcproducts = "";
		HSSFRow nRow = null;
		HSSFCell nCell   = null;
		int curRow = 1;

		
		nRow = sheet.createRow((short)0);
		nRow.setHeightInPoints(36);
		
		nCell = nRow.createCell((short)(1));
		nCell.setCellValue(inputDate.replace("-0", "-").replace("-", "年")+"月份出货表");
		nCell.setCellStyle(this.title(wb, songBoldFont16));
		
		
		//list products
		ContractProduct cProduct = null;
		
		int colno = 1;
		int newLineNum = 1;			//换行符号的个数
		
		for(int i=0;i<oList.size();i++){
			cProduct = oList.get(i);
			
			newLineNum = 1;
			curRow++;
			colno = 1;
			nRow = sheet.createRow((short)curRow);
			nRow.setHeightInPoints(18);
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(cProduct.getContract().getCustomName());
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(cProduct.getContract().getContractNo());
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(cProduct.getProductNo());
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(String.valueOf(cProduct.getCnumber())+cProduct.getPackingUnit());
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(cProduct.getFactory().getFullName());
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			Iterator<ExtCproduct> it = cProduct.getExtCproduct().iterator();
			extcproducts = "";
			while(it.hasNext()){
				ExtCproduct eProduct = it.next();
				extcproducts += eProduct.getTypeName() + UtilFuns.newLine(); 
				newLineNum++;
			}
			extcproducts = UtilFuns.DelLastChar(extcproducts);
			if(extcproducts.equals("")){
				extcproducts = "无";
			}
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(extcproducts);
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			float height = pioUtil.getCellAutoHeight(extcproducts, 12f);
			nRow.setHeightInPoints(height);							//(一行字+行之间的间隙)*行数
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(UtilFuns.dateTimeFormat(cProduct.getContract().getDeliveryPeriod()));
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));				
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(UtilFuns.dateTimeFormat(cProduct.getContract().getShipTime()));
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));				
			
			nCell = nRow.createCell((short)(colno++));
			nCell.setCellValue(cProduct.getContract().getTradeTerms());
			nCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));				
		}
		
		
		//将第p1行到p2行向下移动p3行	实现删除 sheet.shiftRows(3,4,-1)删除第三行
		//sheet.shiftRows(3,4,-1);
		

		
		
		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();

		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(rootPath+sPath+sFile), sFile, response, true);
	}
	
	private HSSFCellStyle title(HSSFWorkbook wb, HSSFFont curFont){
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setWrapText(false);  						//换行   
		curStyle.setFont(curFont);
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		return curStyle;
	} 
	
	public String toedit(){
		return "pedit";
	}
	
}
