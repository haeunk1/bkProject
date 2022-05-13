package com.bkProject.p1.domain;

public class AttachImageDto {
    private String uploadPath; //경로
    private String uuid;
    private String fileName;
    private int pno; //postid

    public AttachImageDto(){}
    @Override
    public String toString() {
        return "AttachImageDto{" +
                "uploadPath='" + uploadPath + '\'' +
                ", uuid='" + uuid + '\'' +
                ", fileName='" + fileName + '\'' +
                ", pno=" + pno +
                '}';
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getPno() {
        return pno;
    }

    public void setPno(int pno) {
        this.pno = pno;
    }
}
