using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class WebPage_news : System.Web.UI.Page
{
	News_DB ndb = new News_DB();
	private int nowPage;
	protected void Page_Load(object sender, EventArgs e)
	{
		if (string.IsNullOrEmpty(LogInfo.mGuid))
			Response.Write("<script>alert('Please login again'); location='login.aspx';</script>");

		nowPage = (Request["page"] != null) ? int.Parse(Request["page"].ToString().Trim()) : 1;
		if (!IsPostBack)
		{
			NewsList.DataSource = GetNewsList();
			NewsList.DataBind();
		}
	}

	/// <summary>
	/// 最新消息列表
	/// </summary>
	/// <returns></returns>
	private DataTable GetNewsList()
	{
		int PageNo = (Request["page"] != null) ? int.Parse(Request["page"].ToString().Trim()) : 1;
		int PageSize = 10;

		//計算起始與結束
		int pageEnd = PageNo * PageSize;
		int pageStart = pageEnd - PageSize + 1;

		DataSet ds = ndb.GetFrontEndNews(pageStart.ToString(), pageEnd.ToString());
		// 分頁
		GetPageList(ds.Tables[0].Rows[0]["total"].ToString());

		DataTable dt = ds.Tables[1];
		dt.Columns.Add("Detail_ID", typeof(string));
		dt.Columns.Add("Detail_Date", typeof(string));
		if (dt.Rows.Count > 0)
		{
			for (int i = 0; i < dt.Rows.Count; i++)
			{
				dt.Rows[i]["Detail_ID"] = Server.UrlEncode(Common.ToBase64String(dt.Rows[i]["N_ID"].ToString()));
				dt.Rows[i]["Detail_Date"] = dt.Rows[i]["N_Date"].ToString().Substring(0, 4) + "/" + dt.Rows[i]["N_Date"].ToString().Substring(4, 2) + "/" + dt.Rows[i]["N_Date"].ToString().Substring(6, 2) + " " + dt.Rows[i]["N_Date"].ToString().Substring(8, 2) + ":" + dt.Rows[i]["N_Date"].ToString().Substring(10, 2);
			}
		}
		return dt;
	}

	#region 分頁
	private void GetPageList(string total)
	{
		double totalData = int.Parse(total);
		int PageNum = 10; // 分頁頁籤顯示數,預設10
		int PageSize = 10; // 每頁顯示資料筆數,預設10

		double ItemNum = (PageSize == 0) ? totalData : PageSize;
		int PagesLen = Convert.ToInt32(Math.Ceiling(totalData / ItemNum));
		ViewState["__PagesLen"] = PagesLen;
		// 10筆資料以下不顯示
		if (PagesLen <= 1)
			PageList.Visible = false;
		else
			PageList.Visible = true;

		//頁碼
		int nPage = nowPage - 1; // 用 0 去計算
		int pn = (PageNum - 1);
		int tmp = nPage % PageNum;

		int startPage, endPage;
		endPage = (nPage - tmp) + pn;
		startPage = endPage - pn;

		//最後一頁不大於總頁數
		if (endPage > (PagesLen - 1))
			endPage = (PagesLen - 1);

		DataTable pdt = new DataTable();
		pdt.Columns.Add("page", typeof(string));
		pdt.Columns.Add("url", typeof(string));

		for (int i = startPage; i <= endPage; i++)
		{
			pdt.Rows.Add(new Object[] { (i + 1), "News.aspx?page=" + (i + 1)});
		}

		PageList.DataSource = pdt;
		PageList.DataBind();
	}

	protected void Repeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
	{
		if (e.Item.ItemType == ListItemType.Header)
		{
			LinkButton prevPage = (LinkButton)e.Item.FindControl("prevPage");
			if (nowPage == 1)
			{
				prevPage.CssClass = "pagestylegen pagestylenone";
				prevPage.Enabled = false;
			}
			else
			{
				prevPage.CssClass = "pagestylegen";
				prevPage.Enabled = true;
			}
		}

		if (e.Item.ItemType == ListItemType.Footer)
		{
			LinkButton nextPage = (LinkButton)e.Item.FindControl("nextPage");
			int pgLen = int.Parse(ViewState["__PagesLen"].ToString());
			if (nowPage == pgLen)
			{
				nextPage.CssClass = "pagestylegen pagestylenone";
				nextPage.Enabled = false;
			}
			else
			{
				nextPage.CssClass = "pagestylegen";
				nextPage.Enabled = true;
			}
		}
	}

	public string pNoClass(object page)
	{
		if (nowPage == Convert.ToInt32(page))
			return "pagestylecurrent";
		else
			return "";
	}

	/// <summary>
	/// 上一頁
	/// </summary>
	protected void PrevPage_click(object sender, EventArgs e)
	{
		if (nowPage != 1)
			Response.Redirect("~/WebPage/News.aspx?page=" + (nowPage - 1));
	}

	/// <summary>
	/// 下一頁
	/// </summary>
	protected void NextPage_click(object sender, EventArgs e)
	{
		int pgLen = int.Parse(ViewState["__PagesLen"].ToString());
		if (nowPage != pgLen)
			Response.Redirect("~/WebPage/News.aspx?page=" + (nowPage + 1));
	}
	#endregion
}