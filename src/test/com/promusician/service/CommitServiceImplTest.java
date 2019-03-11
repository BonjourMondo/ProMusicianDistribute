package com.promusician.service;

import org.junit.Test;

import java.util.Random;

import static org.junit.Assert.*;

public class CommitServiceImplTest {

    @Test
    public void checkandCommit() {
        Random rand =new Random();
        int i;
        i=rand.nextInt(16);
        System.out.println(i);
        int s=rand.nextInt(16);
        System.out.println(s);
    }
}