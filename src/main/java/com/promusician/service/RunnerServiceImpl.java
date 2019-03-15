package com.promusician.service;

import com.promusician.model.Code;
import com.promusician.stone.BasicParser;
import com.promusician.stone.InterpreterRunner;
import com.promusician.stone.ast.RhyStmnt;
import com.promusician.stone.env.BasicEnv;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * Author: LeesangHyuk
 * Date: 2018/12/28 9:34
 * Description:检查语义，并且运行
 */

@Service("checkandrunservice")
public class RunnerServiceImpl implements RunnerService {
    public static Logger logger = LoggerFactory.getLogger(RunnerServiceImpl.class);

    @Override
    public Code CheckAndRun(String str) {
        Code code = InterpreterRunner.runCode(new BasicParser(), new BasicEnv(), str);
//        logger.debug("{}",code.getStrings());
        //是否进行code.ArrayList<String>的进一步处理？
        //处理完成后需要把static还原
        RhyStmnt.loop_time=0;
        return code;
    }
}
