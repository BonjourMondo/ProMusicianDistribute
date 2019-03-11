package com.promusician.model;

import java.io.Serializable;

public class Music implements Serializable{
    private static final long serialVersionUID = 3497672869021101997L;
    private String Id;
    private String name;
    private String title;
    private String file_url;

    public String getId() {
        return Id;
    }

    public void setId(String id) {
        Id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getFile_url() {
        return file_url;
    }

    public void setFile_url(String file_url) {
        this.file_url = file_url;
    }
}
