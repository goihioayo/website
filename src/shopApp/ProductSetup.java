package shopApp;


public class ProductSetup {
	private int proID;
	private String proName;
	private String proCatName;
	private int proCatID;
	private String SKU;
	private int proPrice;
	private int proQuantity;
	
	

	public ProductSetup(int proID, String proName, String proCatName, int proCatID, String SKU, int proPrice ) {
		this.proID = proID;
		this.proName = proName;
		this.proCatID = proCatID;
		this.proCatName = proCatName;
		this.SKU = SKU;
		this.proPrice = proPrice;
	}
	
	public ProductSetup(String proName, int proPrice, int proQuantity) {
		this.proName = proName;
		this.proPrice = proPrice;
		this.proQuantity = proQuantity;	
	}
	
	
	
	public int getProID() {
		return proID;
	}
	
	public void setProID( int id ) {
		proID = id;
	}
	
	public String getProName() {
		return proName;
	}
	
	public void setProName( String name ) {
		proName = name;
	}
	public String getProCatName() {
		return proCatName;
	}
	
	public void setProCatName( String name ) {
		proCatName = name;
	}
	
	public int getProCatID() {
		return proCatID;
	}
	
	public void setProCatID(int id ) {
		proCatID = id;
	}
	
	public String getSKU() {
		return SKU;
	}
	
	public void setSKU( String sku ) {
		SKU = sku;
	}
	
	public int getProPrice() {
		return proPrice;
	}
	
	public void setProPrice( int price ) {
		proPrice = price;
	}
	
	public int getQuantity() {
		return proQuantity;
	}

	public void setQuantity(int quantity) {
		this.proQuantity = quantity;
	}

}
