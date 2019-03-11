package com.promusician.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.FilterType;


@Configuration
@ComponentScan(basePackages = {"com.promusician"},
        excludeFilters = {@ComponentScan.Filter(type = FilterType.ANNOTATION)})
public class RootConfig {

}