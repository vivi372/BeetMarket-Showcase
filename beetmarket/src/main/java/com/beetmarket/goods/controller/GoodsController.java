package com.beetmarket.goods.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
// import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.category.service.CategoryService;
import com.beetmarket.goods.service.GoodsService;
import com.beetmarket.goods.vo.GoodsImageVO;
import com.beetmarket.goods.vo.GoodsInfoVO;
import com.beetmarket.goods.vo.GoodsOptionVO;
import com.beetmarket.goods.vo.GoodsSearchVO;
import com.beetmarket.goods.vo.GoodsVO;
import com.beetmarket.member.vo.LoginVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/goods")
@Log4j
public class GoodsController {

	// 자동 DI
	// @Setter(onMethod_ = @Autowired)
	// Type이 같으면 식별할 수 있는 문자열 지정 - id를 지정
	@Autowired
	@Qualifier("goodsServiceImpl")
	private GoodsService service;

	@Autowired
	@Qualifier("categoryServiceImpl")
	private CategoryService categoryService;

	String path = "/upload/goods";

	// --- 상품 리스트 ------------------------------------
	@GetMapping("/list.do")
	// 검색을 위한 데이터를 따로 받아야 한다.
	// @ModelAttribute() - 전달받는 데이터를 Model에 담아서 바로 JSP까지 보낼 때 사용
	// 속성명을 보통 타입으로 사용한다. name = "searchVO" 설정해서 변경해서 사용
	public String list(Model model, @ModelAttribute(name = "searchVO") GoodsSearchVO searchVO,
			HttpServletRequest request) throws Exception {

		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);

		// 한 페이지당 보여주는 데이터의 개수가 없으면 기본은 8로 정한다.
		String strPerPageNum = request.getParameter("perPageNum");
		if (strPerPageNum == null || strPerPageNum.equals(""))
			pageObject.setPerPageNum(6);

		// 대분류를 가져와서 JSP로 넘기기.
		model.addAttribute("bigList", categoryService.list(0));

		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject, searchVO));
		// pageObject에 데이터 가져 오기 전에는 시작 페이지, 끝 페이지, 전체 페이지가 정해지지 않는다.
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		// model.addAttribute("searchVO", searchVO);
		// 검색에 대한 정보도 넘겨야 한다.
		return "goods/list";

	}

	// --- 판매자 상품 리스트 ------------------------------------
	@GetMapping("/sellList.do")
	// 검색을 위한 데이터를 따로 받아야 한다.
	// @ModelAttribute() - 전달받는 데이터를 Model에 담아서 바로 JSP까지 보낼 때 사용
	// 속성명을 보통 타입으로 사용한다. name = "searchVO" 설정해서 변경해서 사용
	public String sellList(Model model, @ModelAttribute(name = "searchVO") GoodsSearchVO searchVO,
			HttpServletRequest request, HttpSession httpSession) throws Exception {

		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);

		// 한 페이지당 보여주는 데이터의 개수가 없으면 기본은 8로 정한다.
		String strPerPageNum = request.getParameter("perPageNum");
		if (strPerPageNum == null || strPerPageNum.equals(""))
			pageObject.setPerPageNum(6);

		// 대분류를 가져와서 JSP로 넘기기.
		model.addAttribute("bigList", categoryService.list(0));

		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("sellList",
				service.sellList(pageObject, searchVO, (long) LoginUtil.getSell_no(httpSession)));
		// pageObject에 데이터 가져 오기 전에는 시작 페이지, 끝 페이지, 전체 페이지가 정해지지 않는다.
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		// model.addAttribute("searchVO", searchVO);
		// 검색에 대한 정보도 넘겨야 한다.
		return "goods/sellList";

	}

	// --- 상품 리스트 ------------------------------------
	@GetMapping("/adminList.do")
	// 검색을 위한 데이터를 따로 받아야 한다.
	// @ModelAttribute() - 전달받는 데이터를 Model에 담아서 바로 JSP까지 보낼 때 사용
	// 속성명을 보통 타입으로 사용한다. name = "searchVO" 설정해서 변경해서 사용
	public String adminList(Model model, @ModelAttribute(name = "searchVO") GoodsSearchVO searchVO,
			HttpServletRequest request) throws Exception {

		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);

		// 한 페이지당 보여주는 데이터의 개수가 없으면 기본은 8로 정한다.
		String strPerPageNum = request.getParameter("perPageNum");
		if (strPerPageNum == null || strPerPageNum.equals(""))
			pageObject.setPerPageNum(6);

		// 대분류를 가져와서 JSP로 넘기기.
		model.addAttribute("bigList", categoryService.list(0));

		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("adminList", service.adminList(pageObject, searchVO));
		// pageObject에 데이터 가져 오기 전에는 시작 페이지, 끝 페이지, 전체 페이지가 정해지지 않는다.
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		// model.addAttribute("searchVO", searchVO);
		// 검색에 대한 정보도 넘겨야 한다.
		return "goods/adminList";

	}

	// --- 상품 리스트 ------------------------------------
	@GetMapping("/likeList.do")
	// 검색을 위한 데이터를 따로 받아야 한다.
	// @ModelAttribute() - 전달받는 데이터를 Model에 담아서 바로 JSP까지 보낼 때 사용
	// 속성명을 보통 타입으로 사용한다. name = "searchVO" 설정해서 변경해서 사용
	public String likeList(Model model, HttpServletRequest request, HttpSession httpSession) throws Exception {

		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("likeList", service.likeList(LoginUtil.getId(httpSession)));
		return "goods/likeList";

	}

	// --- 상품 글보기 ------------------------------------
	@GetMapping("/view.do")
	public String view(Model model, Long goodsNo, int inc, @ModelAttribute(name = "searchVO") GoodsSearchVO searchVO,
			HttpSession httpSession) {
		log.info("view.do - goodsNo=" + goodsNo + ", inc=" + inc);

		LoginVO login = (LoginVO) (httpSession.getAttribute("login"));
		// 상품 상세 정보 가져오기 - 현재 판매 가격 포함
		model.addAttribute("vo", service.view(goodsNo, inc));
		// 첨부 이미지 파일 리스트
		model.addAttribute("imageList", service.viewImageList(goodsNo));
		// 옵션 리스트
		model.addAttribute("optionList", service.OptionList(goodsNo));
		// 정보 리스트
		model.addAttribute("infoList", service.InfoList(goodsNo));
		if (login != null)
			// 정보 리스트
			model.addAttribute("likeCheck", service.likeCheck(goodsNo, login.getId()));

		return "goods/view";
	}

	// --- 상품 글등록 폼 ------------------------------------
	@GetMapping("/writeForm.do")
	public String writeForm(Model model) {
		log.info("writeForm.do");
		// 대분류를 가져와서 JSP로 넘기기.
		model.addAttribute("bigList", categoryService.list(0));
		return "goods/writeForm";
	}

	// --- 상품 글등록 처리 ------------------------------------
	@PostMapping("/write.do")
	public String write(GoodsVO vo,
			// 대표이미지
			MultipartFile imageFile,
			// 상세 설명 이미지
			MultipartFile detailImageFile,
			// 추가 이미지들
			ArrayList<MultipartFile> imageFiles,
			// 옵션들 받기 - 사이즈, 컬러, 옵션 : ArrayList로 받으면 null인 경우 오류
			// @RequestParam(required = false) 붙여야 받을 수 있다. 배열인 경우 오류 안남
			@RequestParam(name = "goodsOptNames", required = false) ArrayList<String> goodsOptNames,
			@RequestParam(name = "goodsInfoNames", required = false) ArrayList<String> goodsInfoNames, Long perPageNum,
			HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		log.info("write.do ------------------------------");
		log.info(vo);
		log.info("대표 이미지 : " + imageFile.getOriginalFilename());
		log.info("상세 설명 이미지 : " + detailImageFile.getOriginalFilename());
		log.info("<< 첨부 이미지들>>");
		for (MultipartFile file : imageFiles)
			log.info(file.getOriginalFilename());

		// 이미지 올리기와 DB에 저장할 데이터 수집
		log.info("<<<----- 이미지 처리 ----------------->>");
		// 대표 이미지 처리
		vo.setGoodsMainImage(FileUtil.upload(path, imageFile, request));

		String fileName = detailImageFile.getOriginalFilename();

		// 상품 상세 이미지
		if (fileName != null && !fileName.equals(""))
			vo.setGoodsConImage(FileUtil.upload(path, detailImageFile, request));

		// 첨부 이미지 - GoodsImageVO
		List<GoodsImageVO> goodsImageList = null;
		// 첨부 추가 이미지가 있는 경우 처리
		if (imageFiles != null && imageFiles.size() > 0)
			for (MultipartFile file : imageFiles) {
				if (goodsImageList == null)
					goodsImageList = new ArrayList<>();
				fileName = file.getOriginalFilename();
				// 파일은 선택한 경우 처리
				if (fileName != null && !fileName.equals("")) {
					GoodsImageVO imageVO = new GoodsImageVO();
					// 파일은 서버에 올리고 DB에 저장할 정보를 VO에 저장한다.
					imageVO.setGoodsImageName(FileUtil.upload(path, file, request));
					goodsImageList.add(imageVO);
				}
			}

		// 옵션 - GoodsOptionVO
		List<GoodsOptionVO> goodsOptionList = null;
		// 옵션이 있는 경우 처리(사이즈 컬러는 없다.)
		if (goodsOptNames != null && goodsOptNames.size() > 0) {
			for (String goodsOptName : goodsOptNames) {
				if (goodsOptionList == null)
					goodsOptionList = new ArrayList<>();
				// 비이 있지 않으면 처리한다.
				if (goodsOptNames != null && !goodsOptNames.equals("")) {
					GoodsOptionVO optionVO = new GoodsOptionVO();
					optionVO.setGoodsOptName(goodsOptName);
					goodsOptionList.add(optionVO);
				}
			}
		}
		// 옵션 확인
		log.info("goodsOptionList : " + goodsOptionList);

		// 정보 - GoodsInfoVO
		List<GoodsInfoVO> goodsInfoList = null;
		// 옵션이 있는 경우 처리(사이즈 컬러는 없다.)
		if (goodsInfoNames != null && goodsInfoNames.size() > 0) {
			for (String goodsInfoName : goodsInfoNames) {
				if (goodsInfoList == null)
					goodsInfoList = new ArrayList<>();
				// 비이 있지 않으면 처리한다.
				if (goodsInfoNames != null && !goodsInfoNames.equals("")) {
					GoodsInfoVO infoVO = new GoodsInfoVO();
					infoVO.setGoodsInfoName(goodsInfoName);
					goodsInfoList.add(infoVO);
				}
			}
		}
		// 옵션 확인
		log.info("goodsInfoList : " + goodsInfoList);

		// service.write()에 넘길 데이터
		// - vo, goodsImageList, goodsOptionList, goodsInfoList
		service.write(vo, goodsImageList, goodsOptionList, goodsInfoList);

		// 처리 결과에 대한 메시지 처리
		log.info("상품 등록이 되었습니다. 상품 번호 : " + vo.getGoodsNo());
		rttr.addFlashAttribute("msg", "상품 글등록이 되었습니다.");

		return "redirect:list.do?perPageNum=" + perPageNum;
		// return null;
	}

	// --- 상품 글수정 폼 ------------------------------------
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, Long goodsNo) {
		log.info("updateForm.do");
		model.addAttribute("vo", service.view(goodsNo, 0));

		return "goods/updateForm";
	}

	@PostMapping("/update.do")
	public String update(Model model, Long goodsNo, GoodsVO vo, RedirectAttributes rttr) {
		log.info("update.do - goodsNo=" + goodsNo);

		service.update(vo);
		rttr.addFlashAttribute("msg", "상품 수정이 완료 되었습니다.");
		return "goods/list";
	}

	@GetMapping("/delete.do")
	public String delete(Model model, Long goodsNo, RedirectAttributes rttr) {
		log.info("delete.do - goodsNo=" + goodsNo);

		service.delete(goodsNo);
		rttr.addFlashAttribute("msg", "판매중지 신청이 되었습니다.");
		return "goods/list";
	}

}
