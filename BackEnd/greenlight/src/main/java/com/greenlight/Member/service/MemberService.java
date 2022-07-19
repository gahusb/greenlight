package com.greenlight.Member.service;

import com.greenlight.Member.domain.Member;
import com.greenlight.Member.dto.MemberResponseDto;
import com.greenlight.Member.dto.MemberSaveRequestDto;
import com.greenlight.Member.dto.MemberUpdateRequestDto;
import com.greenlight.Member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@RequiredArgsConstructor
@Service
public class MemberService {
    private final MemberRepository memberRepository;
    @Transactional
    public Long save(MemberSaveRequestDto memberSaveRequestDto){
        return memberRepository.save(memberSaveRequestDto.toEntity()).getPK();
    }

    @Transactional
    public Long update(Long PK, MemberUpdateRequestDto memberUpdateRequestDto){
        Member member = memberRepository.findById(PK)
                .orElseThrow(() -> new IllegalArgumentException("해당 회원이 없습니다. PK="+PK));
        member.update(
                memberUpdateRequestDto.getPassword(),
                memberUpdateRequestDto.getName(),
                memberUpdateRequestDto.isDonated());//Dirty Checking 발동

        return PK;
    }

    public MemberResponseDto findById(Long id){
        Member member = memberRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("해당 회원이 없습니다. id="+id));
        return new MemberResponseDto(member);
    }
}
