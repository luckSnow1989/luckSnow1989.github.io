package cn.itcast.web.struts2.cargo.shippingorder;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.Region;
import org.apache.struts2.ServletActionContext;

import cn.itcast.entity.Export;
import cn.itcast.entity.PackingList;
import cn.itcast.entity.ShippingOrder;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.entity.dao.PackingListDAO;
import cn.itcast.entity.dao.ShippingOrderDAO;
import cn.itcast.web.common.util.DownloadBaseAction;
import cn.itcast.web.common.util.NumberToWords;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.common.util.file.FileUtil;
import cn.itcast.web.common.util.file.PioUtil;
import cn.itcast.web.struts2._BaseStruts2Action;

import com.opensymphony.xwork2.ModelDriven;

public class ShippingOrderAction extends _BaseStruts2Action implements ModelDriven<ShippingOrder> {
	private ShippingOrder model = new ShippingOrder();
	public ShippingOrder getModel() {
		return model;
	}

	//保存
	public String save() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		
		String id = request.getParameter("id");			//packinglist id
		request.setAttribute("id",id);
		
		String subid = request.getParameter("subid");	//shippingorder id

		String orderType = request.getParameter("orderType");
		String shipper = request.getParameter("shipper");
		String consignee = request.getParameter("consignee");
		String notifyParty = request.getParameter("notifyParty");
		String lcno = request.getParameter("lcno");
		String portOfLoading = request.getParameter("portOfLoading");
		String portOfTrans = request.getParameter("portOfTrans");
		String loadingDate = request.getParameter("loadingDate");
		String portOfDischarge = request.getParameter("portOfDischarge");
		String limitDate = request.getParameter("limitDate");
		String isBatch = request.getParameter("isBatch");
		String isTrans = request.getParameter("isTrans");
		String copyNum = request.getParameter("copyNum");
		String cnote = request.getParameter("cnote");
		String specialCondition = request.getParameter("specialCondition");
		String freight = request.getParameter("freight");
		String checkBy = request.getParameter("checkBy");

		
		PackingListDAO mDao = (PackingListDAO)super.getDao("daoPackingList");
		PackingList packing = (PackingList)mDao.get(PackingList.class, id);
		
		ShippingOrderDAO oDao = (ShippingOrderDAO) this.getDao("daoShippingOrder");
		ShippingOrder obj = null;
		if(UtilFuns.isNotEmpty(subid)){
			obj = (ShippingOrder)oDao.get(ShippingOrder.class, subid);
		}else{
			obj = new ShippingOrder();
			obj.setId(id);		//same as packinglist id
			subid = obj.getId();
		}
		
		obj.setOrderType(orderType);
		obj.setShipper(shipper);
		obj.setConsignee(consignee);
		obj.setNotifyParty(notifyParty);
		obj.setLcno(lcno);
		obj.setPortOfLoading(portOfLoading);
		obj.setPortOfTrans(portOfTrans);
		obj.setPortOfDischarge(portOfDischarge);
		if(UtilFuns.isNotEmpty(loadingDate)){
			obj.setLoadingDate(UtilFuns.parseDate(loadingDate));
		}
		if(UtilFuns.isNotEmpty(limitDate)){
			obj.setLimitDate(UtilFuns.parseDate(limitDate));
		}
		obj.setIsBatch(isBatch);
		obj.setIsTrans(isTrans);
		obj.setCopyNum(copyNum);
		obj.setCnote(cnote);
		obj.setSpecialCondition(specialCondition);
		obj.setFreight(freight);
		obj.setCheckBy(checkBy);
		
		if(UtilFuns.isNotEmpty(packing.getExportIds())){
			String[] exportId = UtilFuns.splitStr(packing.getExportIds(), "|");
			if(UtilFuns.isNotEmpty(exportId)){
				ExportDAO eDao = (ExportDAO)super.getDao("daoExport");
				Export export = null;
				Set eSet = new HashSet();
				for(int i=0;i<exportId.length;i++){
					export = (Export)eDao.get(Export.class, exportId[i]);
					export.setDestinationPort(portOfDischarge);		//目的港就是委托中填报的卸货港
					export.setState(3);								//设置为：委托 	tip:利用hibernate自动提交机制，无需显式的保存export对象，即可保存其改变。一定要慎用。
					eSet.add(export);
				}
				eDao.saveOrUpdateAll(eSet);
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
				throw new Exception("请先填写装箱信息（发票号、发票时间、卖家、买家等）, 保存后再点击【委托】!");
			}
			
			ShippingOrder obj = mobj.getShippingOrder();		//关联one-to-one
			request.setAttribute("obj",obj);
		}
		
		return "pedit";
	}

	public void print() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		String id = request.getParameter("id");
		ShippingOrderDAO oDao = (ShippingOrderDAO) this.getDao("daoShippingOrder");
		ShippingOrder obj = (ShippingOrder)oDao.get(ShippingOrder.class, id);

		if (obj == null) {
			throw new Exception("请先填写委托信息（提单抬头、正本通知人等）, 保存后再点击打印!");
		}
		UtilFuns utilFuns = new UtilFuns();
		String rootPath = utilFuns.getROOTPath();
		
		String tempXlsFile = rootPath + "make/xlsprint/tSHIPPINGORDER.xls";

		FileUtil fu = new FileUtil();
		String sPath = "/web/tmpfile/" + UtilFuns.sysDate() + "/";
		String sFile = fu.newFile(rootPath + sPath, "shippingorder.xls");
		fu.makeDir(rootPath + sPath);

		String outFile = rootPath + sPath + sFile;

		PioUtil pioUtil = new PioUtil();
		HSSFWorkbook wb = new HSSFWorkbook(new FileInputStream(tempXlsFile));
		HSSFFont defaultFont10 = pioUtil.defaultFont10Blod(wb); // 设置字体

		HSSFSheet sheet = wb.getSheetAt(0); // 选择第一个工作簿
		wb.setSheetName(0, "委托单"); // 设置工作簿的名称

		// sheet.setDefaultColumnWidth((short) 20); // 设置每列默认宽度

		// POI分页符有BUG，必须在模板文件中插入一个分页符，然后再此处删除预设的分页符；最后在下面重新设置分页符。
		sheet.setAutobreaks(false);
		// //int iRowBreaks[] = sheet.getRowBreaks();
		// sheet.removeRowBreak(3);
		// sheet.removeRowBreak(4);
		// sheet.removeRowBreak(5);
		// sheet.removeRowBreak(6);

		HSSFRow nRow = null;
		HSSFCell nCell = null;
		int curRow = 4;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(24);

		nCell = nRow.createCell((short) (0));
		nCell.setCellValue(obj.getShipper());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));

		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(24);

		nCell = nRow.createCell((short) (0));
		nCell.setCellValue(obj.getConsignee());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));

		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(24);

		nCell = nRow.createCell((short) (6));
		if (obj.getOrderType() != null && obj.getOrderType().equals("1")) {
			nCell.setCellValue("空 运 委 托 单");
		} else {
			nCell.setCellValue("海 运 委 托 单");
		}
		nCell.setCellStyle(font20Style(wb));

		curRow++;
		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(60);

		nCell = nRow.createCell((short) (0));
		nCell.setCellValue(obj.getNotifyParty());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));

		curRow++;

		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (0));
		nCell.setCellValue(obj.getPackingList().getInvoiceNo());
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (3));
		nCell.setCellValue(UtilFuns.formatDateEN(UtilFuns.dateTimeFormat(obj.getPackingList().getInvoiceDate())));
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (6));
		nCell.setCellValue(obj.getLcno());
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		curRow++;
		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (0));
		nCell.setCellValue(obj.getPortOfLoading());
		nCell.setCellStyle(pioUtil.noterv10NoWrap(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (3));
		nCell.setCellValue(obj.getPortOfTrans());
		nCell.setCellStyle(pioUtil.noterv10NoWrap(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (6));
		nCell.setCellValue(obj.getPortOfDischarge());
		nCell.setCellStyle(pioUtil.noterv10NoWrap(wb, defaultFont10));

		curRow++;
		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (0));
		nCell.setCellValue(UtilFuns.formatDateEN(UtilFuns.dateTimeFormat(obj.getLoadingDate())));
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (2));
		nCell.setCellValue(UtilFuns.formatDateEN(UtilFuns.dateTimeFormat(obj.getLimitDate())));
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		if (UtilFuns.isNotEmpty(obj.getIsBatch())&& obj.getIsBatch().equals("1")) {
			nRow = sheet.createRow((short) curRow - 1);
			nRow.setHeightInPoints(16);

			nCell = nRow.createCell((short) (3));
			nCell.setCellValue("YES");
			nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
		}

		if (UtilFuns.isNotEmpty(obj.getIsTrans())&& obj.getIsTrans().equals("1")) {
			nRow = sheet.createRow((short) curRow - 1);
			nRow.setHeightInPoints(16);

			nCell = nRow.createCell((short) (5));
			nCell.setCellValue("YES");
			nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
		}

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(16);

		nCell = nRow.createCell((short) (7));
		nCell.setCellValue(obj.getCopyNum());
		nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		curRow++;
		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		float height = pioUtil.getCellAutoHeight(obj.getPackingList().getMarks(), 12f); 				// 自动高度
		nRow.setHeightInPoints(height);

		nCell = nRow.createCell((short) (0));
		nCell.setCellValue(obj.getPackingList().getMarks());
		nCell.setCellStyle(pioUtil.notehlv10(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		float heightDesc = pioUtil.getCellAutoHeight(obj.getPackingList().getDescriptions(), 12f); 		// 自动高度
		nRow.setHeightInPoints(heightDesc);

		nCell = nRow.createCell((short) (3));
		nCell.setCellValue("\n" + obj.getPackingList().getDescriptions());
		nCell.setCellStyle(pioUtil.notevt10(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(height);
		
		
		double _grossWeight = 0;						//毛重
		BigDecimal _csize = new BigDecimal(0);			//体积
		int _boxNum = 0;								//箱数
		
		//计算统计值	
		if(UtilFuns.isNotEmpty(obj.getPackingList().getExportIds())){
			String[] exportId = UtilFuns.splitStr(obj.getPackingList().getExportIds(), "|");
			if(UtilFuns.isNotEmpty(exportId)){
				ExportDAO eDao = (ExportDAO)super.getDao("daoExport");
				Export export = null;
				for(int i=0;i<exportId.length;i++){
					export = (Export)eDao.get(Export.class, exportId[i]);
					export.setDestinationPort(obj.getPortOfDischarge());		//目的港就是委托中填报的卸货港
					export.setState(3);		//设置为：委托 tip:利用hibernate自动提交机制，无需显式的保存export对象，即可保存其改变。一定要慎用。
					
					//[重点]分布计算，在报运货物保存时，计算合计存入报运信息中
					_grossWeight += export.getGrossWeight().doubleValue();
					_csize = _csize.add(export.getCsize());
					_boxNum += export.getBoxNum();
				}
			}
		}			

			nCell = nRow.createCell((short) (5));
			nCell.setCellValue(UtilFuns.convertNull(_boxNum)+ "CTNS");						//单元格变为字符串类型
			nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(height);

			nCell = nRow.createCell((short) (6));
			nCell.setCellValue(String.valueOf(_grossWeight).replace(".0", "")+ "KGS");		//del .0
			nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(height);

			nCell = nRow.createCell((short) (8));
			nCell.setCellValue(String.valueOf(_csize.setScale(2, RoundingMode.HALF_UP))+ "M3");	//四舍五入 保留2位小数
			nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));

		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(18);
		
		Region regionFreight = new Region(curRow-1, (short) (5), curRow-1, (short) (5 + 1)); // 指定合并区域
		sheet.addMergedRegion(regionFreight);

			nCell = nRow.createCell((short) (5));
			nCell.setCellValue(obj.getFreight());
			nCell.setCellStyle(pioUtil.notehv10(wb, defaultFont10));
		
		curRow++;
		
		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(18);
		
		nCell = nRow.createCell((short) (1));
		NumberToWords ntw = new NumberToWords();		//规格文字
		nCell.setCellValue("say:"+ ntw.convert(_boxNum).toUpperCase() + " Only.");
		nCell.setCellStyle(pioUtil.normalv10(wb, defaultFont10));

		curRow++;
		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(38);

		nCell = nRow.createCell((short) (1));
		nCell.setCellValue(obj.getSpecialCondition());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));

		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;
		curRow++;

		nRow = sheet.createRow((short) curRow - 1);
		nRow.setHeightInPoints(24);

		nCell = nRow.createCell((short) (7));
		nCell.setCellValue(obj.getCheckBy());
		nCell.setCellStyle(pioUtil.noterv10(wb, defaultFont10));

		FileOutputStream fOut = new FileOutputStream(outFile);
		wb.write(fOut);
		fOut.flush();
		fOut.close();
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		DownloadBaseAction down = new DownloadBaseAction();
		down.prototypeDowload(new File(rootPath+sPath+sFile), "委托单.xls", response, true);
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

}
