package cn.itcast.web.struts2.cargo.shippingorder;

import java.util.HashSet;
import java.util.Set;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

import cn.itcast.entity.Export;
import cn.itcast.entity.PackingList;
import cn.itcast.entity.ShippingOrder;
import cn.itcast.entity.dao.ExportDAO;
import cn.itcast.entity.dao.PackingListDAO;
import cn.itcast.entity.dao.ShippingOrderDAO;
import cn.itcast.web.common.util.UtilFuns;
import cn.itcast.web.struts2._BaseStruts2Action;

public class ShippingOrderAction extends _BaseStruts2Action implements ModelDriven<ShippingOrder>{
	private ShippingOrder model = new ShippingOrder();
	public ShippingOrder getModel() {
		return model;
	}
	private String subid;
	public String getSubid() {
		return subid;
	}
	public void setSubid(String subid) {
		this.subid = subid;
	}

	//转向编辑页面
	public String toedit(){
		ShippingOrderDAO oDao = (ShippingOrderDAO) this.getDao("daoShippingOrder");
		ShippingOrder obj = (ShippingOrder) oDao.get(ShippingOrder.class, model.getId());		//得到的是装箱
		ActionContext.getContext().put("obj", obj);
		
		return "pedit";
	}
	
	//保存
	public String save(){
		ShippingOrderDAO oDao = (ShippingOrderDAO) this.getDao("daoShippingOrder");
		
		//新增
		if(UtilFuns.isEmpty(this.getSubid())){
			//改变报运的状态
			PackingListDAO pDao = (PackingListDAO) this.getDao("daoPackingList");
			PackingList obj = (PackingList) pDao.get(PackingList.class, model.getId());
			String[] exportIds = UtilFuns.splitStr(obj.getExportIds(), "|");			//报运ID集合
			
			ExportDAO eDao = (ExportDAO) this.getDao("daoExport");
			Export ep = null;
			Set oSet = new HashSet();
			for(int i=0;i<exportIds.length;i++){
				ep = (Export) eDao.get(Export.class, exportIds[i]);
				ep.setState(3);		//0-草稿 1-已上报 2-装箱 3-委托 4-发票 5-财务
				
				oSet.add(ep);
			}
			eDao.saveOrUpdateAll(oSet);
			
		}
		
		oDao.saveOrUpdate(model);
		
		return toedit();
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
		if (obj.getOrderType() != null && obj.getOrderType().equals("AIR")) {
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
					
					//[重点]分布计算，在报运货物保存时，计算合计存入报运信息中
					//直接取得报运中的冗余合计值，而不是计算报运对应的货物值，然后累加。那样实现无错，但效率极低
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
		HSSFFont curFont = wb.createFont();				// 设置字体
		curFont.setCharSet(HSSFFont.DEFAULT_CHARSET);	// 设置中文字体，那必须还要再对单元格进行编码设置
		curFont.setFontHeightInPoints((short) 20);
		curStyle.setFont(curFont);

		curStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		curStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); // 单元格垂直居中

		return curStyle;
	}

}
