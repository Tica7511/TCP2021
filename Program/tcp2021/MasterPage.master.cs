using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage : System.Web.UI.MasterPage
{
    public string username;
    public string usercompetence;
    protected void Page_Load(object sender, EventArgs e)
    {
        // 登入者姓名
        username = (string.IsNullOrEmpty(LogInfo.name)) ? "" : LogInfo.name;
        // 登入者權限
        usercompetence = (string.IsNullOrEmpty(LogInfo.competence)) ? "" : LogInfo.competence;     
    }
}
