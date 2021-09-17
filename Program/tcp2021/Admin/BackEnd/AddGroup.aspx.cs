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

public partial class Admin_BackEnd_AddGroup : System.Web.UI.Page
{
    Group_DB db = new Group_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 修改 會員組別
        ///說    明:
        /// * Request["mode"]:  new=新增 mod=修改
        /// * Request["gguid"]:  guid
        /// * Request["name"]: 組別名稱
        /// * Request["status"]: 顯示狀態
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

            string mode = (string.IsNullOrEmpty(Request["mode"])) ? "" : Request["mode"].ToString().Trim();
            string gguid = (string.IsNullOrEmpty(Request["gguid"])) ? "" : Request["gguid"].ToString().Trim();
            string name = (string.IsNullOrEmpty(Request["name"])) ? "" : Request["name"].ToString().Trim();
            string status = (string.IsNullOrEmpty(Request["status"])) ? "" : Request["status"].ToString().Trim();
            string tmpGuid = (mode == "new") ? Guid.NewGuid().ToString("N") : gguid;
            string xmlstr = string.Empty;

            db._G_Guid = tmpGuid;
            db._G_Name = name;
            db._G_Status = status;
            db._G_ModId = LogInfo.mGuid;

            //新增組別
            if(mode == "new")
            {
                #region 檢查是否有相同組別名稱
                if (checkName(name))
                    throw new Exception("此組別名稱已存在");
                #endregion

                db._G_CreateId = LogInfo.mGuid;
                db.InsertGroup(oConn, myTrans);
            }
            else
            {
                db.UpdateGroup(oConn, myTrans);
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

    private bool checkName(string name)
    {
        bool status = false;
        db._G_Name = name;
        DataTable dt = db.CheckName();
        if (dt.Rows.Count > 0)
            status = true;

        return status;
    }
}