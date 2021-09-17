using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class Admin_BackEnd_DeleteFile : System.Web.UI.Page
{
    File_DB fdb = new File_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
		///功    能: 刪除檔案
		///說    明:
		/// * Request["gid"]: File Parentid
		/// * Request["encryname"]: File Encryname 
		/// * Request["type"]: File Type 
		///-----------------------------------------------------
		XmlDocument xDoc = new XmlDocument();
        try
        {
            #region 檢查登入資訊
            if (LogInfo.mGuid == "")
            {
                throw new Exception("請重新登入");
            }
            #endregion

            string gid = (string.IsNullOrEmpty(Request["gid"])) ? "" : Request["gid"].ToString().Trim();
            string encryname = (string.IsNullOrEmpty(Request["encryname"])) ? "" : Request["encryname"].ToString().Trim();
            string type = (string.IsNullOrEmpty(Request["type"])) ? "" : Request["type"].ToString().Trim();

            string xmlstr = string.Empty;
            fdb._File_Parentid = gid;
            fdb._File_Encryname = encryname;
            fdb._File_Type = type;
            fdb._File_ModId = LogInfo.mGuid;
            fdb.DeleteFile();

            xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>刪除成功</Response></root>";
            xDoc.LoadXml(xmlstr);
        }
        catch (Exception ex)
        {
            xDoc = ExceptionUtil.GetExceptionDocument(ex);
        }
        Response.ContentType = System.Net.Mime.MediaTypeNames.Text.Xml;
        xDoc.Save(Response.Output);
    }
}