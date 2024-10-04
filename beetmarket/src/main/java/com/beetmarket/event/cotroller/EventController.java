package com.beetmarket.event.cotroller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beetmarket.event.service.EventService;
import com.beetmarket.event.vo.EventVO;
import com.beetmarket.event.vo.SubscriberVO;
import com.webjjang.util.file.FileUtil;
import com.webjjang.util.page.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/event")
@Log4j
public class EventController {
	@Autowired
	@Qualifier("EventServiceImpl")
	private EventService service;
	String path = "/upload/event";
	
	@GetMapping("/list.do")
	public String list(Model model, Long perPageNum, HttpServletRequest request) throws Exception {
		PageObject pageObject = PageObject.getInstance(request);
		model.addAttribute("list", service.list(pageObject));
		model.addAttribute("pageObject",pageObject);
		return "event/list";
	}
	@GetMapping("/view.do")
	public String view(Long no, Model model)  {
		Long[] in = new Long[]{no};
		EventVO vo = service.view(in);
		model.addAttribute("vo",vo);
		return "event/view";
	}
	@GetMapping("/writeForm.do")
	public String writeForm()  {
		return "event/writeForm";
	}
	@PostMapping("/write.do")
	public String write(EventVO vo, Long perPageNum, HttpServletRequest request, RedirectAttributes rttr, MultipartFile imageFile) throws Exception {
		log.info("write.do---------------------------------------------");
		log.info(vo);
		vo.setImage(FileUtil.upload(path, imageFile, request));
		service.write(vo);
		rttr.addAttribute("msg", "이벤트 등록이 되었습니다.");
		return "redirect:list.do?perPageNum=" + perPageNum;
	}
	@GetMapping("/updateForm.do")
	public String updateForm(Long no, Model model)  {
		Long [] in = new Long[] {no};
		EventVO vo = service.view(in);
		model.addAttribute("vo",vo);
		return "event/updateForm";
	}
	@PostMapping("/update.do")
	public String update(EventVO vo, RedirectAttributes rttr) {
		System.out.println("EventController().update");
		service.update(vo);
		Long no = vo.getNo();
		rttr.addAttribute("msg", "이벤트 수정이 되었습니다.");
		return "redirect:view.do?no=" + no ;
	}
	@PostMapping("/delete.do")
	public String delete(EventVO vo, RedirectAttributes rttr) {
		if(service.delete(vo)==1) {
			rttr.addFlashAttribute("msg", "이벤트이 삭제 되었습니다.");
			return "redirect:list.do";
		}
		else
			rttr.addFlashAttribute("msg", "이벤트이 삭제가 되지 않았습니다." + "이벤트 번호나 비밀번호가 맞지 않습니다. 다시 확인해주세요");
			return "redirect:view.do?no="+vo.getNo();
	}
	@GetMapping("/minigame.do")
    public String miniGameForm(HttpSession session, Model model) {
        Integer points = (Integer) session.getAttribute("points");
        if (points == null) {
            points = 2000; // 기본 포인트 설정
            session.setAttribute("points", points);
        }
        model.addAttribute("points", points);
        return "event/minigame";
    }
    // 미니게임 결과 처리
    @PostMapping("/minigame.do")
    public String miniGame(HttpServletRequest request, HttpSession session, RedirectAttributes rttr) {
        String userChoice = request.getParameter("userChoice");
        String[] choices = {"가위", "바위", "보"};
        int computerChoiceIndex = (int) (Math.random() * 3);
        String computerChoice = choices[computerChoiceIndex];	

        Integer points = (Integer) session.getAttribute("points");

        String result = "";
        if (userChoice.equals(computerChoice)) {
            result = "비겼습니다!";
            points += 500; // 비기면 5 포인트 추가
        } else if ((userChoice.equals("가위") && computerChoice.equals("보")) ||
                   (userChoice.equals("바위") && computerChoice.equals("가위")) ||
                   (userChoice.equals("보") && computerChoice.equals("바위"))) {
            result = "이겼습니다!";
            points += 1000; // 이기면 10 포인트 추가
        } else {
            result = "졌습니다!";
            points -= 1000; // 지면 10 포인트 차감
        }

        // 포인트 업데이트
        session.setAttribute("points", points);

        // 결과 메시지 전달
        rttr.addFlashAttribute("msg", "당신의 선택: " + userChoice + " / 컴퓨터의 선택: " + computerChoice + " / 결과: " + result);
        rttr.addFlashAttribute("points", points);

        return "redirect:minigame.do";
    }
    @GetMapping("/ApplyForm.do")
	public String ApplyForm()  {
		return "event/ApplyForm";
	}
    @PostMapping("/Apply.do")
    public String apply(SubscriberVO vo, RedirectAttributes rttr) throws Exception {
    	log.info("참여자 등록 -------------------");
       if(service.Apply(vo) == 1) {
             // 서비스에서 참여자 등록 처리
            rttr.addFlashAttribute("msg", "이벤트 참여 등록이 완료되었습니다.");
            return "redirect:/event/subscriberList.do?event_no=" + vo.getEvent_no();
        } else{
            rttr.addFlashAttribute("msg", "이벤트 참여 등록에 실패했습니다.");
            return "redirect:/event/ApplyForm.do";
        }
    }
    // 참여자 리스트 조회
    @GetMapping("/subscriberList.do")
    public String subscriberList(Long event_no, Model model) throws Exception {
    List<SubscriberVO> subscriberList = service.getSubscriberList(event_no);
    model.addAttribute("subscriberList", subscriberList);
    return "event/subscriberList"; // JSP 페이지 경로
    }
    @GetMapping("/drowWinner.do")
    public String drowWinner(Long event_no, Integer numWinners, Model model, RedirectAttributes rttr) throws Exception {
        // numWinners가 null이거나 0 이하일 경우 기본값 설정
        if (numWinners == null || numWinners <= 0) {
            numWinners = 1; // 최소 1명으로 설정
        }

        // 이벤트 참여자 리스트 조회
        List<SubscriberVO> participants = service.subscriber(event_no);

        // 추첨 로직 - 랜덤으로 numWinners 수 만큼 선택
        List<SubscriberVO> winners = new ArrayList<>();
        if (!participants.isEmpty()) {
            Collections.shuffle(participants); // 참가자 리스트를 랜덤으로 섞음

            // numWinners 수만큼 당첨자를 리스트에서 선택
            for (int i = 0; i < numWinners && i < participants.size(); i++) {
                winners.add(participants.get(i));
            }
        }

        // 추첨 결과 리스트를 모델에 추가
        model.addAttribute("winners", winners);

        // 결과 페이지로 리다이렉트 (결과를 화면에 표시)
        return "event/drowWinner"; // JSP 페이지 경로
    }

}