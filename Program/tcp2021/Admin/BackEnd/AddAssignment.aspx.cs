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

public partial class Admin_BackEnd_AddAssignment : System.Web.UI.Page
{
    Assignment_DB db = new Assignment_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 新增/修改 課程
        ///說    明:
        /// * Request["aguid"]: 作業guid
        /// * Request["name"]: 課程名稱
        /// * Request["opdate"]: 開放時間
        /// * Request["csdate"]: 關閉時間
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

            string aguid = (string.IsNullOrEmpty(Request["aguid"])) ? "" : Request["aguid"].ToString().Trim();
            string name = (string.IsNullOrEmpty(Request["name"])) ? "" : Request["name"].ToString().Trim();
            string opdate = (string.IsNullOrEmpty(Request["opdate"])) ? "" : Request["opdate"].ToString().Trim();
            string csdate = (string.IsNullOrEmpty(Request["csdate"])) ? "" : Request["csdate"].ToString().Trim();

            string xmlstr = string.Empty;
            db._A_Guid = aguid;
            db._A_Name = name;
            db._A_OpenDate = opdate;
            db._A_CloseDate = csdate;
            db._A_CreateId = LogInfo.mGuid;
            db._A_ModId = LogInfo.mGuid;

            db.UpdateAsssignment(oConn, myTrans);

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