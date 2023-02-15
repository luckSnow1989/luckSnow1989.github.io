package cn.itcast.web.struts2.cargo.invoice;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Iterator;

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
import org.apache.struts2.ServletActionContext;

import cn.itcast.entity.Export;
import cn.itcast.entity.ExportProduct;
import cn.itcast.entity.Invoice;
import cn.itcast.entity.PackingList;
import cn.itcast.entity.ShippingOrder;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.entity.dao.InvoiceDAO;
import cn.itcast.entity.dao.PackingListDAO;
import cn.itcast.web.common.util.Arith;
import cn.itcast.web.common.util.DownloadBaseAction;
import cn.itcast.web.common.util.SymbolNumber;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.common.util.file.FileUtil;
import cn.itcast.web.common.util.file.PioUtil;
import cn.itcast.web.struts2._BaseStruts2Action;

import com.opensymphony.xwork2.ModelDriven;

public class InvoiceAction extends _BaseStruts2Action implements ModelDriven<Invoice> {
	private Invoice model = new Invoice();
	public Invoice getModel() {
		return model;
	}

	//保存
	public String save() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String id = request.getParameter("id");			//packingList id
		request.setAttribute("id",id);
		
		String subid = request.getParameter("subid");

		String blno = request.getParameter("blNo");
		String tradeTerms = request.getParameter("tradeTerms");
		//String descriptions = request.getParameter("descriptions");
		
		
		PackingListDAO mDao = (PackingListDAO)super.getDao("daoPackingList");
		PackingList packing = (PackingList)mDao.get(PackingList.class, id);
		
		InvoiceDAO oDao = (InvoiceDAO) this.getDao("daoInvoice");
		Invoice obj = null;
		if(UtilFuns.isNotEmpty(subid)){
			obj =(Invoice) oDao.get(Invoice.class, subid);
		}else{
			obj = new Invoice();
			obj.setId(id);		//same as packinglist id
			subid = obj.getId();
		}
		
		obj.setScNo(packing.getExportNos().replace("|", " "));			//S/C就是报运的合同号，也就是报运中选中的多个合同号串
		obj.setBlNo(blno);
		obj.setTradeTerms(tradeTerms);
		
		if(UtilFuns.isNotEmpty(packing.getExportIds())){
			String[] exportId = UtilFuns.splitStr(packing.getExportIds(), "|");
			if(UtilFuns.isNotEmpty(exportId)){
				ExportDAO eDao = (ExportDAO)super.getDao("daoExport");
				Export export = null;
				for(int i=0;i<exportId.length;i++){
					export = (Export)eDao.get(Export.class, exportId[i]);
					export.setState(4);		//设置为：发票	 tip:利用hibernate自动提交机制，无需显式的保存export对象，即可保存其改变。一定要慎用。
				}
			}
		}
		oDao.saveOrUpdate(obj);
		
		return toedit();
	}
	
	public String toedit() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");		//PackingList id
		request.setAttribute("id",id);
		
		if(UtilFuns.isNotEmpty(id)){
			PackingListDAO mDao = (PackingListDAO)super.getDao("daoPackingList");
			PackingList mobj = (PackingList)mDao.get(PackingList.class, id);
			
			if(mobj==null){
				throw new Exception("请先填写装箱信息（发票号、发票时间、卖家、买家等）, 保存后再点击【发票】!");
			}
			
			Invoice obj = mobj.getInvoice();
			request.setAttribute("obj",obj);
		}

		
		return "pedit";
	}

	public void print() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		InvoiceDAO oDao = (InvoiceDAO)this.getDao("daoInvoice");
		Invoice obj = (Invoice)oDao.get(Invoice.class, id);
		
		if(obj==null){
			throw new Exception("请先填写发票信息, 保存后再点击打印!");
		}
		
		ShippingOrder shippingOrder = obj.getPackingList().getShippingOrder();
		if(shippingOrder==null){
			throw new Exception("请先填写委托信息, 需从委托中获取部分信息（LC号、空运or船运）, 再点击打印!");
		}			
		
		UtilFuns utilFuns = new UtilFuns();
		String rootPath = utilFuns.getROOTPath();
		String tempXlsFile = rootPath+"make/xlsprint/tINVOICE.xls";
		
		FileUtil fu = new FileUtil();
		String sPath = "/web/tmpfile/"+UtilFuns.sysDate()+"/";
		String sFile = fu.newFile(rootPath+sPath, "invoice.xls");
		fu.makeDir(rootPath+sPath);
		
		String outFile = rootPath+sPath+sFile;
		
		PioUtil pioUtil = new PioUtil();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(tempXlsFile));
		HSSFFont defaultFont10 = pioUtil.defaultFont10Blod(wb);			//设置字体
		Short datevENFormat = pioUtil.datevENFormat(wb);			//设置格式

		HSSFSheet sheet = wb.getSheetAt(0);				//选择第一个工作簿
		wb.setSheetName(0, "发票");		//设置工作簿的名称

		//sheet.setDefaultColumnWidth((short) 20); // 设置每列默认宽度
		
//		POI分页符有BUG，必须在模板文件中插入一个分页符，然后再此处删除预设的分页符；最后在下面重新设置分页符。
		sheet.setAutobreaks(false);
//		//int iRowBreaks[] = sheet.getRowBreaks();
//		sheet.removeRowBreak(3);
//		sheet.removeRowBreak(4);
//		sheet.removeRowBreak(5);
//		sheet.removeRowBreak(6);

		HSSFRow nRow = null;
		HSSFCell nCell   = null;
		int curRow = 4; 
		int startRow = 1;

		boolean haveDesc = true;	//如果有填写了“描述”，则marks放中间；如果没有填写，则放最后
//		if(UtilFuns.isEmpty(obj.getPackingList().getDescriptions())){
//			haveDesc = false;
//		}
		haveDesc = false;
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(24);
		
		nCell   = nRow.createCell((short)(0));
		nCell.setCellValue(obj.getPackingList().getSeller());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));
		
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		
		nRow = sheet.createRow((short)curRow-1);
		float heightBuyer = pioUtil.getCellAutoHeight(obj.getPackingList().getBuyer(), 12f);		//自动高度
		nRow.setHeightInPoints(heightBuyer-25);		//-25上下默认留白过多
		
		nCell   = nRow.createCell((short)(0));
		nCell.setCellValue(obj.getPackingList().getBuyer());
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
		nCell.setCellValue(obj.getPackingList().getInvoiceNo());
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(2));
		nCell.setCellValue(UtilFuns.formatDateEN(UtilFuns.dateTimeFormat(obj.getPackingList().getInvoiceDate())));
		nCell.setCellStyle(pioUtil.datevEN(wb,defaultFont10,datevENFormat));
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(5));
		//nCell.setCellValue(obj.getScno().replaceAll(" ", ","));
		
		
		//by tony 20120323 1:18 tip:根据单元格容纳各类型的多少个，反算一个所占的宽度；然后取得其类型在字符串中的个数，算出各种类型的宽度
		SymbolNumber symbolNumber = new SymbolNumber();
		double stringWidth = 1.056;		//字符宽度
		double numberWidth = 0.839;		//数字宽度
		double symbolWidth = 0.475;		//斜杠符号宽度
		double commaWidth = 0.354;		//逗号宽度
		double cellWidth = 28.51;		//scno单元格宽度
		
		String str = obj.getScNo().replaceAll(" ", ",");
		double curStrWidth = Arith.add(Arith.add(Arith.mul((double)symbolNumber.string(str, "[a-z|A-Z]"),stringWidth),Arith.mul((double)symbolNumber.string(str, "[0-9]"),numberWidth)),Arith.mul((double)symbolNumber.string(str, "[/|,]"),symbolWidth));
		
		if(curStrWidth>cellWidth){
			nCell.setCellValue(utilFuns.replaceLast(str, ",", ",\n"));		//换行 计算如其串超出单元格宽度，则最后一个元素换行
		}else{
			nCell.setCellValue(str);
		}
		
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(9));
		nCell.setCellValue(obj.getBlNo());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(0));
		nCell.setCellValue(shippingOrder.getLcno());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(2));
		nCell.setCellValue(shippingOrder.getOrderType());			//SEA|AIR
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(5));
		nCell.setCellValue(shippingOrder.getPortOfLoading());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(7));
		nCell.setCellValue(shippingOrder.getPortOfDischarge());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		
		curRow++;
		curRow++;
		curRow++;

		
		curRow++;
		nRow = sheet.createRow((short)curRow-1);
		
		float height = pioUtil.getCellAutoHeight(obj.getPackingList().getDescriptions(), 12f);		//自动高度
		nRow.setHeightInPoints(height);
		
		nCell   = nRow.createCell((short)(2));
		nCell.setCellValue(obj.getPackingList().getDescriptions());
		nCell.setCellStyle(pioUtil.notevt10(wb, defaultFont10));		
		
		curRow++;
		
		nRow = sheet.createRow((short)curRow-1);
		nRow.setHeightInPoints(16);
		
		nCell   = nRow.createCell((short)(7));
		nCell.setCellValue(obj.getTradeTerms());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));			
		
		//list products
		String _contractNo = "";
		HSSFRow cProductRow = null;
		HSSFCell cProductCell   = null;
		int pnum = 0;
		int colno = 1;
		
		startRow = curRow+2;
		
		String exportIds = obj.getPackingList().getExportIds();
		
		if(UtilFuns.isEmpty(exportIds)){
			throw new Exception("未添加报运的货物!<br> 请修改此发票对应的装箱, 添加要报运的货物!");
		}
		
		String[] exportId = UtilFuns.splitStr(exportIds,"|");
		
		ExportDAO eDao = (ExportDAO)this.getDao("daoExport");
		Export export = null;
		
		for(int i=0;i<exportId.length;i++){
			export = (Export)eDao.get(Export.class, exportId[i]);
			
			Iterator<ExportProduct> it = export.getExportProduct().iterator();
			while(it.hasNext()){
				
				ExportProduct cProduct = it.next();
				
				if(UtilFuns.isNotEmpty(cProduct.getExPrice())){		//去除价格为空的记录。做合同时，同一款货会分到多个厂家做，但数量只记一条。
					curRow++;
					colno = 0;

					cProductRow = sheet.createRow((short)curRow-1);
					cProductRow.setHeightInPoints(16);
					
					//相同的合同号只第一个显示
					colno++;
					cProductCell   = cProductRow.createCell((short)(colno));
					if(_contractNo.equals(cProduct.getContractNo())){
						cProductCell.setCellValue("");
					}else{
						cProductCell.setCellValue(cProduct.getContractNo()+" ");
						_contractNo = cProduct.getContractNo();
					}
					cProductCell.setCellStyle(noWrap(wb));
	
					colno++;
					cProductCell   = cProductRow.createCell((short)(colno));
					cProductCell.setCellValue(cProduct.getProductNo());
					cProductCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
	
					//new line
					curRow++;
					cProductRow = sheet.createRow((short)curRow-1);
					cProductRow.setHeightInPoints(16);
					
					colno++;
					colno++;
					
					colno++;
					if(UtilFuns.isNotEmpty(cProduct.getCnumber())){
						cProductCell   = cProductRow.createCell((short)(colno));
						cProductCell.setCellValue(String.valueOf(cProduct.getCnumber()));
						cProductCell.setCellStyle(rightStyle(wb));
					}
					
					colno++;
					if(UtilFuns.isNotEmpty(cProduct.getCnumber())){
						cProductCell   = cProductRow.createCell((short)(colno));
						cProductCell.setCellValue(cProduct.getPackingUnit());
						cProductCell.setCellStyle(leftStyle(wb));
					}
					
					colno++;
					if(UtilFuns.isNotEmpty(cProduct.getExPrice())){
						cProductCell   = cProductRow.createCell((short)(colno));
						cProductCell.setCellValue(cProduct.getExPrice().doubleValue());
						cProductCell.setCellStyle(USDStyle(wb));
					}
					
					colno++;
					colno++;
					if(UtilFuns.isNotEmpty(cProduct.getAmount())){
						cProductCell   = cProductRow.createCell((short)(colno));
						cProductCell.setCellFormula("F"+curRow+"*H"+curRow);
						cProductCell.setCellStyle(USDStyle(wb));
					}
					
					colno++;
				}
				
				pnum++;
			}
		}
		
		cProductRow = sheet.createRow((short)curRow);
		cProductRow.setHeightInPoints(16);
		
		cProductCell   = cProductRow.createCell((short)(colno-1));
		cProductCell.setCellFormula("SUM(J"+startRow+":J"+curRow+")");
		cProductCell.setCellStyle(bottomUSDStyle(wb));
		
		if(!haveDesc){
			curRow++;
			curRow++;
			
			Region regionMarks = new Region(curRow, (short)(0), curRow, (short)9);	//横向合并单元格  
			sheet.addMergedRegion(regionMarks);
			

			curRow++;
			
			nRow = sheet.createRow((short)curRow-1);
			float heightMarks = pioUtil.getCellAutoHeight(obj.getPackingList().getMarks(), 12f);		//自动高度
			nRow.setHeightInPoints(heightMarks);
			
			nCell   = nRow.createCell((short)(0));
			nCell.setCellValue(obj.getPackingList().getMarks());
			nCell.setCellStyle(pioUtil.notevt10(wb, defaultFont10));		
			
			nRow = sheet.createRow((short)curRow-1);
			nRow.setHeightInPoints(heightMarks);

		}
		
		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(rootPath+sPath+sFile), sFile, response, true);
	}
	
	private HSSFCellStyle font20Style(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); // 设置字体
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); // 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 20);
		curStyle.setFont(curFont);

		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 单元格垂直居中

		return curStyle;
	}
	
	private HSSFCellStyle leftStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		curStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
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

		
		return curStyle;
	}
	
	private HSSFCellStyle USDStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("\"USD\"#,###,##0.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中

		
		return curStyle;
	}
	
	private HSSFCellStyle bottomUSDStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();						//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("\"USD\"#,###,##0.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		return curStyle;
	}
	
	private HSSFCellStyle listStyle(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont();					//设置字体
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);			//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);		//加粗
		curFont.setFontHeightInPoints((short)12);
		curStyle.setFont(curFont);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_DASHED);				//虚线下边框
		
		return curStyle;
	}
	
	
	public HSSFCellStyle noWrap(HSSFWorkbook wb){
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setWrapText(false);  						//换行   
		HSSFFont curFont = wb.createFont();					//设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);		//设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);	//加粗
		curFont.setFontHeightInPoints((short)10);
		curStyle.setFont(curFont);
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);		//单元格垂直居中
		
		return curStyle;
	} 	
}