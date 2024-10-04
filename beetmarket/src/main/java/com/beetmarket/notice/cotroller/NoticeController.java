package com.beetmarket.notice.cotroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.beetmarket.notice.service.NoticeService;
import com.beetmarket.notice.vo.NoticeVO;

import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice")
@Log4j
public class NoticeController {
	//자동 DI
//	@Setter(onMethod_ = @Autowired)
	@Autowired
	@Qualifier("noticeServiceImpl")
	private NoticeService service;
	
	@GetMapping("/list.do")
	public String list (Model model, HttpServletRequest request) throws Exception{
		log.info("list.do");
		PageObject pageObject = PageObject.getInstance(request);
		System.out.println("pageObject" + pageObject);
		model.addAttribute("list", service.list(pageObject));
		log.info(pageObject);
		model.addAttribute("pageObject", pageObject);
		return "notice/list";
	}
	@GetMapping("/view.do")
	public String view (Model model, Long no){
		log.info("view.do");
		Long[] in = new Long[] {no};
		NoticeVO vo = service.view(in);
		model.addAttribute("vo", vo);
		return "/notice/view";
	}
	@GetMapping("/writeForm.do")
	public String writeForm (Model model, Long no){
		log.info("writeForm.do");
		return "notice/writeForm";
	}
	@PostMapping("/write.do")
	public String write (NoticeVO vo, RedirectAttributes rttr){
		service.write(vo);
		rttr.addFlashAttribute("msg", "공지사항 글등록이 되었습니다.");
		return "redirect:list.do";
	}
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, Long no){
		Long[] in = new Long[] {no};
		NoticeVO vo = service.view(in);
		model.addAttribute("vo", vo);
		return "notice/updateForm";
	}
	@PostMapping("/update.do")
	public String update(NoticeVO vo, RedirectAttributes rttr){
		Long no = vo.getNo();
		service.update(vo);
		rttr.addFlashAttribute("msg", "공지사항 수정 되었습니다.");
		return "redirect:view.do?no="+no;
	}
	@PostMapping("/delete.do")
	public String delete(NoticeVO vo, RedirectAttributes rttr){
		if(service.delete(vo)==1) {
			rttr.addFlashAttribute("msg", "공지사항이 삭제 되었습니다.");
			return "redirect:list.do";
		}
		else
			rttr.addFlashAttribute("msg", "공지사항이 삭제가 되지 않았습니다." + "공지사항 번호나 비밀번호가 맞지 않습니다. 다시 확인해주세요");
			return "redirect:view.do?no="+vo.getNo();
	}	
}