package com.zeus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.common.security.domain.CustomUser;
import com.zeus.domain.ChargeCoin;
import com.zeus.service.CoinService;

@Controller
@RequestMapping("/coin")
public class CoinController {
	@Autowired
	private CoinService service;

	// 코인 충전 페이지
	@GetMapping("/charge")
	@PreAuthorize("hasRole('MEMBER')")
	public void chargeForm(Model model) throws Exception {
		ChargeCoin chargeCoin = new ChargeCoin();
		chargeCoin.setAmount(1000);
		model.addAttribute("chargeCoin", chargeCoin);
	}

	@PostMapping("/charge")
	@PreAuthorize("hasRole('MEMBER')")
	public String charge(int amount, RedirectAttributes rttr, @AuthenticationPrincipal CustomUser customUser)
			throws Exception {
		// 코인 충전 최소 최대
		if (amount <= 0 || amount > 1_000_000) {
			rttr.addFlashAttribute("msgKey", "common.invalidAmount");
			return "redirect:/coin/charge";
		}
		int userNo = customUser.getMember().getUserNo();

		ChargeCoin chargeCoin = new ChargeCoin();
		chargeCoin.setUserNo(userNo);
		chargeCoin.setAmount(amount);

		try {
			service.charge(chargeCoin);
			rttr.addFlashAttribute("msgKey", "coin.chargingComplete");
		} catch (RuntimeException e) {
			rttr.addFlashAttribute("msgKey", "common.processFailed");
		}
		return "redirect:/coin/success";
	}

	@GetMapping("/list")
	@PreAuthorize("hasRole('MEMBER')")
	public void list(Model model, @AuthenticationPrincipal CustomUser customUser) throws Exception {
		int userNo = customUser.getMember().getUserNo();
		model.addAttribute("list", service.list(userNo));
	}

	// 사용자 구매 내역 보기 요청을 처리한다.
	@GetMapping("/listPay")
	@PreAuthorize("hasRole('MEMBER')")
	public void listPayHistory(Model model, @AuthenticationPrincipal CustomUser customUser) throws Exception {
		int userNo = customUser.getMember().getUserNo();
		model.addAttribute("list", service.listPayHistory(userNo));
	}

	@GetMapping("/success")
	@PreAuthorize("hasRole('MEMBER')")
	public String success() throws Exception {
		return "coin/success";
	}

}
