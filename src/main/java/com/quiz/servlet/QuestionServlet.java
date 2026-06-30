package com.quiz.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class QuestionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){
            response.sendRedirect("index.jsp");
            return;
        }

        Integer qIndex=(Integer)session.getAttribute("qIndex");
        int[] answers=(int[])session.getAttribute("answers");
        int[] status=(int[])session.getAttribute("status");

        if(qIndex==null || answers==null || status==null){

            response.sendRedirect("index.jsp");
            return;

        }

        //================ SAVE CURRENT ANSWER =================

        String ans=request.getParameter("answer");

        if(ans!=null && !ans.trim().isEmpty()){

            answers[qIndex]=Integer.parseInt(ans);

            status[qIndex]=2;

        }else{

            if(answers[qIndex]!=0){

                status[qIndex]=2;

            }else{

                status[qIndex]=1;

            }

        }

        String action=request.getParameter("action");

        //================ SUBMIT =================

        if("submit".equals(action)){

            boolean allAnswered=true;

            for(int i=0;i<answers.length;i++){

                if(answers[i]==0){

                    allAnswered=false;
                    break;

                }

            }

            session.setAttribute("answers",answers);
            session.setAttribute("status",status);

            if(!allAnswered){

                response.sendRedirect("quiz.jsp?msg=attemptAll");
                return;

            }

            response.sendRedirect("result.jsp");
            return;

        }

        //================ NAVIGATION =================

        if("next".equals(action)){

            qIndex++;

        }
        else if("prev".equals(action)){

            qIndex--;

        }
        else if("jump".equals(action)){

            try{

                qIndex=Integer.parseInt(
                        request.getParameter("jumpIndex"));

            }catch(Exception e){

                qIndex=0;

            }

        }

        if(qIndex<0)
            qIndex=0;

        if(qIndex>19)
            qIndex=19;

        session.setAttribute("qIndex",qIndex);
        session.setAttribute("answers",answers);
        session.setAttribute("status",status);

        response.sendRedirect("quiz.jsp");

    }

}