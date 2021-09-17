using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_leader : System.Web.UI.Page
{
    public string username;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(LogInfo.mGuid))
            Response.Write("<script>alert('Please login again'); location='../WebPage/login.aspx';</script>");
        else
            // 登入者姓名
            username = (string.IsNullOrEmpty(LogInfo.name)) ? "" : LogInfo.name;

        if (LogInfo.competence == "02")
            Response.Write("<script>alert('You have no competence to access this page, you will be return to Online Courses'); location='../WebPage/classlist.aspx';</script>");
    }
}