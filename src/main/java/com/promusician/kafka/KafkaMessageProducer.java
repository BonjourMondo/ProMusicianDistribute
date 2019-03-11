package com.promusician.kafka;

import org.apache.kafka.clients.producer.Callback;
import org.apache.kafka.clients.producer.KafkaProducer;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.apache.kafka.clients.producer.RecordMetadata;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.util.Properties;

@Component
public class KafkaMessageProducer {
//    private Logger logger= Logger.getLogger(KafkaMessageProducer.class.getName());
public static Logger logger = LoggerFactory.getLogger(KafkaMessageProducer.class);
    private final KafkaProducer<String,String> producer;
    private Properties producerProp;

    public KafkaMessageProducer(){
        producerProp = KafkaXmlConfig.getProducerProp();
        producer = new KafkaProducer<>(producerProp);
    }

    public void send(String title,String description)throws Exception{
        logger.debug("发送Kafka消息中...");
        //file_path格式为 name-title:date  用于以后的识别
        ProducerRecord<String,String> record= new ProducerRecord<String, String>
                ("Music",
                        title+"|"+description);
        producer.send(record, new Callback() {
            @Override
            public void onCompletion(RecordMetadata recordMetadata, Exception e) {
                if (e != null) {
                    e.printStackTrace();
                    logger.error("发生传递错误");
                }
                else {
                    logger.debug("成功传递,主题为："+recordMetadata.topic());
                }
            }
        });
    }
}
