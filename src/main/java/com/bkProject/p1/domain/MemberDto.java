package com.bkProject.p1.domain;

public class MemberDto {
    private String id;
    private String pwd;
    private String name;
    private String phone_number;
    private String email;

    public MemberDto(){} //기본생성자

    public MemberDto(String id, String pwd, String name, String phone_number, String email) {
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.phone_number = phone_number;
        this.email = email;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getPwd() {
        return pwd;
    }
    public void setPwd(String pwd) {
        this.pwd = pwd;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getPhone_number() {
        return phone_number;
    }
    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    @Override
    public String toString() {
        return "memberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", phone_number=" + phone_number + ", email=" + email + "]";
    }

}
