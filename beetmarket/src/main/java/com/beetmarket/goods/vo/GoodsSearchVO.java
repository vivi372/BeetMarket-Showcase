package com.beetmarket.goods.vo;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import lombok.Data;

@Data
public class GoodsSearchVO {

	private Integer cateHighNo; // 대분류 검색 - 상품 등록
	private Integer cateMidNo; // 중분류 검색 - 상품 등록
	private Integer cateLowNo; // 중분류 검색 - 상품 등록
	private String goodsName; // 상품명에 포함되어 있는 문자 검색
	private Integer desc; // 중분류 검색 - 상품 등록

	// 기본 생성자, getter, setter, toString 등 외에 필요한 메서드는 더 추가해서 사용가능
	// url뒤에 위에 5개의 데이터를 붙여서 리턴하는 메서드 작성
	public String getQuery() throws Exception {
		return "cateHighNo=" + toStr(cateHighNo) + "&cateMidNo=" + toStr(cateMidNo) + "&cateLowNo=" + toStr(cateLowNo)
				+ "&goodsName=" + URLEncoder.encode(toStr(goodsName), "utf-8") + "&desc=" + toStr(desc);
	}

	// uri를 만들어서 사용하는데
	private String toStr(Object obj) throws Exception {
		return (obj == null) ? "" : obj.toString();
	}

	// 검색 데이터가 존재하는지 확인하는 메서드 - return type이 boolean인 경우 get 대신 is를 붙인다.
	public Boolean isExist() {
		if (cateHighNo != null && cateHighNo != 0)
			return true;
		if (!(goodsName == null || goodsName == ""))
			return true;
		return false;
	}

}
