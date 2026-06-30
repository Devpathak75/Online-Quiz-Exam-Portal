package com.quiz.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.quiz.dao.DBConnection;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

public class PdfServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");

        if (type == null) {
            type = "attempted";
        }

        try {

            Document document = new Document();

            if ("attempted".equals(type)) {

                response.setContentType("application/pdf");
                response.setHeader(
                        "Content-Disposition",
                        "attachment; filename=Attempted_Students_Report.pdf");

            } else {

                response.setContentType("application/pdf");
                response.setHeader(
                        "Content-Disposition",
                        "attachment; filename=Remaining_Students_Report.pdf");

            }

            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();

            Font titleFont = new Font(Font.HELVETICA, 18, Font.BOLD);
            Font normalFont = new Font(Font.HELVETICA, 12);

            document.add(new Paragraph(
                    "DEVS INSTITUTE OF TECHNOLOGY AND ENGINEERING",
                    titleFont));

            document.add(new Paragraph(
                    "ONLINE QUIZ EXAMINATION SYSTEM",
                    titleFont));

            document.add(new Paragraph(" "));

            if ("attempted".equals(type)) {

                document.add(new Paragraph(
                        "ATTEMPTED STUDENTS REPORT",
                        titleFont));

            } else {

                document.add(new Paragraph(
                        "REMAINING STUDENTS REPORT",
                        titleFont));

            }

            document.add(new Paragraph(" "));
            document.add(new Paragraph("Generated Automatically", normalFont));
            document.add(new Paragraph(" "));

            Connection con = DBConnection.getConnection();

            PreparedStatement ps;

            ResultSet rs;

            if ("attempted".equals(type)) {

                ps = con.prepareStatement(

                        "SELECT * FROM students WHERE attempted=1 ORDER BY score DESC"

                );

            } else {

                ps = con.prepareStatement(

                        "SELECT * FROM students WHERE attempted=0 ORDER BY enrollment"

                );

            }

            rs = ps.executeQuery();

            PdfPTable table;

            if ("attempted".equals(type)) {

                table = new PdfPTable(8);
                table.setWidthPercentage(100);

                table.addCell(new PdfPCell(new Phrase("Enrollment")));
                table.addCell(new PdfPCell(new Phrase("Name")));
                table.addCell(new PdfPCell(new Phrase("Department")));
                table.addCell(new PdfPCell(new Phrase("Email")));
                table.addCell(new PdfPCell(new Phrase("Score")));
                table.addCell(new PdfPCell(new Phrase("Percentage")));
                table.addCell(new PdfPCell(new Phrase("Grade")));
                table.addCell(new PdfPCell(new Phrase("Result")));

                while (rs.next()) {

                    table.addCell(rs.getString("enrollment"));
                    table.addCell(rs.getString("name"));
                    table.addCell(rs.getString("department"));
                    table.addCell(rs.getString("email"));

                    table.addCell(
                        rs.getInt("score") + "/" +
                        rs.getInt("total_questions")
                    );

                    table.addCell(
                        String.format("%.2f",
                        rs.getDouble("percentage")) + "%"
                    );

                    table.addCell(rs.getString("grade"));
                    table.addCell(rs.getString("result"));

                }

            }
            else {

                table = new PdfPTable(5);
                table.setWidthPercentage(100);

                table.addCell(new PdfPCell(new Phrase("Enrollment")));
                table.addCell(new PdfPCell(new Phrase("Name")));
                table.addCell(new PdfPCell(new Phrase("Department")));
                table.addCell(new PdfPCell(new Phrase("Email")));
                table.addCell(new PdfPCell(new Phrase("Status")));

                while (rs.next()) {

                    table.addCell(rs.getString("enrollment"));
                    table.addCell(rs.getString("name"));
                    table.addCell(rs.getString("department"));
                    table.addCell(rs.getString("email"));
                    table.addCell("NOT ATTEMPTED");

                }

            }

            document.add(table);

            rs.close();
            ps.close();
            con.close();

            document.close();

            } catch (DocumentException e) {

                throw new ServletException(e);

            } catch (Exception e) {

                throw new ServletException(e);

            }

            }

            }