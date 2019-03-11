package com.promusician.mapper;

import com.promusician.model.GalleryDTO;
import com.promusician.model.Music;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component
public interface MusicMapper {
    void saveMusic(GalleryDTO music);
}
