package com.bkProject.p1.domain;

public class AttachImageDto {
    private String uploadPath; //경로
    private String uuid;
    private String fileName;
    private int postId; //postid

    public AttachImageDto(){}
    public AttachImageDto(String uploadPath, String uuid, String fileName, int postId) {
        this.uploadPath = uploadPath;
        this.uuid = uuid;
        this.fileName = fileName;
        this.postId = postId;
    }

    @Override
    public String toString() {
        return "AttachImageDto{" +
                "uploadPath='" + uploadPath + '\'' +
                ", uuid='" + uuid + '\'' +
                ", fileName='" + fileName + '\'' +
                ", postId=" + postId +
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

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }
}
