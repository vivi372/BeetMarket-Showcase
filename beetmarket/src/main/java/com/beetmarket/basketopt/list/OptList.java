package com.beetmarket.basketopt.list;

import java.util.ArrayList;

import com.beetmarket.basket.vo.AjaxOptVO;




public class OptList extends ArrayList<AjaxOptVO> {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private int maxOptSize = 0;

	public ArrayList<String> getOptNames() {
		ArrayList<String> optNames = new ArrayList<String>();
		
		for(int i=0;i<this.size();i++) {
			optNames.add(this.get(i).getOptName());
		}
		
		return optNames;
	}
	
	public void calMaxOptSize() {
		for(AjaxOptVO vo:this) {
			if(vo.getOptNo() == null) break;
			int tempSize = vo.getOptNames().length;
			if(maxOptSize<tempSize)
			maxOptSize = tempSize;
		}
	}
	
	public int getMaxOptSize() {
		return maxOptSize;
	}
	
	
}