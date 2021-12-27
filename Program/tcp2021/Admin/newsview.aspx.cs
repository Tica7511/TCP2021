using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_newsview : System.Web.UI.Page
{
    public string BrowserName;
    protected void Page_Load(object sender, EventArgs e)
    {
        BrowserName = Request.Browser.Browser.ToLower();
    }
}