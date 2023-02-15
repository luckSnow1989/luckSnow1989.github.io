package cn.itcast.mybatis.domain;

public class Order {

	private String oid;
	private String oNO;
	private Integer oPrice;
	
	private Person p;

	/**
	 * @return the oid
	 */
	public final String getOid() {
		return oid;
	}

	/**
	 * @param oid the oid to set
	 */
	public final void setOid(String oid) {
		this.oid = oid;
	}

	/**
	 * @return the oNO
	 */
	public final String getONO() {
		return oNO;
	}

	/**
	 * @param ono the oNO to set
	 */
	public final void setONO(String ono) {
		oNO = ono;
	}

	/**
	 * @return the oPrice
	 */
	public final Integer getOPrice() {
		return oPrice;
	}

	/**
	 * @param price the oPrice to set
	 */
	public final void setOPrice(Integer price) {
		oPrice = price;
	}

	/**
	 * @return the p
	 */
	public final Person getP() {
		return p;
	}

	/**
	 * @param p the p to set
	 */
	public final void setP(Person p) {
		this.p = p;
	}
	
}
