package shopApp;

public class CategorySetup {
	private int catID;
	private String catName;
	private String catDescript;
	private int num;
	
	public CategorySetup(int catID, String catName, String catDescript, int num ) {
		this.catID = catID;
		this.catName = catName;
		this.catDescript = catDescript;
		this.num = num;
	}
	
	public int getCatID() {
		return catID;
	}
	
	public void setCatID( int id ) {
		catID = id;
	}
	
	public String getCatName() {
		return catName;
	}
	
	public void setCatName( String name ) {
		catName = name;
	}
	
	public String getCatDescrip() {
		return catDescript;
	}
	
	public void setCatDescrip( String descript ) {
		catDescript = descript;
	}
	
	public int getNum() {
		return num;
	}
	
	public void setNum( int newNum ) {
		num = newNum;
	}

}
