using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class WebPage_Introductory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(LogInfo.mGuid))
            Response.Write("<script>alert('Please login again'); location='index.aspx';</script>");
    }
}