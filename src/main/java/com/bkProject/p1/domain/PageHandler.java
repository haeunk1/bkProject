package com.bkProject.p1.domain;

public class PageHandler {
    private int page=1; //현재 페이지

    private int pageSize; // 한 페이지의 크기
    private int totalCnt; // 총 게시물 개수
    private int navSize=10; //페이지 내비게이션의 크기
    private int totalPage; //전체 페이지 갯수
    private int beginPage; //내비게이션의 첫번째 페이지
    private int endPage; //내비게이션의 마지막 페이지
    private boolean showPrev; //이전 페이지로 이동하는 링크를 보여줄 것인지의 여부
    private boolean showNext; //다음 페이지로 이동하는 링크를 보여줄 것인지의 여부

    public PageHandler(int totalCnt, int page){
        this(totalCnt,page,10);
    }

    public PageHandler(int totalCnt, int page, int pageSize){
        this.totalCnt=totalCnt;
        this.page=page;
        this.pageSize =pageSize;

        totalPage = (int)Math.ceil(totalCnt/(double)pageSize);
        beginPage = page%navSize==0?page-pageSize+1 : page/navSize*navSize+1;
        endPage = Math.min(beginPage+navSize-1,totalPage);

        showPrev = beginPage!=1;
        showNext = totalPage!=endPage;

    }

    void print(){
        System.out.println("page"+page);
        System.out.print(showPrev?"<<":"");
        for(int i=beginPage;i<endPage+1;i++){
            System.out.print(" "+i+" ");
        }
        System.out.println(showNext?">>":"");
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalCnt() {
        return totalCnt;
    }

    public void setTotalCnt(int totalCnt) {
        this.totalCnt = totalCnt;
    }

    public int getNavSize() {
        return navSize;
    }

    public void setNavSize(int navSize) {
        this.navSize = navSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getBeginPage() {
        return beginPage;
    }

    public void setBeginPage(int beginPage) {
        this.beginPage = beginPage;
    }

    public int getEndPage() {
        return endPage;
    }

    public void setEndPage(int endPage) {
        this.endPage = endPage;
    }

    public boolean isShowPrev() {
        return showPrev;
    }

    public void setShowPrev(boolean showPrev) {
        this.showPrev = showPrev;
    }

    public boolean isShowNext() {
        return showNext;
    }
    public void setShowNext(boolean showNext) {
        this.showNext = showNext;
    }

    @Override
    public String toString() {
        return "PageHandler{" +
                "page=" + page +
                ", pageSize=" + pageSize +
                ", totalCnt=" + totalCnt +
                ", navSize=" + navSize +
                ", totalPage=" + totalPage +
                ", beginPage=" + beginPage +
                ", endPage=" + endPage +
                ", showPrev=" + showPrev +
                ", showNext=" + showNext +
                '}';
    }
}
