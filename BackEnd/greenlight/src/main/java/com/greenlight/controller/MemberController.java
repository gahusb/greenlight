package com.greenlight.controller;

import com.greenlight.dto.MemberDto;
import com.greenlight.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
public class MemberController {
    private final MemberService memberService;

    @PostMapping("/member/create")
    public Long save(@RequestBody MemberDto memberDto){
        return memberService.save(memberDto);
    }

    @PutMapping("/member/create/{id}")
    public Long update(@PathVariable Long id, @RequestBody MemberDto memberDto) {
        return memberDto.update(id, memberDto);
    }

    @GetMapping("/member/create/{id}")
    public MemberDto findById(@PathVariable Long id) {
        return memberService.findById(id);
    }
}
