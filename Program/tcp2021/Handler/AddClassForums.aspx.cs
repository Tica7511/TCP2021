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

public partial class Handler_AddClassForums : System.Web.UI.Page
{
    ClassForums_DB db = new ClassForums_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 新增 課程留言板 留言/回覆
        ///說    明:
        /// * Request["guid"]: 留言Guid
        /// * Request["content"]: 留言/回覆 內容
        /// * Request["cguid"]: 課程guid
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
                throw new Exception("Please login again");
            }
            #endregion

            string guid = (string.IsNullOrEmpty(Request["guid"])) ? "" : Request["guid"].ToString().Trim();
            string content = (string.IsNullOrEmpty(Request["content"])) ? "" : Request["content"].ToString().Trim();
            string cguid = (string.IsNullOrEmpty(Request["cguid"])) ? "" : Request["cguid"].ToString().Trim();
            string tmpGuid = Guid.NewGuid().ToString("N");
            string xmlstr = string.Empty;

            db._CF_Guid = tmpGuid;
            db._CF_Mguid = LogInfo.mGuid;
            db._CF_Cguid = cguid;
            db._CF_Content = content;
            db._CF_CreateId = LogInfo.mGuid;
            db._CF_ModId = LogInfo.mGuid;

            //新增留言
            if (string.IsNullOrEmpty(guid))
            {
                db._CF_Type = "01";
            }
            //新增回覆
            else
            {
                db._CF_Type = "02";
                db._CF_Parentid = guid;
            }

            db.addContent(oConn, myTrans);
            myTrans.Commit();

            xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>Sent Successful</Response></root>";
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