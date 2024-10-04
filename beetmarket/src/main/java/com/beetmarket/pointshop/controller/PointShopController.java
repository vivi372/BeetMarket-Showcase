package com.beetmarket.pointshop.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.beetmarket.pointshop.service.PointShopService;
import com.beetmarket.pointshop.vo.PointShopVO;
import com.webjjang.util.file.FileUtil;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/pointShop")
@Log4j
public class PointShopController {
	
	@Autowired
	@Qualifier("PointShopServiceImpl")
	private PointShopService service;
	
	String path = "/upload/pointshop";	
	
	
	@GetMapping(value = "/list.do",produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> list(PointShopVO vo,String id,Integer gradeNo) {		
		
		log.info(gradeNo);
		log.info(id);
		
		return new ResponseEntity<>(service.list(vo,id,gradeNo), HttpStatus.OK);
	}
	
	@PostMapping(value = "/write.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> write(PointShopVO vo,
			@RequestPart(name = "goodsImageFile") MultipartFile goodsImageFile,HttpServletRequest request ) throws Exception {
		log.info(vo);
		log.info(goodsImageFile.getOriginalFilename());
		
		//파일 업로드 후 파일 경로 받아오기
		vo.setGoodsImage(FileUtil.upload(path, goodsImageFile, request));
		
		//등록을 위한 데이터 세팅
		List<PointShopVO> list = null;
		//입력된 재고가 0 이상일때만 재고 생성을 위한 리스트 생성
		if(vo.getGoodsStock() > 0) {
			for(int i=0;i<vo.getGoodsStock();i++) {
				if(list == null) list = new ArrayList<PointShopVO>();
				list.add(vo);
			}	
		} else {
			//재고가 0개 경우 vo를 한번만 넣는다.
			list = new ArrayList<PointShopVO>();
			list.add(vo);
		}
		
		try {
			service.write(list);
		} catch (Exception e) {
			e.printStackTrace();
			//등록 실패하면 파일 삭제
			FileUtil.remove(FileUtil.getRealPath("",vo.getGoodsImage(),request));
			return new ResponseEntity<String>("등록이 실패했습니다.", HttpStatus.BAD_REQUEST);
		}
		
		
		return new ResponseEntity<String>("정상적으로 등록되었습니다.", HttpStatus.OK);
	}
	
	@PostMapping(value = "/update.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> update(PointShopVO vo,String imageDeleteFile,
			@RequestPart(name = "goodsImageFile", required = false) MultipartFile goodsImageFile,HttpServletRequest request ) throws Exception {
		
		log.info(vo);
		
		if(goodsImageFile != null) {
			log.info(goodsImageFile.getOriginalFilename());
			imageDeleteFile = imageDeleteFile.substring(imageDeleteFile.indexOf("/upload"),imageDeleteFile.indexOf("?"));
			log.info(imageDeleteFile);
			//파일 업로드 후 파일 경로 받아오기
			vo.setGoodsImage(FileUtil.upload(path, goodsImageFile, request));			
		}
		
		
		try {
			service.update(vo);
		} catch (Exception e) {
			if(goodsImageFile != null) {
				e.printStackTrace();
				//수정 실패하면 입력한 파일 삭제
				FileUtil.remove(FileUtil.getRealPath("",vo.getGoodsImage(),request));				
			}
			return new ResponseEntity<String>("수정이 실패했습니다.", HttpStatus.BAD_REQUEST);
		}
		
		if(goodsImageFile != null) {
			//수정 성공시하면 기존 파일 삭제
			FileUtil.remove(FileUtil.getRealPath("",imageDeleteFile,request));				
		}
		
		return new ResponseEntity<String>(vo.getGoodsId()+"번 상품이 정상적으로 수정되었습니다.", HttpStatus.OK);
	}
	
	@PostMapping(value = "/updateStock.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> updateStock(PointShopVO vo,Long currentStock) throws Exception {
		
		log.info(vo);		
		log.info(currentStock);
		
		try {
			service.updateStock(vo,currentStock);
		} catch (Exception e) {		
			e.printStackTrace();
			return new ResponseEntity<String>("재고 수정이 실패했습니다.", HttpStatus.BAD_REQUEST);
		}
		
		
		return new ResponseEntity<String>(vo.getGoodsId()+"번 상품의 재고가 정상적으로 수정되었습니다.", HttpStatus.OK);
	}
	
	@GetMapping(value = "/delete.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(PointShopVO vo) throws Exception {
		
		log.info(vo);		
		
		
		service.delete(vo);	
		
		
		return new ResponseEntity<String>(vo.getGoodsId()+"번 상품이 "
		+((vo.getStopSell()==0)?"판매중지":"판매중지가 해제")+"되었습니다.", HttpStatus.OK);
	}
	
	@GetMapping(value = "/realDelete.do", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> realDelete(Long goodsId,String goodsImage,HttpServletRequest request) throws Exception {
		
		log.info(goodsId);		
		log.info(goodsImage);		
		
		
		
		try {
			service.realDelete(goodsId);
		} catch (Exception e) {
			//상품이 이미 팔린 경우 삭제가 불가능해 에러가 발생
			//상품이 삭제가 안 되었기 때문에 이미지를 삭제 x
			return new ResponseEntity<String>("삭제가 불가능한 물건입니다.", HttpStatus.OK);
		}
		
		//삭제된 경우 이미지도 같이 삭제한다.
		
		goodsImage = goodsImage.substring(goodsImage.indexOf("/upload"),goodsImage.indexOf("?"));
		
		FileUtil.remove(FileUtil.getRealPath("",goodsImage,request));
		
		
		return new ResponseEntity<String>(goodsId+"번 상품이 삭제 되었습니다.", HttpStatus.OK);
	}
	
}
