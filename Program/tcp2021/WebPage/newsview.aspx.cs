using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class WebPage_newsview : System.Web.UI.Page
{
	News_DB db = new News_DB();
	protected void Page_Load(object sender, EventArgs e)
	{
		if (string.IsNullOrEmpty(LogInfo.mGuid))
			Response.Write("<script>alert('Please login again'); location='login.aspx';</script>");

		if (!IsPostBack)
		{
			string id = (string.IsNullOrEmpty(Request["id"])) ? "" : Request["id"].ToString().Trim();
			string nDateTmp = string.Empty;
			if (id != "")
			{
				db._N_ID = Common.FromBase64String(id);
				DataTable dt = db.GetFrontEndDetail();
				if (dt.Rows.Count > 0)
				{
					nDateTmp = dt.Rows[0]["N_Date"].ToString();
					nTitle.Text = Server.HtmlEncode(dt.Rows[0]["N_Title"].ToString());
					nDate.Text = Server.HtmlEncode(nDateTmp.Substring(0, 4) + "/" + nDateTmp.Substring(4, 2) + "/" + nDateTmp.Substring(6, 2) + " " + nDateTmp.Substring(8, 2) + ":" + nDateTmp.Substring(10, 2));
					nContent.Text = Server.HtmlDecode(Server.HtmlEncode(dt.Rows[0]["N_Content"].ToString()));
				}
				else
				{
					Response.Write("Error Message: 查無此資料");
					Response.End();
				}
			}
			else
			{
				Response.Write("Error Message: 參數錯誤!!");
				Response.End();
			}
		}
	}
}