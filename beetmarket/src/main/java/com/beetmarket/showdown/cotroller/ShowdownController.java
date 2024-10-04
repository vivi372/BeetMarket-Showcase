package com.beetmarket.showdown.cotroller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.showdown.service.ShowdownService;
import com.beetmarket.showdown.vo.ShowdownVO;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/showdown")
@Log4j
public class ShowdownController {
	@Autowired
	@Qualifier("showdownServiceImpl")
	private ShowdownService service;
	
	@GetMapping("/list.do")
	public String list(Model model, HttpServletRequest request) throws Exception {
		PageObject pageObject = PageObject.getInstance(request);
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject", pageObject);
		return "showdown/list";
	}
	@GetMapping("/view.do")
	public String view(Model model, Long no){
		Long [] hi = new Long[] {no};
		ShowdownVO vo = service.view(hi);
		model.addAttribute("vo", vo);
		return "showdown/view";
	}
	@GetMapping("/writeForm.do")
	public String writeForm (Model model, Long no){
		log.info("writeForm.do");
		return "showdown/writeForm";
	}
	@PostMapping("/write.do")
	public String write (ShowdownVO vo, RedirectAttributes rttr){
		service.write(vo);
		rttr.addFlashAttribute("msg", "이벤트 발표 글등록이 되었습니다.");
		return "redirect:list.do";
	}
	@GetMapping("/updateForm.do")
	public String updateForm(Model model, Long no){
		Long[] hi = new Long[] {no};
		ShowdownVO vo = service.view(hi);
		model.addAttribute("vo", vo);
		return "showdown/updateForm";
	}
	@PostMapping("/update.do")
	public String update(ShowdownVO vo, RedirectAttributes rttr){
		Long no = vo.getNo();
		service.update(vo);
		rttr.addFlashAttribute("msg", "이벤트 발표 수정 되었습니다.");
		return "redirect:view.do?no="+no;
	}
	@PostMapping("/delete.do")
	public String delete(ShowdownVO vo, RedirectAttributes rttr){
		if(service.delete(vo)==1) {
			rttr.addFlashAttribute("msg", "이벤트 발표이 삭제 되었습니다.");
			return "redirect:list.do";
		}
		else
			rttr.addFlashAttribute("msg", "이벤트 발표이 삭제가 되지 않았습니다." + "이벤트 발표 번호나 비밀번호가 맞지 않습니다. 다시 확인해주세요");
			return "redirect:view.do?no="+vo.getNo();
	}	
}