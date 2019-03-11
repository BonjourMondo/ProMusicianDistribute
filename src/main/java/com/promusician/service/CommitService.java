package com.promusician.service;

/**
 * 提交的service，用于检查并提交
 */
public interface CommitService {
    void CheckandCommit(String servletpath,String description,String title);
}
