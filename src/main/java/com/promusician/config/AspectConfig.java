package com.promusician.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;


@Configuration
@ComponentScan(basePackages = {"com.promusician.aspect","com.promusician.controller"})
@EnableAspectJAutoProxy(proxyTargetClass = true)
public class AspectConfig {
}
