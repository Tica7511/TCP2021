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

public partial class Handler_AddMember : System.Web.UI.Page
{
    Member_DB mdb = new Member_DB();
    MemberLog_DB ml_db = new MemberLog_DB();
    File_DB fdb = new File_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 新增/修改 前台會員資料編輯
        ///說    明:
        /// * Request["introduction"]: 會員簡介
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
            
            string introduction = (string.IsNullOrEmpty(Request["introduction"])) ? "" : Request["introduction"].ToString().Trim();
            string xmlstr = string.Empty;
            
            mdb._M_Introduction = introduction;
            mdb._M_ModId = LogInfo.mGuid;

            mdb._M_Guid = LogInfo.mGuid;
            mdb.UpdateFrontMember(oConn, myTrans);

            #region Log
            // Member Log
            ml_db._ML_MID = LogInfo.mGuid;
            ml_db._ML_Type = "修改";
            ml_db._ML_IP = Common.GetIP4Address();
            ml_db._ML_CreateId = LogInfo.mGuid;
            ml_db._ML_ModId = LogInfo.mGuid;
            ml_db.addLog();
            #endregion

            // 檔案上傳
            HttpFileCollection uploadFiles = Request.Files;
            for (int i = 0; i < uploadFiles.Count; i++)
            {
                HttpPostedFile File = uploadFiles[i];
                if (File.FileName.Trim() != "")
                {
                    string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"] + "MemberImage\\";

                    //副檔名
                    string extension = Path.GetExtension(File.FileName);
                    //原檔名
                    string orgName = Path.GetFileName(File.FileName).Replace(extension, "");
                    //檔案大小
                    string file_size = File.ContentLength.ToString();
                    //if ((float.Parse(file_size) / 1024) > 2048)
                    //{
                    //    throw new Exception("檔案大小限制 2MB");
                    //}
                    //取得TIME與GUID
                    string timeguid = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Guid.NewGuid().ToString("N");
                    //儲存的名稱
                    string newName = timeguid.Replace("..", "").Replace("\\", "") + extension.Replace("..", "").Replace("\\", "");
                    //如果上傳路徑中沒有該目錄，則自動新增
                    if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))
                    {
                        Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
                    }

                    if (extension.ToLower() == ".jpeg" || extension.ToLower() == ".png" || extension.ToLower() == ".jpg" || extension.ToLower() == ".gif" || extension.ToLower() == ".svg")
                    {
                        File.SaveAs(UpLoadPath + newName);
                        //進資料庫前, 儲存名稱要去除副檔名
                        newName = newName.Replace(extension, "");

                        fdb._File_Type = "01";
                        fdb._File_Orgname = orgName;
                        fdb._File_Encryname = newName;
                        fdb._File_Exten = extension;
                        fdb._File_Size = file_size;
                        fdb._File_CreateId = LogInfo.mGuid;
                        fdb._File_ModId = LogInfo.mGuid;

                        fdb._File_Parentid = LogInfo.mGuid;
                        fdb.UpdateFile_Trans(oConn, myTrans);
                    }
                    else
                    {
                        throw new Exception("Picture format restrictions: .jpeg .png .jpg .gif .svg");
                    }
                }
            }

            myTrans.Commit();

            xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>Save complete</Response></root>";
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