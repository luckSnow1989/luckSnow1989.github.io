package demo;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;

import org.junit.Test;


public class TestMain {
	

	

	/**
	 * 汉字转拼音-----全拼
	 * @param name 汉字
	 * @return 拼音
	 */
	private String HanyuToPinyin(String name) {
		String  pinyin = "";
		char[] nameChar = name.toCharArray();
		HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
		defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		for (int i = 0; i < nameChar.length; i++) {
			if (nameChar[i] > 128) {
				try {
					pinyin += PinyinHelper.toHanyuPinyinStringArray(
							nameChar[i], defaultFormat)[0];
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return pinyin;
	}
	/**
	 * 汉字转拼音-----首字母简写
	 * @param name 汉字
	 * @return 拼音
	 */
	private String HanyuToPinyinSimple(String name) {
		String  pinyin = "";
		char[] nameChar = name.toCharArray();
		HanyuPinyinOutputFormat defaultFormat = new HanyuPinyinOutputFormat();
		defaultFormat.setCaseType(HanyuPinyinCaseType.LOWERCASE);
		defaultFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		for (int i = 0; i < nameChar.length; i++) {
			if (nameChar[i] > 128) {
				try {
					pinyin += PinyinHelper.toHanyuPinyinStringArray(nameChar[i], defaultFormat)[0].substring(0, 1);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return pinyin;
	}
	public List<Station> getStationByProvince(List<Station> all){
		Map<String, Station> temp = new HashMap<String, Station>();
		for (Station station : all) {
			temp.put(station.getProvince(), station);
		}
		all.clear();
		for (Station station : temp.values()) {
			all.add(station);
		}
		return all;
	}

	/**
	 * 生成以城市为单位的站点信息
	 * @throws SQLException
	 */
	@Test
	public void test5() throws SQLException {
		Main m = new Main();
		List<Station> all = m.getAll();
		all = getStationByProvince(all);
		StringBuffer sb = new StringBuffer("[");
		for (int i = 0; i < all.size(); i++) {
			sb.append("\"" + all.get(i).getProvince()
					+ "|" +this.HanyuToPinyin(all.get(i).getProvince())
					+ "|" + this.HanyuToPinyinSimple(all.get(i).getProvince())
					+"\"");
			if (i < all.size() - 1) {
				sb.append(",");
			} 

		}
		sb.append("]");
		System.out.println(sb.toString());
		System.out.println(all.size());
	}
	/**
	 * 生成以城市为单位的站点信息
	 * @throws SQLException
	 */
	@Test
	public void test4() throws SQLException {
		Main m = new Main();
		List<Station> all = m.getAll();
		all = getStationByProvince(all);
		StringBuffer sb = new StringBuffer("[");
		for (int i = 0; i < all.size(); i++) {
			sb.append("{stationcode:\"" + all.get(i).getStationcode()
					+ "\",province:\"" + all.get(i).getProvince()
					+ "\",site:\"" + all.get(i).getSite() 
					+ "\",lat:\"" + all.get(i).getLat() 
					+ "\",lon:\"" + all.get(i).getLon()
					+ "\",pinyin:\"" +this.HanyuToPinyin(all.get(i).getProvince())
					+ "\",pinyinSimple:\"" + this.HanyuToPinyinSimple(all.get(i).getProvince())
					+ "\"}");
			if (i < all.size() - 1) {
				sb.append(",");
			} 

		}
		sb.append("]");
		System.out.println(sb.toString());
		System.out.println(all.size());
	}
	/**
	 * 生成全部站点信息
	 * @throws SQLException
	 */
	@Test
	public void test2() throws SQLException {
		Main m = new Main();
		List<Station> all = m.getAll();
		StringBuffer sb = new StringBuffer("[");
		for (int i = 0; i < all.size(); i++) {
			sb.append("{stationcode:\"" + all.get(i).getStationcode()
					+ "\",province:\"" + all.get(i).getProvince()
					+ "\",site:\"" + all.get(i).getSite() 
					+ "\",lat:\"" + all.get(i).getLat() 
					+ "\",lon:\"" + all.get(i).getLon()
					+ "\",pinyin:\"" +this.HanyuToPinyin(all.get(i).getProvince())
					+ "\",pinyinSimple:\"" + this.HanyuToPinyinSimple(all.get(i).getProvince())
					+ "\"}");
			if (i < all.size() - 1) {
				sb.append(",");
			} 

		}
		sb.append("]");
		System.out.println(sb.toString());
	}

}
