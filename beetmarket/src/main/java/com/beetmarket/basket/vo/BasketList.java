package com.beetmarket.basket.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * ArrayList<BasketVO>를 상속 받아 메서드를 추가해 확장한 클래스
 */
public class BasketList extends ArrayList<BasketVO>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 하나에 뒤섞여있는 장바구니와 장바구니 옵션를 나누어주는 메서드
	 * @return 옵션 정보가 담겨있는 리스트
	 */
	public List<BasketOptVO> splitList() {
		//옵션 정보를 담는 리스트
		List<BasketOptVO> optList = new ArrayList<>();
		//자신에 담겨있는 정보를 꺼내 옵션 리스트에 담는다.
		for(BasketVO vo: this) {
			BasketOptVO opt = new BasketOptVO();
			opt.setOptName(vo.getOptName());
			opt.setGoodsPrice(vo.getGoodsPrice());
			opt.setOptPrice(vo.getOptPrice());
			opt.setOptNo(vo.getOptNo());
			opt.setAmount(vo.getAmount());
			opt.setBasketNo(vo.getBasketNo());
			optList.add(opt);			
		}
		//이전 순서의 vo와 현재 순서의 vo의 담겨있는 장바구니 정보가 같으면 현재 vo를 리스트에서 제거한다.
		if(this.get(0).getBasketNo() != null) {
			//조인할때 생기는 더미 데이터를 지운다.
			for(int i=this.size()-1; i >= 1; i--) {				
				if(this.get(i).getBasketNo().equals(this.get(i-1).getBasketNo())) {				
					this.remove(i);				
				}
			}			
		}
		
		
		return optList;
	}
	

}
