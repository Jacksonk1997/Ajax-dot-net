<%@ WebHandler Language="C#" Class="Server1" %>

using System;
using System.Web;
using System.Data;
using System.Data.OleDb;
public class Server1 : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        String p = context.Request.QueryString["province"];
        String c = context.Request.QueryString["city"];
        String note = "";
        try
        {
            String s = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=F:\Learn\ajax.net\实验2\sy2\cities.mdb";
            OleDbConnection con = new OleDbConnection(s);
            con.Open();
            OleDbCommand cmd = new OleDbCommand();
            cmd.Connection = con;
            cmd.CommandText = "select cNote from cities where pName='" + p + "' and cName='" + c + "'";
            OleDbDataReader rd = cmd.ExecuteReader();
            if (rd.Read()) note = rd["cNote"].ToString();
            else note = "没有数据";
            rd.Close();
            con.Close();

        }
        catch (Exception exp) { note = exp.Message; }
        context.Response.Clear();
        context.Response.Write(note);
        context.Response.Flush();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}