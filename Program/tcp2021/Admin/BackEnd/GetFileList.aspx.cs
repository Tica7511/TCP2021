using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class Admin_BackEnd_GetFileList : System.Web.UI.Page
{
    File_DB db = new File_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 檔案列表
        ///說明:
        /// * Request["SearchStr"]:關鍵字
        /// * Request["cguid"]:課程guid
        /// * Request["PageNo"]:欲顯示的頁碼, 由零開始
        /// * Request["PageSize"]:每頁顯示的資料筆數, 未指定預設10
        ///-----------------------------------------------------
        XmlDocument xDoc = new XmlDocument();
        try
        {
            //string SearchStr = (Request["SearchStr"] != null) ?Request["SearchStr"].ToString().Trim() : "";
            string cguid = string.IsNullOrEmpty(Request["cguid"].ToString().Trim()) ? "" : Request["cguid"].ToString().Trim();
            string PageNo = (Request["PageNo"] != null) ? Request["PageNo"].ToString().Trim() : "0";
            int PageSize = (Request["PageSize"] != null) ? int.Parse(Request["PageSize"].ToString().Trim()) : 10;

            //計算起始與結束
            int pageEnd = (int.Parse(PageNo) + 1) * PageSize;
            int pageStart = pageEnd - PageSize + 1;

            db._File_Parentid = cguid;
            db._File_Type = "02";
            DataSet ds = db.GetList(pageStart.ToString(), pageEnd.ToString());

            DataTable dt = ds.Tables[1];
            if (dt.Rows.Count > 0)
            {
                dt.Columns.Add("EncodeGuid", typeof(string));
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["EncodeGuid"] = Server.UrlEncode(Common.Encrypt(dt.Rows[i]["File_Parentid"].ToString()));
                }
            }

            string xmlstr = string.Empty;
            string totalxml = "<total>" + ds.Tables[0].Rows[0]["total"].ToString() + "</total>";
            xmlstr = DataTableToXml.ConvertDatatableToXML(ds.Tables[1], "dataList", "data_item");
            xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + totalxml + xmlstr + "</root>";
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