package cn.itcast.web.struts2.cargo.finance;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.util.Date;
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
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.struts2.ServletActionContext;

import cn.itcast.entity.Export;
import cn.itcast.entity.ExportProduct;
import cn.itcast.entity.ExtEproduct;
import cn.itcast.entity.Finance;
import cn.itcast.entity.PackingList;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.entity.dao.FinanceDAO;
import cn.itcast.entity.dao.PackingListDAO;
import cn.itcast.web.common.util.Arith;
import cn.itcast.web.common.util.DownloadBaseAction;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.common.util.file.FileUtil;
import cn.itcast.web.common.util.file.PioUtil;
import cn.itcast.web.struts2._BaseStruts2Action;

import com.opensymphony.xwork2.ModelDriven;

public class FinanceAction extends _BaseStruts2Action implements ModelDriven<Finance> {
	private Finance model = new Finance();
	public Finance getModel() {
		return model;
	}

	//保存
	public String save() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String id = request.getParameter("id");
		request.setAttribute("id",id);
		
		String subid = request.getParameter("subid");

		String inputBy = request.getParameter("inputBy");
		String inputDate = request.getParameter("inputDate");
		
		PackingListDAO mDao = (PackingListDAO)super.getDao("daoPackingList");
		PackingList packing = (PackingList)mDao.get(PackingList.class, id);
		
		FinanceDAO oDao = (FinanceDAO) this.getDao("daoFinance");
		Finance obj = null;
		if(UtilFuns.isNotEmpty(subid)){
			obj = (Finance)oDao.get(PackingList.class, subid);
		}else{
			obj = new Finance();
			obj.setId(id);		//same as export id
			subid = obj.getId();
		}
		
		
		obj.setInputBy(inputBy);
		if(UtilFuns.isNotEmpty(inputDate)){
			obj.setInputDate(UtilFuns.parseDate(inputDate));
		}
		
		if(UtilFuns.isNotEmpty(packing.getExportIds())){
			String[] exportId = UtilFuns.splitStr(packing.getExportIds(), "|");
			if(UtilFuns.isNotEmpty(exportId)){
				ExportDAO eDao = (ExportDAO)super.getDao("daoExport");
				Export export = null;
				for(int i=0;i<exportId.length;i++){
					export = (Export)eDao.get(Export.class, exportId[i]);
					export.setState(5);		//设置为：财务 tip:利用hibernate自动提交机制，无需显式的保存export对象，即可保存其改变。一定要慎用。
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
				throw new Exception("请先填写财务信息（制单人、制单日期）, 保存后再点击【财务】!");
			}
			
			Finance obj = mobj.getFinance();
			request.setAttribute("obj",obj);
		}
		
		return "pedit";
	}

	public void print() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");							//PackingList id
		FinanceDAO oDao = (FinanceDAO) this.getDao("daoFinance");
		Finance finance = (Finance)oDao.get(Finance.class, id);

		if (finance == null) {
			throw new Exception("请先填写财务信息（制单人、制单日期）, 保存后再点击打印!");
		}
		
		PackingListDAO mDao = (PackingListDAO)super.getDao("daoPackingList");
		PackingList mobj = (PackingList)mDao.get(PackingList.class, id);
		
		if(mobj==null){
			throw new Exception("请先填写装箱信息（发票号、发票时间、卖家、买家等）, 保存后再点击【发票】!");
		}
		
		UtilFuns utilFuns = new UtilFuns();
		String rootPath = utilFuns.getROOTPath();
		
		//选择报运都是同一个目的港，所以打印“装运港、目的港、价格条件”等信息都一致，
		ExportDAO eDao = (ExportDAO)super.getDao("daoExport");
		Export obj = null;
		if(UtilFuns.isNotEmpty(mobj.getExportIds())){
			String[] exportId = UtilFuns.splitStr(mobj.getExportIds(), "|");
			obj = (Export)eDao.get(Export.class, exportId[0]);		//取第一个
		}
		
		if(obj==null){
			throw new Exception("未添加报运的货物!<br> 请修改此装箱, 添加要报运的货物。");
		}
		
		String InvoiceNo = mobj.getInvoiceNo();							//以发票号命名保存的文件名
		if(InvoiceNo==null){
			throw new Exception("装箱单未填写发票号,请进入装箱管理,填写发票号!");
		}

		String tempXlsFile = rootPath + "make/xlsprint/tFINANCE.xls";

		FileUtil fu = new FileUtil();
		String sPath = "/web/tmpfile/" + UtilFuns.sysDate() + "/";
		String sFile = fu.newFile(rootPath + sPath,InvoiceNo+".xls");		//以发票号命名保存的文件名
		fu.makeDir(rootPath + sPath);

		String outFile = rootPath + sPath + sFile;

		PioUtil pioUtil = new PioUtil();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(tempXlsFile));
		HSSFFont defaultFont10 = pioUtil.defaultFont10(wb);			//设置字体
		HSSFFont defaultFont12 = pioUtil.defaultFont12(wb);			//设置字体
		Short money1Format = pioUtil.money1Format(wb);				//设置格式
		Short datevENFormat = pioUtil.datevENFormat(wb);			//设置格式

		HSSFSheet sheet = wb.getSheetAt(0); 						// 选择第一个工作簿
		wb.setSheetName(0, "报运单"); 								// 设置工作簿的名称
		
		HSSFFont songFont = wb.createFont(); 						// 设置字体
		songFont.setFontName("宋体");
		songFont.setFontHeightInPoints((short) 12);
		
		HSSFFont theFont = wb.createFont(); 						// 设置字体
		theFont.setFontName("Abadi MT Condensed Light");
		theFont.setFontHeightInPoints((short) 12);
		
		HSSFFont abadiFont = wb.createFont(); 						// 设置字体
		abadiFont.setFontName("Abadi MT Condensed Light");
		abadiFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 			// 加粗
		abadiFont.setFontHeightInPoints((short) 12);
		
		HSSFFont invoiceFont = wb.createFont(); 					// 设置字体
		invoiceFont.setFontName("Times New Roman");
		invoiceFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD); 		// 加粗
		invoiceFont.setFontHeightInPoints((short) 18);

		// sheet.setDefaultColumnWidth((short) 20); // 设置每列默认宽度

		// POI分页符有BUG，必须在模板文件中插入一个分页符，然后再此处删除预设的分页符；最后在下面重新设置分页符。
		sheet.setAutobreaks(false);
		// //int iRowBreaks[] = sheet.getRowBreaks();
		// sheet.removeRowBreak(3);
		// sheet.removeRowBreak(4);
		// sheet.removeRowBreak(5);
		// sheet.removeRowBreak(6);

		Region region = null;
		HSSFRow nRow = null;
		HSSFCell nCell = null;
		int curRow = 2;

		// inputDate
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (3));
		//nCell.setCellValue(UtilFuns.formatDateTimeCN(UtilFuns.dateTimeFormat(obj.getInputDate())));
		nCell.setCellValue(UtilFuns.dateTimeFormat(finance.getInputDate()));
		nCell.setCellStyle(invoiceNoStyle(wb, songFont));

		// invoiceNo
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (15));
		nCell.setCellValue(InvoiceNo);
		nCell.setCellStyle(invoiceNoStyle(wb, invoiceFont));

		curRow++;

		// customerContract
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (4));
		nCell.setCellValue(" "+obj.getCustomerContract());
		nCell.setCellStyle(topStyle(wb));

		// lcno
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (11));
		nCell.setCellValue(" "+obj.getLcno());
		nCell.setCellStyle(topStyle(wb));

		curRow++;

		// consignee
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (4));
		if(UtilFuns.isNotEmpty(obj.getConsignee())){
			nCell.setCellValue("   "+obj.getConsignee().toUpperCase());		//大写
		}
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));

		// marks
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (11));
		nCell.setCellValue(" "+obj.getMarks());
		nCell.setCellStyle(pioUtil.notet10(wb));

		// remark
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (13));
		// nCell.setCellValue(obj.getRemark());
		nCell.setCellStyle(pioUtil.notet10(wb));

		curRow++;

		// shipmentPort
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (2));
		nCell.setCellValue(obj.getShipmentPort());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));

		// destinationPort 
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (5));
		nCell.setCellValue(" "+UtilFuns.convertNull(obj.getDestinationPort()));
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));

		// priceCondition
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(26);

		nCell = nRow.createCell((short) (10));
		nCell.setCellValue(obj.getPriceCondition());
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));

		curRow++;
		curRow++;

		// list products
		int startRow = 0;
		int stopRow = 0;

		BigDecimal bcsize = new BigDecimal(0);
		Arith arith = new Arith();
		HSSFRow cProductRow = null;
		HSSFCell cProductCell = null;
		int pnum = 0;
		int ptotalNum = 18; // 一页记录行数
		int colno = 1;

		startRow = curRow + 1;

		// for(int ii=0;ii<10;ii++){ //test
		String exportIds = mobj.getExportIds();
		String[] exportId = UtilFuns.splitStr(exportIds,"|");
		
		ExportDAO exportDao = (ExportDAO)this.getDao("daoExport");
		Export exportx = null;
		
		for(int i=0;i<exportId.length;i++){
			exportx = (Export)exportDao.get(Export.class, exportId[i]);
			
			Iterator<ExportProduct> it = exportx.getExportProduct().iterator();
			while (it.hasNext()) {

				sheet = wb.getSheetAt(0); // 选择工作簿

				ExportProduct cProduct = it.next();
				
				if(UtilFuns.isNotEmpty(cProduct.getGrossWeight())){
					colno = -1;
					curRow++;
					
					cProductRow = sheet.createRow((short) curRow - 1);
					cProductRow.setHeightInPoints(18);
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
					cProductCell.setCellFormula("H" + curRow + "*J" + curRow);
					cProductCell.setCellStyle(pioUtil.money1(wb,defaultFont10,money1Format));
	
					colno++;
					region = new Region(curRow, (short) (colno), curRow, (short) (colno + 2)); // 指定合并区域 合并单元格不会设置相同格式，例如划线
					sheet.addMergedRegion(region);
	
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellValue(cProduct.getProductNo());
					cProductCell.setCellStyle(leftStyle(wb));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellValue("");
					cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellValue("");
					cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellValue(cProduct.getFactory().getFactoryName()); // 简称
					cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellValue(cProduct.getPackingUnit());
					cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellValue(cProduct.getCnumber());
					cProductCell.setCellStyle(numberStyle(wb, abadiFont));
	
					colno++;
					// 件数=数量/装率的分母
					if (UtilFuns.isNotEmpty(cProduct.getBoxNum())) {
						cProductCell = cProductRow.createCell((short) (colno));
						cProductCell.setCellValue(cProduct.getBoxNum().doubleValue());
						cProductCell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
						cProductCell.setCellStyle(numberStyle(wb, abadiFont));
					}
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					if (UtilFuns.isNotEmpty(cProduct.getGrossWeight())) {
						cProductCell.setCellValue(cProduct.getGrossWeight().doubleValue());
						cProductCell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
					}
					cProductCell.setCellStyle(generalStyle(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					if (UtilFuns.isNotEmpty(cProduct.getNetWeight())) {
						cProductCell.setCellValue(cProduct.getNetWeight().doubleValue());
					}
					cProductCell.setCellStyle(generalStyle(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					if (UtilFuns.isNotEmpty(cProduct.getSizeLength())) {
						cProductCell.setCellValue(cProduct.getSizeLength().doubleValue());
						cProductCell.setCellType(HSSFCell.CELL_TYPE_NUMERIC);
					}
					cProductCell.setCellStyle(number1Style(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					if (UtilFuns.isNotEmpty(cProduct.getSizeWidth())) {
						cProductCell.setCellValue(cProduct.getSizeWidth().doubleValue());
					}
					cProductCell.setCellStyle(number1Style(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					if (UtilFuns.isNotEmpty(cProduct.getSizeHeight())) {
						cProductCell.setCellValue(cProduct.getSizeHeight().doubleValue());
					}
					cProductCell.setCellStyle(number1Style(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					if (UtilFuns.isNotEmpty(cProduct.getExPrice())) {
						cProductCell.setCellValue(cProduct.getExPrice().doubleValue());
					}
					cProductCell.setCellStyle(number2Style(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellFormula("G" + curRow + "*N" + curRow);
					cProductCell.setCellStyle(number2Style(wb, abadiFont));
	
					colno++;
					if (UtilFuns.isNotEmpty(cProduct.getTax())) {
						cProductCell = cProductRow.createCell((short) (colno));
						cProductCell.setCellValue(cProduct.getTax().doubleValue());
						cProductCell.setCellStyle(number2Style(wb, abadiFont));
					}
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
					cProductCell.setCellFormula("ROUND(G" + curRow + "*P" + curRow + "/1.17,2)");			//1.17为国家每年下的税率，正式系统保存在properties文件中
					cProductCell.setCellStyle(rmb2Style(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
					cProductCell.setCellFormula("ROUND(G" + curRow + "*P" + curRow + "-G" + curRow + "*P" + curRow + "/1.17,2)");	//必须加round四舍五入函数，否则显示为2位，因为单元格强制格式，但总计累加时，实际用的是合计前的，导致有进位情况时，可见的值手工合计和合计单元格值不同。
					cProductCell.setCellStyle(rmb2Style(wb, abadiFont));
	
					colno++;
					cProductCell = cProductRow.createCell((short) (colno));
					cProductCell.setCellType(HSSFCell.CELL_TYPE_FORMULA);
					cProductCell.setCellFormula("H" + curRow + "*K" + curRow + "*L" + curRow + "*M" + curRow + "/100/100/100");
					cProductCell.setCellStyle(leftMoney(wb));
	
					pnum++;
				}
			}
		}
		// } //test

		// 附件
		List<ExtEproduct> extList = oDao.find("from ExtEproduct o where o.exportProduct.export.id in ('" + mobj.getExportIds().replace("|", "','") + "')");
		Iterator<ExtEproduct> extit = extList.iterator();
		while (extit.hasNext()) {

			colno = -1;
			sheet = wb.getSheetAt(0); // 选择工作簿

			curRow++;

			ExtEproduct cProduct = extit.next();
			cProductRow = sheet.createRow((short) curRow - 1);
			cProductRow.setHeightInPoints(18);

			colno++;

			colno++;
			region = new Region(curRow, (short) (colno), curRow, (short) (colno + 2)); // 指定合并区域 合并单元格不会设置相同格式，例如划线
			sheet.addMergedRegion(region);

			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellValue(cProduct.getProductNo());
			cProductCell.setCellStyle(leftStyle(wb));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellValue(cProduct.getFactory().getFactoryName());
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellValue(cProduct.getPackingUnit());
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellValue(cProduct.getCnumber());
			cProductCell.setCellStyle(numberStyle(wb, abadiFont));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			if (UtilFuns.isNotEmpty(cProduct.getPrice())) {
				cProductCell = cProductRow.createCell((short) (colno));
				cProductCell.setCellValue(cProduct.getPrice().doubleValue());
				cProductCell.setCellStyle(number2Style(wb, abadiFont));
			}

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellFormula("G" + curRow + "*P" + curRow);
			cProductCell.setCellStyle(rmb2Style(wb, abadiFont));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(leftMoney(wb));

			pnum++;
		}

		
		//计算出不足一页时，补齐的画格子单元格行
		for (int j = 0; j < ptotalNum - pnum; j++) {
			colno = -1;

			curRow++;

			cProductRow = sheet.createRow((short) curRow - 1);
			cProductRow.setHeightInPoints(18);

			colno++;

			colno++;
			region = new Region(curRow, (short) (colno), curRow,(short) (colno + 2)); // 指定合并区域 合并单元格不会设置相同格式，例如划线
			sheet.addMergedRegion(region);

			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(leftStyle(wb));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(pioUtil.notehv10_BorderThin(wb, defaultFont10));

			colno++;
			cProductCell = cProductRow.createCell((short) (colno));
			cProductCell.setCellStyle(leftMoney(wb));
		}

		if (pnum > 0) { // 有记录时才输出

			stopRow = curRow;
			colno = 1;

			cProductRow = sheet.createRow((short) stopRow);
			cProductRow.setHeightInPoints(25);

			region = new Region(stopRow, (short) (colno), stopRow,
					(short) (colno + 2)); // 指定合并区域 合并单元格不会设置相同格式，例如划线
			sheet.addMergedRegion(region);

			cProductCell = cProductRow.createCell((short) (0));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bideStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("                  合  计 ");
			cProductCell.setCellStyle(bottomLeftStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUM(G" + startRow + ":G" + stopRow
					+ ")");
			cProductCell.setCellStyle(weightStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUM(H" + startRow + ":H" + stopRow
					+ ")");
			cProductCell.setCellStyle(weightStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUMPRODUCT(I" + startRow + ":I"
					+ stopRow + ",H" + startRow + ":H" + stopRow + ")"); // ∑(毛重x件数)
			cProductCell.setCellStyle(weightStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUMPRODUCT(J" + startRow + ":J"
					+ stopRow + ",H" + startRow + ":H" + stopRow + ")"); // ∑(净重x件数)
			cProductCell.setCellStyle(weightStyle(wb));

			region = new Region(stopRow, (short) (colno), stopRow,
					(short) (colno + 2)); // 指定合并区域 合并单元格不会设置相同格式，例如划线
			sheet.addMergedRegion(region);

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUMPRODUCT(H" + startRow + ":H" + stopRow + ",K" + startRow + ":K" + stopRow + ",L"
					+ startRow + ":L" + stopRow + ",M" + startRow + ":M" + stopRow + ")/100/100/100"); // 长x宽x高x件数 tip:
													// cm换算m3时要除以1000000，但excel报short
													// range错误，改为除以100三次即可
			cProductCell.setCellStyle(number2lStyle(wb, abadiFont));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUM(O" + startRow + ":O" + stopRow + ")");
			cProductCell.setCellStyle(usb2Style(wb, abadiFont));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellValue("");
			cProductCell.setCellStyle(bottomStyle(wb));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUM(Q" + startRow + ":Q" + stopRow + ")");
			cProductCell.setCellStyle(rmb2Style(wb, abadiFont));

			cProductCell = cProductRow.createCell((short) (colno++));
			cProductCell.setCellFormula("SUM(R" + startRow + ":R" + stopRow + ")");
			cProductCell.setCellStyle(rmb2Style(wb, abadiFont));

			// inputBy
			curRow++;
			nRow = sheet.createRow((short) curRow);
			nRow.setHeightInPoints(20);

			nCell = nRow.createCell((short) (15));
			nCell.setCellValue("制单：");
			nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));

			nCell = nRow.createCell((short) (16));
			nCell.setCellValue(finance.getInputBy());
			nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));
		}

		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(rootPath+sPath+sFile), sFile, response, true);
	}
	

	private HSSFCellStyle topStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setFontHeightInPoints((short) 12);
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 粗实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle leftStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 粗实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setWrapText(true); 									// 换行
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle money(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 粗实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setWrapText(true); 									// 换行
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle leftMoney(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,##0.00"));

		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setWrapText(true); 									// 换行
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle rightStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setWrapText(true); 									// 换行
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle weightStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###"));

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle bottomStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);				// 粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle bottomCenterStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle bottomLeftStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 粗实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 粗实线

		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle bottomRightStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 				// 实线
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 			// 粗实线
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 			// 实线
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 				// 实线

		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}

	private HSSFCellStyle bideStyle(HSSFWorkbook wb) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		HSSFFont curFont = wb.createFont(); 							// 设置字体
		curFont.setFontName("Times New Roman");
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET); 					// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 10);
		curStyle.setFont(curFont);

		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));

		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}
	
	private HSSFCellStyle generalStyle(HSSFWorkbook wb, HSSFFont abadiFont) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(abadiFont);
		curStyle.setDataFormat((short)0);								//通用格式			
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		return curStyle;
	}
	
	private HSSFCellStyle number1Style(HSSFWorkbook wb, HSSFFont abadiFont) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(abadiFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("####.0"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		return curStyle;
	}
	
	private HSSFCellStyle numberStyle(HSSFWorkbook wb, HSSFFont abadiFont) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(abadiFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("######"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		return curStyle;
	}
	
	private HSSFCellStyle number2Style(HSSFWorkbook wb, HSSFFont abadiFont) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(abadiFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,##0.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);	 // 单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		return curStyle;
	}
	
	private HSSFCellStyle number2lStyle(HSSFWorkbook wb, HSSFFont abadiFont) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(abadiFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("#,###,###.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		return curStyle;
	}
	
	private HSSFCellStyle rmb2Style(HSSFWorkbook wb, HSSFFont abadiFont) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(abadiFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("\"￥\"#,###,###.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		return curStyle;
	}
	
	private HSSFCellStyle usb2Style(HSSFWorkbook wb, HSSFFont abadiFont) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(abadiFont);
		
		HSSFDataFormat format = wb.createDataFormat();
		curStyle.setDataFormat(format.getFormat("\"$\"#,###,###.00"));
		
		curStyle.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中
		
		curStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		curStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		
		return curStyle;
	}

	public HSSFCellStyle invoiceNoStyle(HSSFWorkbook wb, HSSFFont defaultFont12) {
		HSSFCellStyle curStyle = wb.createCellStyle();
		curStyle.setFont(defaultFont12);
		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 	// 单元格垂直居中

		return curStyle;
	}	
}