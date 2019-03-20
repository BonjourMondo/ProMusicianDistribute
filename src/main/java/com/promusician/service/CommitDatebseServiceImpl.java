package com.promusician.service;

import com.promusician.mapper.MusicMapper;
import com.promusician.model.GalleryDTO;
import com.promusician.model.Music;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component("commitdatebaseserivce")
public class CommitDatebseServiceImpl implements CommitDatebaseService {
    @Autowired
    private MusicMapper musicMapper;

    @Override
//    @CachePut("MusicSelect")
    public void saveMusic(GalleryDTO music){
        musicMapper.saveMusic(music);
    }
}
