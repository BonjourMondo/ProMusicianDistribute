package com.promusician.mapper;

import com.promusician.model.GalleryDTO;
import org.springframework.stereotype.Component;

import java.util.List;
@Component
public interface GalleryShowMapper {
    List<GalleryDTO> selectAllMusic();
}
