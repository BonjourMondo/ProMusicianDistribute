//package com.promusician.config;
//
//import com.promusician.mapper.MusicMapper;
//import org.apache.commons.dbcp.BasicDataSource;
//import org.junit.Assert;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.mybatis.spring.SqlSessionFactoryBean;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.jdbc.datasource.DataSourceTransactionManager;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//
//import static org.junit.Assert.*;
//
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(classes = MybatisConfig.class)
//public class MybatisConfigTest {
//    @Autowired
//    private MusicMapper musicMapper;
//
//    @Autowired
//    private BasicDataSource basicDataSource;
//    @Autowired
//    private DataSourceTransactionManager dataSourceTransactionManager;
//    @Autowired
//    private SqlSessionFactoryBean factoryBean;
////    @Test
////    public void save(){
////        Music music=new Music();
////        music.setFile_url("file_url");
////        music.setTitle("title");
////        music.setName("name");
////
////        musicMapper.saveMusic(music);
////    }
//
//    @Test
//    public void isExist(){
//        Assert.assertNotNull(basicDataSource);
//        Assert.assertNotNull(dataSourceTransactionManager);
//        Assert.assertNotNull(factoryBean);
//        Assert.assertNotNull(musicMapper);
//    }
//
//}