package com.pb.entity;

public class Pic {
    private Integer id;

    public void setId(Integer id) {
        this.id = id;
    }

    private String upuser;
    private String picurl;
    private String picname;

    public Pic(Integer id, String upuser, String picurl, String picname) {
        this.id = id;
        this.upuser = upuser;
        this.picurl = picurl;
        this.picname = picname;
    }

    public String getUpuser() {
        return upuser;
    }

    public void setUpuser(String upuser) {
        this.upuser = upuser;
    }

    public String getPicurl() {
        return picurl;
    }

    public void setPicurl(String picurl) {
        this.picurl = picurl;
    }

    public String getPicname() {
        return picname;
    }

    public void setPicname(String picname) {
        this.picname = picname;
    }

    public Integer getId() {
        return id;
    }
}
