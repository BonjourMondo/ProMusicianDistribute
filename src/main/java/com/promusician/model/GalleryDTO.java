package com.promusician.model;

import java.io.Serializable;

/**
 * Author: LeesangHyuk
 * Date: 2019/1/2 14:40
 * Description:gallery
 */
public class GalleryDTO implements Serializable{

    private static final long serialVersionUID = -8757262365495272224L;
    private Integer id;
    private String title;
    private String description;
    private String file_url;
    private String img_url;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getFile_url() {
        return file_url;
    }

    public void setFile_url(String file_url) {
        this.file_url = file_url;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }
}
