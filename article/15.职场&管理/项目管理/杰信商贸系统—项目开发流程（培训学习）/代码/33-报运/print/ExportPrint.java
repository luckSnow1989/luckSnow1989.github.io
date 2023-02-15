package cn.itcast.web.print;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;

import cn.itcast.entity.Export;
import cn.itcast.entity.ExportProduct;
import cn.itcast.entity.ExtEproduct;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.web.common.util.Arith;
import cn.itcast.web.common.util.DownloadBaseAction;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.common.util.file.FileUtil;
import cn.itcast.web.common.util.file.PioUtil;


public class ExportPrint{

	public void print(HttpServletRequest request, HttpServletResponse response, ExportDAO oDao) throws Exception{
		String id = request.getParameter("id");
		Export obj = (Export)oDao.get(Export.class, id);
		
		UtilFuns utilFuns = new UtilFuns();
		String rootPath = utilFuns.getROOTPath();

		String tempXlsFile = rootPath+"make/xlsprint/tEXPORT.xls";
		
		FileUtil fu = new FileUtil();
		String sPath = "/web/tmpfile/"+UtilFuns.sysDate()+"/";
		String sFile = fu.newFile(rootPath+sPath, "export.xls");
		fu.makeDir(rootPath+sPath);
		
		String outFile = rootPath+sPath+sFile;
		
		PioUtil pioUtil = new PioUtil();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(tempXlsFile));
		HSSFFont defaultFont10 = pioUtil.defaultFont10(wb);		//设置字体
		HSSFFont defaultFont12 = pioUtil.defaultFont12(wb);		//设置字体

		HSSFSheet sheet = wb.getSheetAt(0);						//选择第一个工作簿
		wb.setSheetName(0, "报运单");							//设置工作簿的名称

		//sheet.setDefaultColumnWidth((short) 20); 				// 设置每列默认宽度
		
//		POI分页符有BUG，必须在模板文件中插入一个分页符，然后再此处删除预设的分页符；最后在下面重新设置分页符。
		sheet.setAutobreaks(false);
//		//int iRowBreaks[] = sheet.getRowBreaks();
//		sheet.removeRowBreak(3);
//		sheet.removeRowBreak(4);
//		sheet.removeRowBreak(5);
//		sheet.removeRowBreak(6);

		HSSFRow nRow = null;
		HSSFCell nCell   = null;
		int curRow = 2;
		
		//inputDate
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(9));
		nCell.setCellValue(UtilFuns.formatDateTimeCN(UtilFuns.dateTimeFormat(obj.getInputDate())));			//转中文日期格式
		nCell.setCellStyle(pioUtil.normalv12(wb, defaultFont12));
		
		curRow++;
		
		//customerContract
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(3));
		nCell.setCellValue(obj.getCustomerContract());
		nCell.setCellStyle(topStyle(wb));
		
		//lcno
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(11));
		nCell.setCellValue(obj.getLcno());
		nCell.setCellStyle(topStyle(wb));
		
		curRow++;
		
		//consignee
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(3));
		nCell.setCellValue(obj.getConsignee());
		nCell.setCellStyle(pioUtil.normalv12(wb, defaultFont12));
		
		//marks
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(16));
		nCell.setCellValue(obj.getMarks());
		nCell.setCellStyle(pioUtil.notet10(wb));
		
		//remark
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(18));
		nCell.setCellValue(obj.getRemark());
		nCell.setCellStyle(pioUtil.notet10(wb));
		
		curRow++;
		
		//shipmentPort
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(2));
		nCell.setCellValue(obj.getShipmentPort());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
		//destinationPort
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(4));
		nCell.setCellValue(obj.getDestinationPort());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
		//transportMode
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(7));
		nCell.setCellValue(obj.getTransportMode());
		nCell.setCellStyle(pioUtil.normalv12(wb, defaultFont12));
		
		//priceCondition
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(10));
		nCell.setCellValue(obj.getPriceCondition());
		nCell.setCellStyle(pioUtil.normalv12(wb, defaultFont12));
		
		curRow++;curRow++;
		
		//inputBy
		nRow = sheet.createRow((short)19);
		nRow.setHeightInPoints(24);
		
		nCell = nRow.createCell((short)(18));
//		nCell.setCellValue(request.this.getCurUser(request).getRealName());
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
		
		
		//step 2: copy sheet
		int rowCount = 11;		//每个sheet的子记录数
		int sheetCount = 0;
		int rowTotal = 1;		//合计列：只有最后一个sheet才合计，合计包括前面的sheet
		
		int rowStart = 8;		//开始行
		int rowStop = 18;		//结束行
		StringBuffer bufGrossWeight = new StringBuffer();
		StringBuffer bufNetWeight = new StringBuffer();
		StringBuffer bufSize = new StringBuffer();
		
		Arith arith = new Arith();			
		sheetCount = arith.round(obj.getExportProduct().size(), rowCount);		//sheet num
		//sheetCount = arith.round(obj.getExportProduct().size()*5, rowCount);	//test
		rowTotal = 18;															//每页统计位置在18行
		
		
		//拼接公式串
		bufGrossWeight.append("SUM(");
		bufNetWeight.append("SUM(");
		bufSize.append("SUM(");
		for(int j=0;j<sheetCount;j++){
			if(j==0){
				bufGrossWeight.append("SUMPRODUCT(报运单!I").append(rowStart).append(":I").append(rowStop).append(",报运单!H").append(rowStart).append(":H").append(rowStop).append("),");
				bufNetWeight.append("SUMPRODUCT(报运单!J").append(rowStart).append(":J").append(rowStop).append(",报运单!H").append(rowStart).append(":H").append(rowStop).append("),");
				bufSize.append("SUMPRODUCT(报运单!K").append(rowStart).append(":K").append(rowStop).append(",报运单!L").append(rowStart).append(":L").append(rowStop).append(",报运单!M").append(rowStart).append(":M").append(rowStop).append(",报运单!H").append(rowStart).append(":H").append(rowStop).append(")/100/100/100,");
			}else{
				wb.cloneSheet(0);				//复制sheet0工作簿,名字会自动重命名
				
				bufGrossWeight.append("SUMPRODUCT('报运单(").append(j).append(")'!I").append(rowStart).append(":I").append(rowStop).append(",'报运单(").append(j).append(")'!H").append(rowStart).append(":H").append(rowStop).append("),");
				bufNetWeight.append("SUMPRODUCT('报运单(").append(j).append(")'!J").append(rowStart).append(":J").append(rowStop).append(",'报运单(").append(j).append(")'!H").append(rowStart).append(":H").append(rowStop).append("),");
				bufSize.append("SUMPRODUCT('报运单(").append(j).append(")'!K").append(rowStart).append(":K").append(rowStop).append(",'报运单(").append(j).append(")'!L").append(rowStart).append(":L").append(rowStop).append(",'报运单(").append(j).append(")'!M").append(rowStart).append(":M").append(rowStop).append(",'报运单(").append(j).append(")'!H").append(rowStart).append(":H").append(rowStop).append(")/100/100/100,");
			}
		}
		bufGrossWeight.delete(bufGrossWeight.length()-1, bufGrossWeight.length());	//去掉最后的逗号
		bufNetWeight.delete(bufNetWeight.length()-1, bufNetWeight.length());		//去掉最后的逗号
		bufSize.delete(bufSize.length()-1, bufSize.length());						//去掉最后的逗号
		
		bufGrossWeight.append(")");
		bufNetWeight.append(")");
		bufSize.append(")");
		
		
		
		//step 3: list products
		HSSFRow cProductRow = null;
		HSSFCell cProductCell   = null;
		Region regionSize = null;
		int rnum = 0;									//当前行数
		int pnum = -1;									//当前页数
		int oldpnum = -1;								//之前页数
		boolean isNewPage = true;						//是否新的一页
		boolean isHasRow = false;						//是否有记录
		int colno = 1;

		//for(int x=0;x<5;x++){							//test
		Iterator<ExportProduct> it = obj.getExportProduct().iterator();
		while(it.hasNext()){
			isHasRow = true;
			pnum = rnum/rowCount;
			sheet = wb.getSheetAt(pnum);				//选择第n个工作簿	动态切换工作簿
			
			if(oldpnum!=pnum){
				isNewPage = true;
				oldpnum = pnum;
			}else{
				isNewPage = false;
			}
			if(isNewPage){
				curRow = rowStart;						//新的一页时，记录重新从开始行打印
			}else{
				curRow++;
			}
			rnum++;
			colno = 0;
			
			ExportProduct xProduct = it.next();
			cProductRow = sheet.createRow((short)curRow-1);
			cProductRow.setHeightInPoints(24);
			
			colno++;
			cProductCell   = cProductRow.createCell((short)(colno));
			cProductCell.setCellValue(xProduct.getProductNo());
			cProductCell.setCellStyle(leftStyle(wb));
			
			colno++;
			colno++;
			colno++;
			cProductCell   = cProductRow.createCell((short)(colno));
			cProductCell.setCellValue(xProduct.getFactory().getFullName());
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			colno++;				
			cProductCell   = cProductRow.createCell((short)(colno));
			cProductCell.setCellValue(xProduct.getPackingUnit());
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell   = cProductRow.createCell((short)(colno));
			cProductCell.setCellValue(xProduct.getCnumber());
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			colno++;
			//件数=数量/装率的分母
			if(UtilFuns.isNotEmpty(xProduct.getBoxNum())){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(xProduct.getBoxNum().doubleValue());
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			
			colno++;
			if(UtilFuns.isNotEmpty(xProduct.getGrossWeight())){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(xProduct.getGrossWeight().doubleValue());
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			colno++;
			if(UtilFuns.isNotEmpty(xProduct.getNetWeight())){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(xProduct.getNetWeight().doubleValue());
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			
			colno++;
			if(UtilFuns.isNotEmpty(xProduct.getSizeLength())){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(xProduct.getSizeLength().doubleValue());
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			colno++;
			if(UtilFuns.isNotEmpty(xProduct.getSizeWidth())){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(xProduct.getSizeWidth().doubleValue());
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			colno++;
			if(UtilFuns.isNotEmpty(xProduct.getSizeHeight())){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(xProduct.getSizeHeight().doubleValue());
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			Map<String, BigDecimal> map = this.getExtEproduct(xProduct.getExtEproduct());
			
			colno++;
			if(UtilFuns.isNotEmpty(map.get("t1"))){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(map.get("t1").doubleValue());		//彩盒
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			colno++;
			if(UtilFuns.isNotEmpty(map.get("t2"))){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(map.get("t2").doubleValue());		//花纸
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			colno++;
			if(UtilFuns.isNotEmpty(map.get("t3"))){
				cProductCell   = cProductRow.createCell((short)(colno));
				cProductCell.setCellValue(map.get("t3").doubleValue());		//保丽龙
				cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			}
			
			colno++;
			cProductCell   = cProductRow.createCell((short)(colno));
			if(UtilFuns.isNotEmpty(xProduct.getExPrice())){
				cProductCell.setCellValue(xProduct.getExPrice().doubleValue());
			}
			cProductCell.setCellStyle(USDStyle(wb));
			
			colno++;
			cProductCell   = cProductRow.createCell((short)(colno));
			if(UtilFuns.isNotEmpty(xProduct.getNoTax())){
				cProductCell.setCellValue(xProduct.getNoTax().doubleValue());
			}
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
			
			colno++;
			cProductCell   = cProductRow.createCell((short)(colno));
			if(UtilFuns.isNotEmpty(xProduct.getTax())){
				cProductCell.setCellValue(xProduct.getTax().doubleValue());
			}
			cProductCell.setCellStyle(RMBStyle(wb));

		}
		//}							//test
		
		if(isHasRow){
			//step 4: formula
			sheet = wb.getSheetAt(sheetCount-1);								//选择最后一个sheet
			
			cProductRow = sheet.createRow((short)rowTotal);
			cProductRow.setHeightInPoints(25);
			
			cProductCell   = cProductRow.createCell((short)(8));
			cProductCell.setCellFormula(bufGrossWeight.toString());				//∑(毛重x件数)
			cProductCell.setCellStyle(bottomStyle(wb));
			
			cProductCell   = cProductRow.createCell((short)(9));
			cProductCell.setCellFormula(bufNetWeight.toString());				//∑(净重x件数)
			cProductCell.setCellStyle(bottomStyle(wb));
			
			cProductCell   = cProductRow.createCell((short)(10));
			cProductCell.setCellFormula(bufSize.toString());		//长x宽x高x件数 tip: cm换算m3时要除以1000000，但excel报short range错误，改为除以1000两次即可
			cProductCell.setCellStyle(bottomStyle(wb));
		}
		
		
		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();

		
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(rootPath+sPath+sFile), sFile, response, true);

	}
	
	//获得附件
	private Map<String, BigDecimal> getExtEproduct(Set oSet){
		ExtEproduct eProduct = null;
		Map map = new HashMap();
		for(Iterator<ExtEproduct> it=oSet.iterator();it.hasNext();){
			eProduct = it.next();
			map.put("t"+String.valueOf(eProduct.getCtype()), eProduct.getAmount());		//利用ctype值进行区分
		}
		return map;
	}
	
	private HSSFCellStyle topStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setWrapText(true);  									//换行   
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setFontHeightInPoints((short)12);
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_MEDIUM);				//粗实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线
		
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		return curStyle;
	}
	
	private HSSFCellStyle leftStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//粗实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_MEDIUM);			//实线
		
		curStyle.setWrapText(true);  									//换行   
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		return curStyle;
	}
	
	private HSSFCellStyle rightStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();	
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);			//粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线
		
		curStyle.setWrapText(true);  									//换行   
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		return curStyle;
	}
	
	private HSSFCellStyle bottomNumStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###"));
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				//粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线
		
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//粗实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线
		
		return curStyle;
	}
	
	private HSSFCellStyle USDStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		//fTitle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);				//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("\"$\"#,###,###.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//粗实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线
		
		return curStyle;
	}
	
	private HSSFCellStyle RMBStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setWrapText(true);  									//换行   
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		//fTitle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);				//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("\"￥\"#,###,###.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//实线右边框
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				//实线右边框
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);			//实线右边框
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线右边框
		
		return curStyle;		
	}
	
	private HSSFCellStyle bottomStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				//粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线
		
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		return curStyle;
	}
	
	private HSSFCellStyle bottomRightStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();								//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);					//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);				//实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_MEDIUM);			//粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_MEDIUM);			//实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);				//实线
		
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	//单元格垂直居中
		
		return curStyle;
	}

}
