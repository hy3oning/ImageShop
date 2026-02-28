package com.zeus.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.zeus.common.security.domain.CustomUser;
import com.zeus.domain.Item;
import com.zeus.domain.Member;
import com.zeus.service.ItemService;
import com.zeus.service.UserItemService;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemService itemService;

	@Autowired
	private UserItemService userItemService;

	@Value("${upload.path}")
	private String uploadPath;

	// 상품 등록 페이지
	@GetMapping("/register")
	@PreAuthorize("hasRole('ADMIN')")
	public String registerForm(Model model) {
		model.addAttribute("item", new Item());
		return "item/register";
	}

	// 상품 등록 처리
	@PostMapping("/register")
	@PreAuthorize("hasRole('ADMIN')")
	public String register(Item item, RedirectAttributes rttr) throws Exception {
		MultipartFile pictureFile = item.getPicture();
		MultipartFile previewFile = item.getPreview();
		if (pictureFile == null || pictureFile.isEmpty() || previewFile == null || previewFile.isEmpty()) {
			rttr.addFlashAttribute("msg", "FAILED");
			return "redirect:/item/register";
		}
		String createdPictureFilename = uploadFile(pictureFile.getOriginalFilename(), pictureFile.getBytes());
		String createdPreviewFilename = uploadFile(previewFile.getOriginalFilename(), previewFile.getBytes());
		item.setPictureUrl(createdPictureFilename);
		item.setPreviewUrl(createdPreviewFilename);

		int count = itemService.register(item);

		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/item/list";

	}

	// 상품 목록 페이지
	@GetMapping("/list")
	public String list(Model model) throws Exception {
		model.addAttribute("itemList", itemService.list());
		return "item/list";
	}

	// 상품 상세 페이지
	@GetMapping("/read")
	public String read(int itemId, Model model) throws Exception {
		model.addAttribute("item", itemService.read(itemId));
		return "item/read";
	}

	// 상품 수정 페이지
	@GetMapping("/modify")
	@PreAuthorize("hasRole('ADMIN')")
	public String modifyForm(@RequestParam int itemId, Model model) throws Exception {
		model.addAttribute("item", itemService.read(itemId));
		return "item/modify";
	}

	// 상품 수정 처리
	@PostMapping("/modify")
	@PreAuthorize("hasRole('ADMIN')")
	public String modify(Item item, RedirectAttributes rttr) throws Exception {
		// 기존 데이터 1번만 조회 (중복 조회 제거)
		Item oldItem = itemService.read(item.getItemId());

		// picture 교체
		MultipartFile newPicture = item.getPicture();
		if (newPicture != null && !newPicture.isEmpty()) {
			String created = uploadFile(newPicture.getOriginalFilename(), newPicture.getBytes());
			// 기존 파일 삭제
			String oldPictureUrl = oldItem.getPictureUrl();
			if (oldPictureUrl != null && !oldPictureUrl.isBlank()) {
				new File(uploadPath, oldPictureUrl).delete();
			}

			item.setPictureUrl(created);
		} else {
			// 새 파일이 없으면 기존 URL 유지
			item.setPictureUrl(oldItem.getPictureUrl());
		}

		// preview 교체
		MultipartFile newPreview = item.getPreview();
		if (newPreview != null && !newPreview.isEmpty()) {
			String created = uploadFile(newPreview.getOriginalFilename(), newPreview.getBytes());

			// 기존 파일 삭제
			String oldPreviewUrl = oldItem.getPreviewUrl();
			if (oldPreviewUrl != null && !oldPreviewUrl.isBlank()) {
				new File(uploadPath, oldPreviewUrl).delete();
			}
			item.setPreviewUrl(created);
		} else {
			// 새 파일이 없으면 기존 URL 유지
			item.setPreviewUrl(oldItem.getPreviewUrl());
		}
		int count = itemService.modify(item);

		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/item/list";
	}

	// 상품 삭제화면 요청
	@GetMapping("/remove")
	@PreAuthorize("hasRole('ADMIN')")
	public String removeForm(@RequestParam int itemId, Model model) throws Exception {
		model.addAttribute("item", itemService.read(itemId));
		return "item/remove";
	}

	// 상품 삭제 처리
	@PostMapping("/remove")
	@PreAuthorize("hasRole('ADMIN')")
	public String remove(@RequestParam int itemId, RedirectAttributes rttr) throws Exception {
		// 1) 삭제 전 기존 파일명 확보
		Item oldItem = itemService.read(itemId);
		// 2) DB 삭제
		int count = itemService.remove(itemId);

		// 3) DB 삭제 성공 시 디스크 파일 삭제
		if (count > 0 && oldItem != null) {
			String pictureUrl = oldItem.getPictureUrl();
			if (pictureUrl != null && !pictureUrl.isBlank()) {
				new File(uploadPath, pictureUrl).delete();
			}
			String previewUrl = oldItem.getPreviewUrl();
			if (previewUrl != null && !previewUrl.isBlank()) {
				new File(uploadPath, previewUrl).delete();
			}
		}

		rttr.addFlashAttribute("msg", (count > 0) ? "SUCCESS" : "FAILED");
		return "redirect:/item/list";
	}

	// 상품 이미지 업로드
	private String uploadFile(String originalName, byte[] fileData) throws Exception {
		// 1) 업로드 폴더 없으면 생성
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		// 2) 파일명 정리 (경로 제거 + 위험문자 제거)
		String cleanName = originalName;
		if (cleanName == null)
			cleanName = "file";
		cleanName = cleanName.replace("\\", "/");
		cleanName = cleanName.substring(cleanName.lastIndexOf("/") + 1);
		cleanName = cleanName.replaceAll("[\\r\\n]", "");

		// 3) UUID 붙여 저장
		String createdFileName = UUID.randomUUID() + "_" + cleanName;
		File target = new File(uploadDir, createdFileName);
		FileCopyUtils.copy(fileData, target);
		return createdFileName;
	}

	// 미리보기 이미지 표시
	@ResponseBody
	@GetMapping("/display")
	public ResponseEntity<byte[]> displayFile(@RequestParam int itemId) throws Exception {
		String fileName = itemService.getPreview(itemId);
		return renderImage(fileName);
	}

	// 원본 이미지 표시
	@ResponseBody
	@GetMapping("/picture")
	public ResponseEntity<byte[]> pictureFile(@RequestParam int itemId) throws Exception {
		String fileName = itemService.getPicture(itemId);
		return renderImage(fileName);
	}

	private ResponseEntity<byte[]> renderImage(String fileName) throws Exception {
		if (fileName == null || fileName.isBlank()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		File file = new File(uploadPath, fileName);
		if (!file.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}

		String ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
		MediaType mType = getMediaType(ext);

		HttpHeaders headers = new HttpHeaders();
		if (mType != null)
			headers.setContentType(mType);

		try (InputStream in = new FileInputStream(file)) {
			return new ResponseEntity<>(IOUtils.toByteArray(in), headers, HttpStatus.OK);
		}
	}

	private MediaType getMediaType(String ext) {
		if (ext == null)
			return null;
		switch (ext) {
		case "jpg":
		case "jpeg":
			return MediaType.IMAGE_JPEG;
		case "png":
			return MediaType.IMAGE_PNG;
		case "gif":
			return MediaType.IMAGE_GIF;
		default:
			return null;
		}
	}

	@PostMapping("/buy")
	@PreAuthorize("hasRole('MEMBER')")
	public String buy(@RequestParam int itemId, RedirectAttributes rttr, @AuthenticationPrincipal CustomUser customUser)
			throws Exception {

		Member member = customUser.getMember();
		Item item = itemService.read(itemId);
		if (item == null) {
			rttr.addFlashAttribute("msgKey", "common.processFailed"); // 또는 common.notFound 만들어도 됨
			return "redirect:/item/list";
		}

		try {
			userItemService.register(member, item);
			rttr.addFlashAttribute("msgKey", "item.purchaseComplete");
			return "redirect:/item/success";
		} catch (IllegalStateException e) {
			// 서비스에서 NOT_ENOUGH_COIN 던지는 경우만 명확히 분기
			if ("NOT_ENOUGH_COIN".equals(e.getMessage())) {
				rttr.addFlashAttribute("msgKey", "coin.notEnoughCoin");
			} else {
				rttr.addFlashAttribute("msgKey", "common.processFailed");
			}
			return "redirect:/item/read?itemId=" + itemId;
		}
	}

	@GetMapping("/success")
	public String success() throws Exception {
		return "item/success";
	}

}
