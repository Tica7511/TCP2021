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

public partial class Admin_BackEnd_AddOtherClass : System.Web.UI.Page
{
    OtherClass_DB cdb = new OtherClass_DB();
    File_DB fdb = new File_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 新增/修改 選修課程
        ///說    明:
        /// * Request["guid"]:  guid
        /// * Request["name"]: 課程名稱
        /// * Request["embedcode"]: 影片嵌入碼
        /// * Request["teachername"]: 講師名稱
        /// * Request["opdate"]: 開放時間
        /// * Request["csdate"]: 關閉時間
        /// * Request["sort"]: 排序
        /// * Request["status"]: 顯示
        /// * Request["mode"]: new 新增 / mod 修改
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

            string guid = (string.IsNullOrEmpty(Request["guid"])) ? "" : Request["guid"].ToString().Trim();
            string name = (string.IsNullOrEmpty(Request["name"])) ? "" : Request["name"].ToString().Trim();
            string embedcode = (string.IsNullOrEmpty(Request["embedcode"])) ? "" : Request["embedcode"].ToString().Trim();
            string teachername = (string.IsNullOrEmpty(Request["teachername"])) ? "" : Request["teachername"].ToString().Trim();
            string opdate = (string.IsNullOrEmpty(Request["opdate"])) ? "" : Request["opdate"].ToString().Trim();
            string csdate = (string.IsNullOrEmpty(Request["csdate"])) ? "" : Request["csdate"].ToString().Trim();
            string sort = (string.IsNullOrEmpty(Request["sort"])) ? "" : Request["sort"].ToString().Trim();
            string status = (string.IsNullOrEmpty(Request["status"])) ? "" : Request["status"].ToString().Trim();
            string mode = (string.IsNullOrEmpty(Request["mode"])) ? "" : Request["mode"].ToString().Trim();

            string tmpGuid = (mode == "new") ? Guid.NewGuid().ToString("N") : guid;
            string xmlstr = string.Empty;
            cdb._OC_Name = name;
            cdb._OC_EmbedCode = Common.Encrypt(Server.UrlDecode(embedcode));
            cdb._OC_TeacherName = teachername;
            cdb._OC_OpenDate = opdate;
            cdb._OC_CloseDate = csdate;
            cdb._OC_Sort = sort;
            cdb._OC_Status = status;
            cdb._OC_CreateId = LogInfo.mGuid;
            cdb._OC_ModId = LogInfo.mGuid;

            if (mode == "new")
            {
                cdb._OC_Guid = tmpGuid;
                cdb.addOtherClass(oConn, myTrans);
            }
            else
            {
                cdb._OC_Guid = tmpGuid;
                cdb.UpdateOtherClass(oConn, myTrans);
            }

            // 檔案上傳
            HttpFileCollection uploadFiles = Request.Files;
            for (int i = 0; i < uploadFiles.Count; i++)
            {
                HttpPostedFile File = uploadFiles[i];
                if (File.FileName.Trim() != "")
                {
                    string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"] + "ClassFile\\";

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

                    if (extension.ToLower() != ".jpeg" && extension.ToLower() != ".png" && extension.ToLower() != ".jpg" && extension.ToLower() != ".gif" && extension.ToLower() != ".svg")
                    {
                        File.SaveAs(UpLoadPath + newName);
                        //進資料庫前, 儲存名稱要去除副檔名
                        newName = newName.Replace(extension, "");

                        fdb._File_Type = "02";
                        fdb._File_Orgname = orgName;
                        fdb._File_Encryname = newName;
                        fdb._File_Exten = extension;
                        fdb._File_Size = file_size;
                        fdb._File_CreateId = LogInfo.mGuid;
                        fdb._File_ModId = LogInfo.mGuid;

                        fdb._File_Parentid = tmpGuid;
                        fdb.UpdateFile_Trans(oConn, myTrans);
                    }
                    else
                    {
                        throw new Exception("上傳檔案格式限制: 不可為 .jpeg .png .jpg .gif .svg");
                    }
                }
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