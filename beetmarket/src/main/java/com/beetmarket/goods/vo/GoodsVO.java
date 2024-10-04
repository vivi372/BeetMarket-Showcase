package com.beetmarket.goods.vo;

import lombok.Data;

@Data
public class GoodsVO {

	// category
	private Integer cateHighNo;
	private Integer cateMidNo;
	private Integer cateLowNo;
	private String categoryName;
	
	// goods
	private Long goodsNo;
	private String goodsName;
	private String goodsMainImage;
	private String goodsConImage;
	private String goodsContent;
	private Long goodsHit;
	private Long goodsOriPrice;
	private Long goodsDiscRate;
	private Long goodsDiscount;
	private Long goodsPrice;
	private Long goodsSavings;
	private Long goodsSaveRate;
	
	// goodsOption
	private Long goodsOptNo;
	private Long goodsOptPrice;
	private String goodsOptName;
	
	// goodsInfo
	private Long goodsIngoNo;
	private String goodsInfoName;
	private String goodsInfoCon;
	
	// goodsImage
	private Long goodsImageNo;
	private String goodsImageName;
	
	// goodsLike
	private Long goodsLikeNo;
	
	// goodsStatus
	private Long goodsStatusNo;
	private String goodsStatusName;
	
	// foringKey
	private String id;
	private String store_name;
	private Long merchant_delivery;
	private Long free_ship_limit;
	private Integer sell_no;
	
}
