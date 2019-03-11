package com.promusician.model;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Author: LeesangHyuk
 * Date: 2018/12/28 13:04
 * Description:用于保存code相关消息，进行前后端的传输
 */
public class Code implements Serializable{
    private static final long serialVersionUID = 8157509648045717538L;
    private ArrayList<String> strings;
    private String bpm;
    private String error_code;
    private String error_msg;

    public String getError_code() {
        return error_code;
    }

    public void setError_code(String error_code) {
        this.error_code = error_code;
    }

    public String getError_msg() {
        return error_msg;
    }

    public void setError_msg(String error_msg) {
        this.error_msg = error_msg;
    }

    public ArrayList<String> getStrings() {
        return strings;
    }

    public void setStrings(ArrayList<String> strings) {
        this.strings = strings;
    }

    public String getBpm() {
        return bpm;
    }

    public void setBpm(String bpm) {
        this.bpm = bpm;
    }
}
