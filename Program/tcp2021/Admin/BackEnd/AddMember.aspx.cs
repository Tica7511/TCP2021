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

public partial class Admin_BackEnd_AddMember : System.Web.UI.Page
{
    Member_DB mdb = new Member_DB();
    MemberLog_DB ml_db = new MemberLog_DB();
    MemberPwdLog_DB mpl_db = new MemberPwdLog_DB();
    File_DB fdb = new File_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 新增/修改 會員管理
        ///說    明:
        /// * Request["guid"]:  guid
        /// * Request["account"]: 會員帳號
        /// * Request["name"]: 會員名稱
        /// * Request["mode"]: new 新增 / mod 修改
        /// * Request["password"]: 會員密碼
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
                throw new Exception("請重新登入");
            }
            #endregion

            string guid = (string.IsNullOrEmpty(Request["guid"])) ? "" : Request["guid"].ToString().Trim();
            string account = (string.IsNullOrEmpty(Request["account"])) ? "" : Request["account"].ToString().Trim();
            string name = (string.IsNullOrEmpty(Request["name"])) ? "" : Request["name"].ToString().Trim();
            string mode = (string.IsNullOrEmpty(Request["mode"])) ? "" : Request["mode"].ToString().Trim();
            string password = (string.IsNullOrEmpty(Request["password"])) ? "" : Request["password"].ToString().Trim();
            string competence = (string.IsNullOrEmpty(Request["competence"])) ? "" : Request["competence"].ToString().Trim();
            string group = (string.IsNullOrEmpty(Request["group"])) ? "" : Request["group"].ToString().Trim();
            //string introduction = (string.IsNullOrEmpty(Request["introduction"])) ? "" : Request["introduction"].ToString().Trim();
            string status = (string.IsNullOrEmpty(Request["status"])) ? "" : Request["status"].ToString().Trim();

            string tmpGuid = (mode == "new") ? Guid.NewGuid().ToString("N") : guid;
            string sqlAccount = string.Empty;
            string sqlPassword = string.Empty;
            string xmlstr = string.Empty;

            mdb._M_Guid = tmpGuid;
            mdb._M_Account = account;
            mdb._M_Name = name;
            mdb._M_Pwd = Server.UrlDecode(password);
            mdb._M_Group = group;
            //mdb._M_Introduction = introduction;
            mdb._M_Competence = competence;
            mdb._M_CreateId = LogInfo.mGuid;
            mdb._M_ModId = LogInfo.mGuid;
            mdb._M_Status = status;

            if (mode == "new")
            {
                #region 檢查帳號是否重複
                if (checkAcc(account))
                    throw new Exception("此帳號已存在");
                #endregion

                mdb._M_Guid = tmpGuid;
                mdb.addMember(oConn, myTrans);

                #region Log
                // Member Log
                ml_db._ML_MID = tmpGuid;
                ml_db._ML_Type = "新增";
                ml_db._ML_IP = Common.GetIP4Address();
                ml_db._ML_CreateId = LogInfo.mGuid;
                ml_db._ML_ModId = LogInfo.mGuid;
                ml_db.addLog();

                // Member PassWord Log
                mpl_db._MPL_MID = tmpGuid;
                mpl_db._MPL_ModPwd = Server.UrlDecode(password);
                mpl_db._MPL_IP = Common.GetIP4Address();
                mpl_db._MPL_CreateId = LogInfo.mGuid;
                mpl_db._MPL_ModId = LogInfo.mGuid;
                mpl_db.addLog();
                #endregion
            }
            else
            {
                mdb._M_Guid = tmpGuid;

                DataTable mdt = mdb.GetData();

                if (mdt.Rows.Count > 0)
                {
                    sqlAccount = mdt.Rows[0]["M_Account"].ToString().Trim();
                    sqlPassword = mdt.Rows[0]["M_Pwd"].ToString().Trim();
                }

                mdb.UpdateMember(oConn, myTrans);

                #region Log
                // Member Log
                ml_db._ML_MID = tmpGuid;
                ml_db._ML_Type = "修改";
                ml_db._ML_IP = Common.GetIP4Address();
                ml_db._ML_CreateId = LogInfo.mGuid;
                ml_db._ML_ModId = LogInfo.mGuid;
                ml_db.addLog();

                // Member PassWord Log
                mpl_db._MPL_MID = tmpGuid;
                mpl_db._MPL_ModPwd = Server.UrlDecode(password);
                mpl_db._MPL_IP = Common.GetIP4Address();
                mpl_db._MPL_CreateId = LogInfo.mGuid;
                mpl_db._MPL_ModId = LogInfo.mGuid;
                mpl_db.addLog();
                #endregion
            }

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

                        fdb._File_Parentid = tmpGuid;
                        fdb.UpdateFile_Trans(oConn, myTrans);
                    }
                    else
                    {
                        throw new Exception("圖片格式限制: .jpeg .png .jpg .gif .svg");
                    }
                }
            }

            myTrans.Commit();

            if (mode == "new")
            {
                xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>儲存完成</Response><relogin>N</relogin></root>";
            }
            else
            {
                if (tmpGuid == LogInfo.mGuid)
                {
                    if((account != sqlAccount) || (Server.UrlDecode(password) != sqlPassword))
                    {
                        xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>修改成功! 將轉往登入頁面 請重新登入</Response><relogin>Y</relogin></root>";
                    }
                    else
                    {
                        xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>儲存完成</Response><relogin>N</relogin></root>";
                    }
                }
                else
                {
                    xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>儲存完成</Response><relogin>N</relogin></root>";
                }
            }

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

    private bool checkAcc(string acc)
    {
        bool status = false;
        mdb._M_Account = acc;
        DataTable dt = mdb.CheckMember();
        if (dt.Rows.Count > 0)
            status = true;

        return status;
    }
}