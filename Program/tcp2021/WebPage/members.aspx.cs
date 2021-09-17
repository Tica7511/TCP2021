using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebPage_members : System.Web.UI.Page
{
    public string usercompetence;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(LogInfo.mGuid))
            Response.Write("<script>alert('Please login again'); location='../WebPage/index.aspx';</script>");
        else
        {
            usercompetence = LogInfo.competence;
        }
    }
}