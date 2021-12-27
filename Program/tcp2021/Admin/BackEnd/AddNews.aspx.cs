using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Configuration;
using System.IO;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_BackEnd_AddNews : System.Web.UI.Page
{
	News_DB ndb = new News_DB();
	protected void Page_Load(object sender, EventArgs e)
	{
		///-----------------------------------------------------
		///功    能: 新增/修改 最新消息
		///說    明:
		/// * Request["id"]: News ID
		/// * Request["nGuid"]: News Guid
		/// * Request["mode"]: new 新增 / mod 修改
		/// * Request["nType"]: 類別
		/// * Request["nDate"]: 發佈日期
		/// * Request["nTitle"]: 標題
		/// * Request["nContent"]: 內容
		///-----------------------------------------------------
		XmlDocument xDoc = new XmlDocument();

		/// Transaction
		SqlConnection oConn = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"].ToString());
		oConn.Open();
		SqlCommand oCmmd = new SqlCommand();
		oCmmd.Connection = oConn;
		SqlTransaction myTrans = oConn.BeginTransaction();
		oCmmd.Transaction = myTrans;
		try
		{
			#region 檢查登入資訊
			if (LogInfo.mGuid == "")
			{
				throw new Exception("請重新登入");
			}
			#endregion

			string id = (string.IsNullOrEmpty(Request["id"])) ? "" : Common.FilterCheckMarxString(Request["id"].ToString().Trim());
			string nGuid = (string.IsNullOrEmpty(Request["nGuid"])) ? "" : Common.FilterCheckMarxString(Request["nGuid"].ToString().Trim());
			string mode = (string.IsNullOrEmpty(Request["mode"])) ? "" : Common.FilterCheckMarxString(Request["mode"].ToString().Trim());
			string nSort = (string.IsNullOrEmpty(Request["nSort"])) ? "" : Common.FilterCheckMarxString(Request["nSort"].ToString().Trim());
			string nDate = (string.IsNullOrEmpty(Request["nDate"])) ? "" : Common.FilterCheckMarxString(Request["nDate"].ToString().Trim());
			string nTitle = (string.IsNullOrEmpty(Request["nTitle"])) ? "" : Common.FilterCheckMarxString(Request["nTitle"].ToString().Trim());
			string nContent = (string.IsNullOrEmpty(Request["nContent"])) ? "" : Common.FilterCheckMarxString(Request["nContent"].ToString().Trim());
			string nStatus = (string.IsNullOrEmpty(Request["nStatus"])) ? "" : Common.FilterCheckMarxString(Request["nStatus"].ToString().Trim());

			string tmpGuid = (mode == "new") ? Guid.NewGuid().ToString("N") : nGuid;
			string xmlstr = string.Empty;
			ndb._N_Sort = nSort;
			ndb._N_Date = nDate;
			ndb._N_Title = nTitle;
			ndb._N_Status = nStatus;
			ndb._N_Content = Server.UrlDecode(nContent);
			ndb._N_CreateId = LogInfo.mGuid;
			ndb._N_ModId = LogInfo.mGuid;

			if (mode == "new")
			{
				ndb._N_Guid = tmpGuid;
				ndb.addNews(oConn, myTrans);
			}
			else
			{
				ndb._N_ID = id;
				ndb.UpdateNews(oConn, myTrans);
			}

			myTrans.Commit();

			xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>儲存完成</Response></root>";
			xDoc.LoadXml(xmlstr);
		}
		catch (Exception ex)
		{
			myTrans.Rollback();
			xDoc = ExceptionUtil.GetExceptionDocument(ex);
		}
		finally
		{
			oCmmd.Connection.Close();
			oConn.Close();
		}
		Response.ContentType = System.Net.Mime.MediaTypeNames.Text.Xml;
		xDoc.Save(Response.Output);
	}
}