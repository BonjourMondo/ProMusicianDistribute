package com.promusician.kafka;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@Component
public class KafkaXmlConfig {
    public static final Logger logger= Logger.getLogger(KafkaXmlConfig.class.getName());
    private  static Properties consumerProp;
    private static Properties producerProp;

    private final static String CONSUMER_CONFIG_PATH = "consumer.properties";
    private final static String PRODUCER_CONFIG_PATH = "producer.properties";

    public static Properties getProducerProp() {
        if(producerProp == null) {
            producerProp = loadProp(PRODUCER_CONFIG_PATH);
        }
        return producerProp;
    }

    public static Properties getConsumerProp() {
        if(consumerProp == null) {
            consumerProp = loadProp(CONSUMER_CONFIG_PATH);
        }
        return consumerProp;
    }

    private static Properties loadProp(String path){
        Properties properties = new Properties();
        InputStream resourceAsStream = KafkaXmlConfig.class.getClassLoader().getResourceAsStream(path);
        try {
            properties.load(resourceAsStream);
        } catch (IOException e) {
            logger.error("load config file failed: " + e.getMessage());
        }
        return properties;
    }

    private KafkaXmlConfig() {

    }
}
