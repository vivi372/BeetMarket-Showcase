package com.beetmarket.order.service;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.beetmarket.goods.mapper.GoodsMapper;
import com.beetmarket.member.mapper.MemberMapper;
import com.beetmarket.member.vo.PointVO;
import com.beetmarket.order.mapper.OrderMapper;

import com.beetmarket.order.vo.OrderVO;
import com.beetmarket.order.vo.SearchVO;
import com.beetmarket.pointshop.vo.PointShopVO;
import com.beetmarket.pointshoporder.mapper.PointShopOrderMapper;
import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Qualifier("OrderServiceImpl")
@Log4j
public class OrderServiceImpl implements OrderService {
	
	@Setter(onMethod_ = @Autowired)
	OrderMapper mapper;
	@Setter(onMethod_ = @Autowired)
	GoodsMapper goodsMapper;
	@Setter(onMethod_ = @Autowired)
	PointShopOrderMapper shopOrderMapper;
	@Setter(onMethod_ = @Autowired)
	MemberMapper memberMapper;

	@Override
	public List<OrderVO> orderList(PageObject pageObject,SearchVO searchVO) {
		
		//페이지의 최대 수를 가져오기
		pageObject.setTotalRow(mapper.totalRow(pageObject,searchVO));			
		
		
		return mapper.orderList(pageObject,searchVO);
	}
	
	//주문관리 리스트
	@Override
	public Map<String , List<OrderVO>> adminList(PageObject pageObject,String id,SearchVO searchVO){
		Map<String , List<OrderVO>> map = new HashMap<String, List<OrderVO>>();		
		
		pageObject.setTotalRow(mapper.adminTotalRow(searchVO));
		map.put("list", mapper.adminList(pageObject,searchVO));
		if(id != null) {
			map.put("goodsList", mapper.getGoods(id));			
		}
		
		return map;
	}
	
	//주문 상세 보기
	@Override
	public OrderVO view(Long orderNo) {
		return mapper.view(orderNo);
	}

	@Override
	public Map<String, Object> writeFrom(Long[] goodsNos, Long[] optNos) {
		Map<String, Object> map = new HashMap<>();
		
		//상품 정보 가져오기
		map.put("goodsList", mapper.getGoodsList(goodsNos));
		//옵션 정보 가져오기
		map.put("optList", mapper.getOptList(optNos));		
		
		
		return map;
	}
	//쿠폰 정보 가져오기
	@Override
	public List<PointShopVO> getCouponList(String id){
		
		return mapper.getCouponList(id);
		
	}
	
	//멤버쉽 적립율 가져오기
	@Override
	public Integer getSale_rate(String id){
		return mapper.getSale_rate(id);
	}
	
	@Override
	@Transactional
	public Integer write(List<OrderVO> list) {
		//주문 등록
		int result = mapper.write(list);
		log.info(list.get(0).getStockNo());
		if(list.get(0).getStockNo()!=null)
			//쿠폰 상태 변경
			shopOrderMapper.stockStateUpdate(new Long[]{list.get(0).getStockNo()}, "사용완료");
		//조회수 증가
		for(OrderVO vo:list) {
			goodsMapper.increase(vo.getGoodsNo(), 10L);			
		}
		return result;
	}
	
	//배송지 변경
	@Override
	public Integer dlvyUpdate(OrderVO vo) {
		
		return mapper.dlvyUpdate(vo);
	}
	
	//주문 상태 변경
	@Override
	@Transactional
	public Integer stateUpdate(OrderVO vo,Long[] orderNos,String id) {
		//주문 상태 변경
		Integer result = mapper.stateUpdate(vo, orderNos);
		//구매확정시 포인트 지급
		if(vo.getOrderState().equals("구매확정")) {
			PointVO pointVO = new PointVO();
			//구매확정은 한번에 하나씩만 가능하기 때문에 0번값만 가져와 입력
			pointVO.setPoint_delta(mapper.getSavings(orderNos[0]));
			pointVO.setPoint_entity("주문 구매 확정");
			pointVO.setId(id);
			memberMapper.pointWrite(pointVO);
		}
		//요청처리시 쿠폰 환불
		if(vo.getOrderState().equals("요청처리")) {
			Long couponNo = 0L;
			mapper.refundCoupon(orderNos[0], couponNo);
			mapper.refundCoupon2(orderNos[0], couponNo);
		}
		
		return result;
	}
	
	//주문 삭제
	@Override
	public Integer delete(Long orderNo) {
		return mapper.delete(orderNo);
	}

}
