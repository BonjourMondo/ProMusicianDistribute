package com.promusician.service;

public class DubboDemoServiceImpl implements DubboDemoService {

    @Override
    public String sayHello(String name) {
        return "Bounjour, "+name;
    }
}
