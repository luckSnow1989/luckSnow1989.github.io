package cn.itcast.web.print;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;

import cn.itcast.entity.Export;
import cn.itcast.entity.ExportProduct;
import cn.itcast.entity.ExtEproduct;
import cn.itcast.entity.PackingList;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.entity.dao.PackingListDAO;
import cn.itcast.web.common.util.Arith;
import cn.itcast.web.common.util.DownloadBaseAction;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.common.util.file.FileUtil;
import cn.itcast.web.common.util.file.PioUtil;


public class PackingListPrint{

	public void print(HttpServletRequest request, HttpServletResponse response, PackingListDAO oDao, ExportDAO eDao) throws Exception{
		String id = request.getParameter("id");		//packingList id
		UtilFuns utilFuns = new UtilFuns();
		String rootPath = utilFuns.getROOTPath();

		PackingList obj = (PackingList)oDao.get(PackingList.class, id);
		
		if(obj==null){
			throw new Exception("请先填写装箱信息（发票号、发票时间、卖家、买家）, 保存后再点击打印!");
		}
		
		String tempXlsFile = rootPath+"make/xlsprint/tPARKINGLIST.xls";
		
		FileUtil fu = new FileUtil();
		String sPath = "/web/tmpfile/"+UtilFuns.sysDate()+"/";
		String sFile = fu.newFile(rootPath+sPath, "parkinglist.xls");
		fu.makeDir(rootPath+sPath);
		
		String outFile = rootPath+sPath+sFile;
		
		PioUtil pioUtil = new PioUtil();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(tempXlsFile));
		HSSFFont defaultFont10 = pioUtil.defaultFont10Blod(wb);		//设置字体

		HSSFSheet sheet = wb.getSheetAt(0);				//选择第一个工作簿
		wb.setSheetName(0, "装箱单");		//设置工作簿的名称

		//sheet.setDefaultColumnWidth((short) 20); // 设置每列默认宽度
		
//		POI分页符有BUG，必须在模板文件中插入一个分页符，然后再此处删除预设的分页符；最后在下面重新设置分页符。
		sheet.setAutobreaks(false);
//		//int iRowBreaks[] = sheet.getRowBreaks();
//		sheet.removeRowBreak(3);
//		sheet.removeRowBreak(4);
//		sheet.removeRowBreak(5);
//		sheet.removeRowBreak(6);

		Region region = null;

		HSSFRow nRow = null;
		HSSFCell nCell   = null;
		int curRow = 4;
		int startRow = 22;
		int stopRow = 0;

		boolean haveDesc = true;	//如果有填写了“描述”，则marks放中间；如果没有填写，则放最后
//		if(UtilFuns.isEmpty(obj.getDescriptions())){
//			haveDesc = false;
//		}
		haveDesc = false;		//修改为都放最后，备注用户自己填写，无需打印
		
		//都是单位的合计，全是SET，则是SETS；全是PC，则是PCS；混合则是P’KGS
		boolean isPCS = true;
		boolean isSETS = true;
		String packingUnit = "";
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell   = nRow.createCell((short)(0));
		nCell.setCellValue(obj.getSeller());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));
		
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		
		nRow = sheet.createRow((short)curRow-1);
		float heightBuyer = pioUtil.getCellAutoHeight(obj.getBuyer(), 12f);		//自动高度
		nRow.setHeightInPoints(heightBuyer-25);		//-25上下默认留白过多
		
		nCell   = nRow.createCell((short)(0));
		nCell.setCellValue(obj.getBuyer());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));
		


		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(0));
		nCell.setCellValue(obj.getInvoiceNo());
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(3));
		nCell.setCellValue(UtilFuns.formatDateEN(UtilFuns.dateTimeFormat(obj.getInvoiceDate())));
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
		curRow++;
		curRow++;
		curRow++;
		
		curRow++;
		nRow = sheet.createRow((short)curRow-1);
		
		float height = pioUtil.getCellAutoHeight(obj.getDescriptions(), 12f);		//自动高度
		nRow.setHeightInPoints(height);
		
		nCell   = nRow.createCell((short)(2));
		nCell.setCellValue(obj.getDescriptions());
		nCell.setCellStyle(pioUtil.notevt10(wb, defaultFont10));		
		
		curRow++;
		
		//list products
		String _contractNo = "";
		HSSFRow cProductRow = null;
		HSSFCell cProductCell   = null;
		int pnum = 0;
		int colno = 1;
		
		startRow = curRow+2;
		
		String exportIds = obj.getExportIds();
		if(UtilFuns.isEmpty(exportIds)){
			throw new Exception("未添加报运的货物!<br> 请修改此装箱, 添加要报运的货物。");
		}else{
			String[] exportId = UtilFuns.splitStr(exportIds,"|");
			
			Export export = null;
			
			for(int i=0;i<exportId.length;i++){
				export = (Export)eDao.get(Export.class, exportId[i]);
				
				Iterator<ExportProduct> it = export.getExportProduct().iterator();
				while(it.hasNext()){
					
					ExportProduct cProduct = it.next();
					if(UtilFuns.isNotEmpty(cProduct.getGrossWeight())){
						curRow++;
						colno = 0;
						cProductRow = sheet.createRow((short)curRow-1);
						cProductRow.setHeightInPoints(16);
						
						//相同的合同号只第一个显示
						colno++;
						cProductCell   = cProductRow.createCell((short)(colno+1));
						if(_contractNo.equals(cProduct.getContractNo())){
							cProductCell.setCellValue("");
						}else{
							cProductCell.setCellValue(cProduct.getContractNo()+" ");
							_contractNo = cProduct.getContractNo();
						}
						cProductCell.setCellStyle(noWrap(wb));
						
						colno++;
						cProductCell   = cProductRow.createCell((short)(colno+1));
						cProductCell.setCellValue(cProduct.getProductNo());
						cProductCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
						//new line
						curRow++;
						cProductRow = sheet.createRow((short)curRow-1);
						cProductRow.setHeightInPoints(16);
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getCnumber())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getCnumber());
							cProductCell.setCellStyle(pioUtil.notehrv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getPackingUnit())){
							if(cProduct.getPackingUnit().equals("PCS")){
								isSETS = false;					
							}else if(cProduct.getPackingUnit().equals("SETS")){
								isPCS = false;
							}
							
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getPackingUnit());
							cProductCell.setCellStyle(pioUtil.notehlv10(wb, defaultFont10));
						}
						
						colno++;
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getBoxNum())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getBoxNum());
							cProductCell.setCellStyle(pioUtil.notehrv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getBoxNum())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue("CTNS");
							cProductCell.setCellStyle(pioUtil.notehlv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getGrossWeight())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getGrossWeight().doubleValue());
							cProductCell.setCellStyle(atStyle(wb));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getNetWeight())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getNetWeight().doubleValue());
							cProductCell.setCellStyle(atStyle(wb));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getSizeLenght())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getSizeLenght().doubleValue());
							cProductCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getSizeLenght())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue("X");
							cProductCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getSizeWidth())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getSizeWidth().doubleValue());
							cProductCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getSizeWidth())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue("X");
							cProductCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getSizeHeight())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue(cProduct.getSizeHeight().doubleValue());
							cProductCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
						}
						
						colno++;
						if(UtilFuns.isNotEmpty(cProduct.getSizeHeight())){
							cProductCell   = cProductRow.createCell((short)(colno));
							cProductCell.setCellValue("cm");
							cProductCell.setCellStyle(pioUtil.notehlv10(wb, defaultFont10));
						}
						
						pnum++;
					}
				}
			}
		}
		
		
		//total
		stopRow = curRow;
		colno = 2;
		
		nRow = sheet.createRow((short)stopRow);
		nRow.setHeightInPoints(18);
		
		colno++;
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellFormula("SUM(D"+startRow+":D"+stopRow+")");
		nCell.setCellStyle(topRightStyle(wb));					
		
		if(isSETS){
			packingUnit = "SETS";
		}else if(isPCS){
			packingUnit = "PCS";
		}else{
			packingUnit = "P'KGS";
		}

		colno++;
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellValue(packingUnit);
		nCell.setCellStyle(topLeftStyle(wb));					

		colno++;
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellValue("");
		nCell.setCellStyle(topStyle(wb));
		
		colno++;
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellFormula("SUM(G"+startRow+":G"+stopRow+")");
		nCell.setCellStyle(topRightStyle(wb));					
		
		colno++;
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellValue("CTNS");
		nCell.setCellStyle(topLeftStyle(wb));				

		colno++;
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellFormula("TEXT(SUMPRODUCT(G"+startRow+":G"+stopRow+",I"+startRow+":I"+stopRow+"),\"@\")&\"KGS\"");				//∑(毛重x件数) 转换为字符类型，否则如无小数却还显示个小数点122.
		nCell.setCellStyle(moneyKGSStyle(wb));					
		
		colno++;
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellFormula("TEXT(SUMPRODUCT(G"+startRow+":G"+stopRow+",J"+startRow+":J"+stopRow+"),\"@\")&\"KGS\"");				//∑(净重x件数)
		nCell.setCellStyle(moneyKGSStyle(wb));					
		
		colno++;
		//补充单元格的划线
		for(int i=0;i<6;i++){
			nCell   = nRow.createCell((short)(colno+i));
			nCell.setCellValue("");
			nCell.setCellStyle(topStyle(wb));
		}
		
		region = new Region(curRow, (short)(10), curRow, (short)15);	//指定合并区域  合并单元格不会设置相同格式，例如划线
		sheet.addMergedRegion(region);
		
		nCell   = nRow.createCell((short)(colno));
		nCell.setCellFormula("SUMPRODUCT(G"+startRow+":G"+stopRow+",K"+startRow+":K"+stopRow+",M"+startRow+":M"+stopRow+",O"+startRow+":O"+stopRow+")/100/100/100");	//长x宽x高x件数 tip: cm换算m3时要除以1000000，但excel报short range错误，改为除以100三次即可
		nCell.setCellStyle(topMoneyM3Style(wb));				

		
		if(!haveDesc){
			curRow++;
			curRow++;
			
			Region regionMarks = new Region(curRow, (short)(0), curRow, (short)9);	//横向合并单元格  
			sheet.addMergedRegion(regionMarks);
			

			curRow++;
			
			nRow = sheet.createRow((short)curRow-1);
			float heightMarks = pioUtil.getCellAutoHeight(obj.getMarks(), 12f);		//自动高度
			nRow.setHeightInPoints(heightMarks);
			
			nCell   = nRow.createCell((short)(0));
			nCell.setCellValue(obj.getMarks());
			nCell.setCellStyle(pioUtil.notevt10(wb, defaultFont10));		
			
			nRow = sheet.createRow((short)curRow-1);
			nRow.setHeightInPoints(heightMarks);	
		}

		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();
		
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(rootPath+sPath+sFile), "装箱单.xls", response, true);

	}
	
	
	public HSSFCellStyle noWrap(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setWrapText(false);  						//换行   
		HSSFFont curFont = wb.createFont();					//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);		//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		return curStyle;
	}  
	
	private HSSFCellStyle atStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("\"@\"###.0"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		return curStyle;
	}
	
	private HSSFCellStyle topStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}
	
	private HSSFCellStyle topLeftStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}
	
	private HSSFCellStyle topRightStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}
	
	private HSSFCellStyle topMoneyStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}
	
	private HSSFCellStyle topMoneyM3Style(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setWrapText(false);  							//换行  
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,##0.00\"M3\""));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}
	
	private HSSFCellStyle moneyKGSStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#.###\"KGS\""));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}
	
	private HSSFCellStyle rightStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}

}
