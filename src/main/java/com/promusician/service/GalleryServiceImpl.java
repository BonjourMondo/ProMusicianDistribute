package com.promusician.service;

import com.promusician.mapper.GalleryShowMapper;
import com.promusician.model.GalleryDTO;
import com.promusician.model.Music;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Author: LeesangHyuk
 * Date: 2019/1/2 14:33
 * Description:用于显示gallery
 */
@Service("galleryservice")
public class GalleryServiceImpl implements GalleryService{

    @Autowired
    GalleryShowMapper galleryShowMapper;

    @Override
//    必须要打开虚拟机 才能使用cacheable
//    @Cacheable("MusicAllSelect")
    public List<GalleryDTO> showGallery(){
        List<GalleryDTO> galleryDTOList= galleryShowMapper.selectAllMusic();
        return galleryDTOList;
    }
}
