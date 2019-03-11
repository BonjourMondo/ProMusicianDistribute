package com.promusician.stone;

import com.promusician.model.Code;
import com.promusician.stone.Exception.DeadLoopException;
import com.promusician.stone.Exception.ParseException;
import com.promusician.stone.Exception.StoneExcetion;
import com.promusician.stone.ast.ASTree;
import com.promusician.stone.ast.NULLStmnt;
import com.promusician.stone.ast.RhyStmnt;
import com.promusician.stone.env.BasicEnv;
import com.promusician.stone.env.Environment;
import com.promusician.stone.token.Token;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;

public class InterpreterRunner {
    private static String file = "src/main/resources/data/lex.stone";
    public static Logger logger= LoggerFactory.getLogger(InterpreterRunner.class);
    public static final String LOOPS="loops";
    public static final String PARSER_ERROR="parser_error";
    public static final String STONE_ERROR="stone_error";
    public static final String ERROR="exception_error";
    public static final String SUCCESS="success";

    public static void main(String[] args) {
        runFile(new BasicParser(), new BasicEnv(), file);
    }

    public static ArrayList<String> runFile(BasicParser basicParser, Environment basicEnv, String path) {
        ArrayList<String> strings=new ArrayList<>();
        try {
            Lexer lex = new Lexer(new FileReader(new File(path)));
            run(basicParser,basicEnv,lex,strings);
            System.out.println(strings);
//            System.out.println(strings.size());
//            System.out.println(strings.contains("loops"));
//            System.out.println(strings.get(strings.size()-1));
            return strings;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static Code runCode(BasicParser basicParser, Environment basicEnv, String code) {
        ArrayList<String> strings = new ArrayList<>();
        Lexer lex = new Lexer(code);
        Code c=run(basicParser,basicEnv,lex,strings);
        return c;
    }

    public static Code run(BasicParser basicParser, Environment basicEnv,Lexer lex,ArrayList arrayList){
        Code code=new Code();
        while (lex.peek(0) != Token.EOF) {
            ASTree ast=null;
            try {
                ast = basicParser.parse(lex);
            }catch (ParseException e){
                logger.debug(e.getMessage());
                code.setError_msg(e.getMessage());
                code.setError_code(PARSER_ERROR);
                break;
            }catch (Exception e){
                logger.debug(e.getMessage());
                code.setError_msg(e.getMessage());
                code.setError_code(ERROR);
                //????
                break;
            }
            if (!(ast instanceof NULLStmnt)) {
                try {
                    Object o = ast.eval(basicEnv, arrayList);
                    if (null!=ast.child(0)) {
//                        System.out.println(ast.child(0).toString());
                        if ("bpm".equalsIgnoreCase(ast.child(0).toString())){
                            code.setBpm(o.toString());//设置BPM
//                            System.out.println(o.toString());
                        }
                    }

                } catch (DeadLoopException e) {
                    logger.debug(e.getMessage());
                    code.setError_msg("死循环");
                    code.setError_code(LOOPS);
                    //出现死循环 报告到前端一直循环
                    break;
                } catch (StoneExcetion e) {
                    logger.debug(e.getMessage());
                    code.setError_msg(e.getMessage());
                    code.setError_code(STONE_ERROR);
                    //出现语法错误
                    break;
                } catch (ParseException e) {
                    logger.debug(e.getMessage());
                    code.setError_msg(e.getMessage());
                    code.setError_code(PARSER_ERROR);
                    //出现词法错误
                    break;
                } catch (Exception e) {
                    logger.debug(e.getMessage());
                    code.setError_msg(e.getMessage());
                    code.setError_code(ERROR);
                    //????
                    break;
                }
            }
        }
        code.setStrings(arrayList);
        return code;
    }
}
