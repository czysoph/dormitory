package com.sushe.entity;

import java.util.List;

/**
 * @author  
 * @date
 */
public class Menu {

    private Integer id;
    private String title;
    private String icon;
    private String href;
    private Integer newStu;
    private Integer userType;

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

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getHref() {
        return href;
    }

    public void setHref(String href) {
        this.href = href;
    }

    public Integer getNewStu() {
        return newStu;
    }

    public void setNewStu(Integer newStu) {
        this.newStu = newStu;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

}
