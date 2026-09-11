package dto;

import java.io.Serializable;



public class Product implements Serializable {
	private String ProductId;
	private String pname;
	private int unitPrice;
	private String description;
	private String manufacturer;
	private String category;
	private long unitsInStock;
	private String condition;
	private String filename; //이지 업로드할 변수선언, 이미지 파일명
	private int quantity;
	
	public Product() {
		super();
	}


	public Product(String productId, String pname, int unitPrice) {
	    this.ProductId = productId;
	    this.pname = pname;
	    this.unitPrice = unitPrice;
	}

public String getProductId() {
    return ProductId;
}

public void setProductId(String productId) {
    ProductId = productId;
}

public String getFilename() {
	return filename;
}


public void setFilename(String filename) {
	this.filename = filename;
}


public String getPname() {
    return pname;
}

public void setPname(String pname) {
    this.pname = pname;
}

public int getUnitPrice() {
    return unitPrice;
}

public void setUnitPrice(int unitPrice) {
    this.unitPrice = unitPrice;
}

public String getDescription() {
    return description;
}

public void setDescription(String description) {
    this.description = description;
}

public String getManufacturer() {
    return manufacturer;
}

public void setManufacturer(String manufacturer) {
    this.manufacturer = manufacturer;
}

public String getCategory() {
    return category;
}

public void setCategory(String category) {
    this.category = category;
}

public long getUnitsInStock() {
    return unitsInStock;
}

public void setUnitsInStock(long unitsInStock) {
    this.unitsInStock = unitsInStock;
}

public String getCondition() {
    return condition;
}

public void setCondition(String condition) {
    this.condition = condition;
}
public int getQuantity() {
    return quantity;
}

public void setQuantity(int quantity) {
    this.quantity = quantity;
}

}





