package com.promusician.service;

import com.promusician.kafka.KafkaMessageProducer;
import com.promusician.mapper.MusicMapper;
import com.promusician.model.GalleryDTO;
import com.promusician.model.UserConstants;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
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
            galleryDTO.setId(UserConstants.USERID);//默认用户id为1
            SimpleDateFormat df = new SimpleDateFormat("MM-dd HH:mm:ss");//设置日期格式
            logger.debug(df.format(new Date()));// new Date()为获取当前系统时间
            galleryDTO.setDatetime(""+df.format(new Date()));
            musicMapper.saveMusic(galleryDTO);
        }catch (Exception e){
            e.printStackTrace();
            try {
                producer.send(title,description);
            } catch (Exception e1) {
                logger.debug("保存失败");
//                e1.printStackTrace();
            }
        }

    }
}
