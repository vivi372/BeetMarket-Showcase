package com.beetmarket.member.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.member.service.MemberService;
import com.beetmarket.member.vo.LoginVO;
import com.beetmarket.member.vo.MemberVO;
import com.beetmarket.member.vo.SellerVO;
import com.beetmarket.order.service.OrderService;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.login.LoginUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@Log4j
public class MemberController {

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService service; 
	
	@Autowired
	@Qualifier("OrderServiceImpl")
	private OrderService orderService; 
	
	
	
	
	
	//--- 회원 관리 리스트 ------------------------------------
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request , HttpSession session)
			throws Exception {
		log.info("list.do");
		
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);

		String id = null;
		session = request.getSession();
		LoginVO loginId = (LoginVO) session.getAttribute("login");
		if(loginId != null)  id = loginId.getId();
		
		pageObject.setAccepter(id);
		
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("list", service.list(pageObject,id));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "member/list";
	}
	//--- 회원 포인트 리스트 ------------------------------------
	@GetMapping("/pointList.do")
	public String pointList(Model model, HttpServletRequest request , HttpSession session)
			throws Exception {
		log.info("pointList.do-------------");
		
		session = request.getSession();
		LoginVO loginId = (LoginVO) session.getAttribute("login");
		String id = loginId.getId();
		
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("pointList", service.pointList(pageObject,id));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "member/pointList";
	}
	//--- 회원 쿠폰 리스트 ------------------------------------
	@GetMapping("/couponList.do")
	public String couponList(Model model , HttpSession session   )
			throws Exception {
		log.info("couponList.do-------------");
		LoginVO loginId = (LoginVO) session.getAttribute("login");
		String id = loginId.getId();
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("couponList", orderService.getCouponList(id));
		return "member/couponList";
	}
	
	//--- 회원 등급변경 처리 ------------------------------------
	@GetMapping("/changeGrade.do")
	public String changeGrade(MemberVO vo, RedirectAttributes rttr) {
		log.info("changeGrade.do.do");
		log.info(vo);
		if(service.changeGrade(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원 등급 수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"회원 관리 글수정이 되지 않았습니다. "
					+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		
		return "redirect:list.do";
	}
	// ----------------------[ 회원 맴버쉽 변경 ]------------------------------------
	@GetMapping("/changeMemeberShip.do")
	public String changeMemeberShip(MemberVO vo, RedirectAttributes rttr) {
		log.info("changeGrade.do.do");
		log.info(vo);
		if(service.changeMemeberShip(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원 맴버쉽 수정이 되었습니다.");
		else
			rttr.addFlashAttribute("msg",
					"회원 관리 글수정이 되지 않았습니다. "
							+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		
		return "redirect:list.do";
	}
	// ----------------------[ 회원 맴버쉽 변경 ]------------------------------------
	@GetMapping("/changeStatus.do")
	public String changeStatus(MemberVO vo, RedirectAttributes rttr, HttpServletRequest  request , HttpSession session) {
		log.info("changeGrade.do.do");
		log.info(vo);
		if(request.getParameter("admin") != null) {
		 	session.removeAttribute("login");
		} 
		
		if(service.changeStatus(vo) == 1) {
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원 맴버쉽 수정이 되었습니다.");
		}
		else {
			rttr.addFlashAttribute("msg",
					"회원 관리 글수정이 되지 않았습니다. "
							+ "글번호나 비밀번호가 맞지 않습니다. 다시 확인하고 시도해 주세요.");
		}
		return "redirect:list.do";
	}
	

	
	
	//--- 회원 관리 글보기 ------------------------------------
	@GetMapping("/view.do")
	public String view(Model model,String id) {
		log.info("view.do");
		
		model.addAttribute("vo", service.view(id));
		
		return "member/view";
	}
	
	//--- 회원 관리 글보기 ------------------------------------
	@GetMapping("/myView.do")
	public String myView(Model model,HttpServletRequest request) {
		log.info("myView.do");
		
		HttpSession session = request.getSession();
		LoginVO loginId = (LoginVO) session.getAttribute("login");
		String id = loginId.getId();
		
		model.addAttribute("homeVO", service.myView(id));
		
		return "member/myView";
	}
	
	
	// 업데아트 폼
	@GetMapping("/updateForm.do")
	public String updateForm(Model model,HttpServletRequest request) {
		log.info("updateForm---------------");
		HttpSession session = request.getSession();
		LoginVO loginId = (LoginVO) session.getAttribute("login");
		String id = loginId.getId();
		model.addAttribute("vo", service.view(id));
		return "member/updateForm";
	}
	
	
	
	
	// ----------------------[ 회원 정보 변경 ]------------------------------------
	@GetMapping("/update.do")
	public String update(MemberVO vo, RedirectAttributes rttr , HttpServletRequest request) {
		log.info("update.do");
		
		HttpSession session = request.getSession();
		LoginVO loginId = (LoginVO) session.getAttribute("login");
		String id = loginId.getId();
		
		vo.setId(id);
		
		log.info(vo);
		if(service.update(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원정보가 수정이 되었습니다.");
		else {
			rttr.addFlashAttribute("msg","비밀번호가 다릅니다!");
			return "redirect:updateForm.do";
		}
		return "redirect:myView.do";
	}
	
	
	// 회원가입 폼
	@GetMapping("/writeForm.do")
	public String writeForm() {
		log.info("loginForm---------------");
		return "member/writeForm";
	}
	
	
	// ----------------------[ 회원 가입 ]------------------------------------
	@PostMapping("/write.do")
	public String write(MemberVO vo, RedirectAttributes rttr , HttpServletRequest request , MultipartFile photoFile) throws Exception {
		log.info("write.do");
		String path = "/upload/member";
		vo.setPhoto(FileUtil.upload(path, photoFile, request));
		log.info(vo);
		if(service.write(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "회원가입이 되었습니다.");
		else {
			rttr.addFlashAttribute("msg", "회원가입 실패.");
			return "redirect:writeForm.do";
		}
		return "redirect:/main/main.do";
	}
	
	
	// --- 회원 아이디 찾기 폼 ------------------------------------
	@GetMapping("/searchForm.do")
	public String searchForm() {
		log.info("searchForm---------------");
		return "member/searchForm";
	}
	

	// --- 회원 아이디 찾기 ------------------------------------
	@PostMapping("/idSearch.do")
	public String idSearch(Model model, String name, String tel , RedirectAttributes rttr) {
	    log.info("idSearch.do");
	    
	    // idSearch 결과를 변수에 저장
	    MemberVO searchResult = service.idSearch(name, tel);
	    
	    // searchResult가 null이 아닌 경우
	    if (searchResult != null) {
	        model.addAttribute("idSearch", searchResult);
	        return "member/idSearch";  // 검색 결과 페이지로 이동
	    } else {
	    	rttr.addFlashAttribute("msg","잘못된 정보입니다 다시 확인 부탁드립니다!");
	        return "redirect:/member/searchForm.do";  // null일 경우 검색 폼으로 리디렉션
	    }
	}
	
	// --- 회원 아이디 찾기 폼 ------------------------------------
	@GetMapping("/pwSearchForm.do")
	public String pwSearchForm() {
		log.info("pwSearchForm---------------");
		return "member/pwSearchForm";
	}
	
	
	
	// --- 회원 비밀번호 찾기 ------------------------------------
	@PostMapping("/pwSearch.do")
	public String pwSearch(Model model, String email, String tel, String id , RedirectAttributes rttr) {
		log.info("pwSearch.do ==============================");
		
		// idSearch 결과를 변수에 저장
		MemberVO searchResult = service.pwSearch(email, tel ,id);
		
		// searchResult가 null이 아닌 경우
		if (searchResult != null) {
			model.addAttribute("pwSearch", searchResult);
			return "member/pwUpdateForm";  // 검색 결과 페이지로 이동
		} else {
			rttr.addFlashAttribute("msg","잘못된 정보입니다 다시 확인 부탁드립니다!");
			return "redirect:/member/pwSearchForm.do";  // null일 경우 검색 폼으로 리디렉션
		}
	}
	
	// --- 회원 비밀번호 변경 ------------------------------------
	@GetMapping("/pwUpdateForm.do")
	public String pwUpdateForm() {
		log.info("pwUpdateForm ---------------");
		return "member/pwUpdateForm";
	}
	
	
	// --- 회원 비밀번호 찾기 ------------------------------------
	@PostMapping("/pwUpdate.do")
	public String pwUpdate(Model model, MemberVO vo , RedirectAttributes rttr) {
		log.info("pwUpdate.do ==============================");
		
		// idSearch 결과를 변수에 저장
		Integer searchResult = service.pwUpdate(vo);
		
		// searchResult가 null이 아닌 경우
		if (searchResult != 0) {
			rttr.addFlashAttribute("msg","비밀번호 변경완료!");
			return "member/loginForm";  
		} else {
			rttr.addFlashAttribute("msg","잘못된 정보입니다 다시 확인 부탁드립니다!");
			return "redirect:/member/pwSearchForm.do";  
		}
	}
	
	// --- 판매자 신청 ------------------------------------
	@GetMapping("/sellerRegister.do")
	public String sellerRegister() {
		log.info("sellerRegister ---------------");
		return "member/sellerRegister";
	}
	
	// ----------------------[ 판매자 가입 ]------------------------------------
	@PostMapping("/seller.do")
	public String seller(SellerVO vo, RedirectAttributes rttr , HttpServletRequest request , HttpSession session) throws Exception {
		log.info("seller.do ----------------------");
		log.info(vo);
		String id = LoginUtil.getId(session);
		
		vo.setId(id);
		
		if(service.seller(vo) == 1)
			// 처리 결과에 대한 메시지 처리
			rttr.addFlashAttribute("msg", "판매자 신청 완료 되었습니다.");
		return "redirect:/main/main.do";
	}	
	
	
	//--- 회원 관리 리스트 ------------------------------------
	@GetMapping("/sellerApplication.do")
	public String sellerApplication(Model model, HttpServletRequest request , HttpSession session)
			throws Exception {
		log.info("sellerApplication.do -----------------");
		
		// 페이지 처리를 위한 객체 생겅
		PageObject pageObject = PageObject.getInstance(request);
		
		// model에 담으로 request에 자동을 담기게 된다. - 처리된 데이터를 Model에 저장
		model.addAttribute("sellerList", service.sellerList(pageObject));
		model.addAttribute("pageObject", pageObject);
		return "member/sellerApplication";
	}
	
	//--- 회원 등급변경 처리 ------------------------------------
	@GetMapping("/changeSeller.do")
	public String changeSeller(SellerVO sellerVO, RedirectAttributes rttr , MemberVO memberVO,HttpServletRequest request) {
		log.info("changeGrade.do");
			
			service.is_pendingUpdate(sellerVO);
			service.changeGrade(memberVO);
			if(Integer.parseInt(request.getParameter("gradeNo")) == 5) {
				rttr.addFlashAttribute("msg", "승인 완료했씁니다!!!!");
			}else
			rttr.addFlashAttribute("msg", "취소 완료했씁니다!!!!");
		
		return "redirect:sellerApplication.do";
	}
	
	// 로그인 폼
	@GetMapping("/loginForm.do")
	public String loginForm() {
		log.info("loginForm---------------");
		return "member/loginForm";
	}
	
	// 로그인 처리
	@PostMapping("/login.do")
	public String login(LoginVO vo , HttpSession session , RedirectAttributes rttr) {
		
		service.ConDateUpdate(vo);
		LoginVO loginVO = service.login(vo);
		
		if(loginVO == null) {
			rttr.addFlashAttribute("msg","로그인 정보가 맞지않습니다 다시확인 부탁드립니다");
			return "redirect:loginForm.do";
		}
		
		session.setAttribute("login", loginVO);
		rttr.addFlashAttribute("msg","로그인 완료");
		
		return "redirect:/main/main.do";
	}
	
	// ---------------- 로그아웃 ------------------
	@GetMapping("/logout.do")
	public String logout(HttpSession session,  RedirectAttributes rttr) {
		log.info("logout-------------------------------");
		session.removeAttribute("login");
		
		rttr.addFlashAttribute("msg","로그아웃 완료");
		return "redirect:/main/main.do";
	}
	
	
	//아이디 중복체크
	@PostMapping("/idCheck")
	@ResponseBody
	public int idCheck(@RequestParam("id") String id) {
		
		int cnt = service.idCheck(id);
		return cnt;
		
	}
	
	@PostMapping("/emailCheck")
	@ResponseBody
	public int emailCheck(@RequestParam("email") String email) {
		
		int cnt1 = service.emailCheck(email);
		return cnt1;
		
	}
	
	@PostMapping("/telCheck")
	@ResponseBody
	public int telCheck(@RequestParam("tel") String tel) {
		
		int cnt2 = service.telCheck(tel);
		return cnt2;
		
	}
	
}
