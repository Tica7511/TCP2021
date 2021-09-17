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

public partial class Handler_UpdateMemberClass : System.Web.UI.Page
{
    MemberClass_DB db = new MemberClass_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 更新 會員課程 
        ///說    明:
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

            string cguid = (string.IsNullOrEmpty(Request["cguid"])) ? "" : Request["cguid"].ToString().Trim();
            string xmlstr = string.Empty;

            db._MC_Parentid = cguid;
            db._MC_IsFinish = "Y";
            db._MC_Mguid = LogInfo.mGuid;
            db._MC_ModId = LogInfo.mGuid;

            db.updateMemberClass(oConn, myTrans);
            
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