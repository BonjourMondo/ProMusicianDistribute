package com.promusician.service;

import com.promusician.kafka.KafkaMessageProducer;
import com.promusician.mapper.MusicMapper;
import com.promusician.model.GalleryDTO;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service("commitservice")
public class CommitServiceImpl implements CommitService{
    public static Logger logger = LoggerFactory.getLogger(CommitServiceImpl.class);
    @Autowired
    private KafkaMessageProducer producer;

    @Autowired
    private MusicMapper musicMapper;

    public void CheckandCommit(String servletpath,String description,String title){
        //创建并保存文件
        try {
            GalleryDTO galleryDTO = new GalleryDTO();
            if (!StringUtils.isEmpty(description))
                galleryDTO.setDescription(description);
            if (!StringUtils.isEmpty(title))
                galleryDTO.setTitle(title);
            //后期再改
            galleryDTO.setFile_url(System.getProperty("user.dir")+"/res/"+title+".stone");
            //生成伪随机数的图片
            Random rand =new Random();
            int i;
            i=rand.nextInt(18);
            galleryDTO.setImg_url(servletpath+"/assets/images/gallery/demo"+i+".png");
            musicMapper.saveMusic(galleryDTO);
        }catch (Exception e){
            try {
                producer.send(title,description);
            } catch (Exception e1) {
                logger.debug("保存失败");
//                e1.printStackTrace();
            }
        }

    }
}
