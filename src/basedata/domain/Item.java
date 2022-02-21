package basedata.domain;
/**
 * 物料实体类
 * @author Jiuyu
 *
 */

import dataDict.domain.ItemCategory;
import dataDict.domain.ItemUnit;

public class Item {
	private String no;
	private String name;
	private String spec;
	private String pattern;
	private ItemCategory itemCategory;
	private ItemUnit itemUnit;
	private String fileName;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSpec() {
		return spec;
	}
	public void setSpec(String spec) {
		this.spec = spec;
	}
	public String getPattern() {
		return pattern;
	}
	public void setPattern(String pattern) {
		this.pattern = pattern;
	}
	public ItemCategory getItemCategory() {
		return itemCategory;
	}
	public void setItemCategory(ItemCategory itemCategory) {
		this.itemCategory = itemCategory;
	}
	public ItemUnit getItemUnit() {
		return itemUnit;
	}
	public void setItemUnit(ItemUnit itemUnit) {
		this.itemUnit = itemUnit;
	}
	public Item(String no, String name, String spec, String pattern, ItemCategory itemCategory, ItemUnit itemUnit) {
		super();
		this.no = no;
		this.name = name;
		this.spec = spec;
		this.pattern = pattern;
		this.itemCategory = itemCategory;
		this.itemUnit = itemUnit;
	}
	public Item() {
		super();
	}
	
}
