using System;
using System.Web;
using System.Configuration;
using System.Net;
using System.Data;
using System.IO;
using System.Linq;

namespace ED.HR.DOWNLOAD.WebForm
{
	public partial class DownloadImage : System.Web.UI.Page
    {
        string OrgName = string.Empty;
        string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"];
        File_DB fdb = new File_DB();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(Common.FilterCheckMarxString(Request.QueryString["v"])))
                {
                    if (!string.IsNullOrEmpty(Common.FilterCheckMarxString(Request.QueryString["type"])))
                        fdb._File_Type = Request.QueryString["type"].ToString();
                    if (!string.IsNullOrEmpty(Common.FilterCheckMarxString(Request.QueryString["encryname"])))
                        fdb._File_Encryname = Request.QueryString["encryname"].ToString();
                    fdb._File_Parentid = Common.Decrypt(Common.FilterCheckMarxString(Request.QueryString["v"]));
                    DataTable dt = fdb.GetFileDetail();
                    if (dt.Rows.Count > 0)
                    {
                        //附件資料夾檔名
                        switch (Common.FilterCheckMarxString(dt.Rows[0]["File_Type"].ToString()))
                        {
                            case "01":
                                UpLoadPath = UpLoadPath + "MemberImage\\";
                                break;
                            case "02":
                                UpLoadPath = UpLoadPath + "ClassFile\\";
                                break;
                        }

                        //原檔名
                        OrgName = Common.FilterCheckMarxString(dt.Rows[0]["File_Orgname"].ToString()) + Common.FilterCheckMarxString(dt.Rows[0]["File_Exten"].ToString());

                        // 附件目錄
                        DirectoryInfo dir = new DirectoryInfo(UpLoadPath);

                        //列舉全部檔案再比對檔名
                        string FileName = Common.FilterCheckMarxString(dt.Rows[0]["File_Encryname"].ToString()) + Common.FilterCheckMarxString(dt.Rows[0]["File_Exten"].ToString());
                        FileInfo file = dir.EnumerateFiles().FirstOrDefault(m => m.Name == FileName);

                        // 判斷檔案是否存在
                        if (file != null && file.Exists)
                            Download(file);
                        else
                            throw new Exception("File not exist");
                    }
                    else
                    {
                        throw new Exception("File not exist");
                    }
                }
            }
            catch (Exception ex)
            {
                //Response.Write("Error Message: " + ex.Message);
                //Response.End();
            }
        }


        private void Download(FileInfo DownloadFile)
        {
            Response.Clear();
            Response.ClearHeaders();
            Response.Buffer = false;
            Response.ContentType = getMineType(DownloadFile.Extension);
            string DownloadName = (OrgName == "") ? DownloadFile.Name : OrgName;
            Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(DownloadName, System.Text.Encoding.UTF8));
            Response.AppendHeader("Content-Length", DownloadFile.Length.ToString());
            Response.HeaderEncoding = System.Text.Encoding.GetEncoding("Big5");
            Response.WriteFile(DownloadFile.FullName);
            Response.Flush();
            Response.End();
        }

        #region 傳回 ContentType
        /// <summary>
        /// 傳回 ContentType
        /// </summary>
        public static string getMineType(string FileExtension)
        {
            Microsoft.Win32.RegistryKey rk = Microsoft.Win32.Registry.ClassesRoot.OpenSubKey(FileExtension);
            if (rk != null && rk.GetValue("Content Type") != null)
                return rk.GetValue("Content Type").ToString();
            else
                return "application/octet-stream";
        }
        #endregion

        #region 全檔案壓縮成ZIP
        //public void ZipFileDownload()
        //{
        //    if (Request.QueryString["gid"] != null && Request.QueryString["type"] != null && Request.QueryString["v"] != null)
        //    {
        //        string ZipName = "";
        //        Cont_DB Cont_Db = new Cont_DB();
        //        Cont_Db._cont_id = Request.QueryString["v"].ToString();
        //        DataTable Cdt = Cont_Db.SelectListById();
        //        if (Cdt.Rows.Count > 0)
        //            ZipName = Cdt.Rows[0]["cont_title"].ToString();
        //        File_DB File_Db = new File_DB();
        //        Xceed.Zip.ReaderWriter.Licenser.LicenseKey = "ZRT51-L1WSL-4KWJJ-GBEA";
        //        using (Stream zipFileStream = new FileStream(ConfigurationManager.AppSettings["UploadFileRootDir"] + "Photo\\" + ZipName + ".zip", FileMode.Create, FileAccess.Write))
        //        {
        //            File_Db._file_type = Request.QueryString["type"].ToString();
        //            File_Db._file_parentid = Common.Md5Decrypt(Request.QueryString["gid"].ToString());
        //            DataTable dt = File_Db.SelectFile();
        //            if (dt.Rows.Count > 0)
        //            {
        //                ZipWriter zipWriter = new ZipWriter(zipFileStream);
        //                for (int i = 0; i < dt.Rows.Count; i++)
        //                {

        //                    ZipItemLocalHeader localHeader;
        //                    //一般
        //                    localHeader = new ZipItemLocalHeader(
        //                      dt.Rows[i]["file_orgname"].ToString() + dt.Rows[i]["file_exten"].ToString(),
        //                      CompressionMethod.Deflated64,
        //                      CompressionLevel.Highest
        //                    );

        //                    zipWriter.WriteItemLocalHeader(localHeader);

        //                    using (Stream sourceStream = new FileStream(ConfigurationManager.AppSettings["UploadFileRootDir"] + "Photo\\" + dt.Rows[i]["file_encryname"].ToString() + dt.Rows[i]["file_exten"].ToString(), FileMode.Open, FileAccess.Read))
        //                    {
        //                        zipWriter.WriteItemData(sourceStream);
        //                    }
        //                }
        //                zipWriter.CloseZipFile();
        //                zipWriter.Dispose();
        //            }
        //        }
                
        //        System.IO.FileInfo files = new System.IO.FileInfo(UpLoadPath + "Photo\\" + ZipName + ".zip");
        //        bool filestat = files.Exists;
        //        if (filestat)
        //            Download(files);
        //    }
        //}
    #endregion
    }
}