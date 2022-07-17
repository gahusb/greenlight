package com.greenlight.Member.controller;

import com.greenlight.Member.dto.MemberResponseDto;
import com.greenlight.Member.dto.MemberUpdateRequestDto;
import com.greenlight.Member.service.MemberService;
import com.greenlight.Member.dto.MemberSaveRequestDto;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    // id, password, name, donated 등록
    @PostMapping("/member/create")
    public Long save(@RequestBody MemberSaveRequestDto memberSaveRequestDto){
        return memberService.save(memberSaveRequestDto);
    }

    // password, name, donated 변경
    @PutMapping("/member/create/{id}")
    public Long update(@PathVariable Long id, @RequestBody MemberUpdateRequestDto memberUpdateRequestDto) {
        return memberService.update(id, memberUpdateRequestDto);
    }

    @GetMapping("/member/create/{id}")
    public MemberResponseDto findById(@PathVariable Long id) {
        return memberService.findById(id);
    }
}
