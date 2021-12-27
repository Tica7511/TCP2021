using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class Handler_GetNews : System.Web.UI.Page
{
    News_DB db = new News_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 新聞列表
        ///說明:
        /// * Request["type"]: list=列表 data=細項
        ///-----------------------------------------------------
        XmlDocument xDoc = new XmlDocument();
        try
        {
            //string SearchStr = (Request["SearchStr"] != null) ?Request["SearchStr"].ToString().Trim() : "";
            string type = (string.IsNullOrEmpty(Request["type"].ToString().Trim())) ? "" : Request["type"].ToString().Trim();
            string nid = (string.IsNullOrEmpty(Request["nid"].ToString().Trim())) ? "" : Request["nid"].ToString().Trim();

            if (type == "list")
            {
                //mdb._KeyWord = SearchStr;
                DataTable dt = db.GetList();

                string xmlstr = string.Empty;

                xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + "</root>";
                xDoc.LoadXml(xmlstr);
            }
            else
            {
                //mcdb._MC_Parentid = cguid;
                //mcdb._MC_Mguid = LogInfo.mGuid;
                //mcdb._MC_CreateId = LogInfo.mGuid;
                //mcdb._MC_ModId = LogInfo.mGuid;
                //DataTable dt = mcdb.GetData();
                //if (dt.Rows.Count > 0)
                //{
                //    dt.Columns.Add("EncodeEmbedCode", typeof(string));
                //    for (int i = 0; i < dt.Rows.Count; i++)
                //    {
                //        dt.Rows[i]["EncodeEmbedCode"] = Common.Decrypt(dt.Rows[i]["C_EmbedCode"].ToString());
                //    }
                //}
                //fdb._File_Parentid = cguid;
                //fdb._File_Type = "02";
                //DataTable dt2 = fdb.GetFileDetail();
                //if (dt2.Rows.Count > 0)
                //{
                //    dt2.Columns.Add("EncodeGuid", typeof(string));
                //    for (int i = 0; i < dt2.Rows.Count; i++)
                //    {
                //        dt2.Rows[i]["EncodeGuid"] = Server.UrlEncode(Common.Encrypt(dt2.Rows[i]["File_Parentid"].ToString()));
                //    }
                //}
                //string xmlstr = string.Empty;
                //string xmlstr2 = string.Empty;
                //xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                //xmlstr2 = DataTableToXml.ConvertDatatableToXML(dt2, "dataList2", "data_item2");
                //xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + xmlstr2 + "</root>";
                //xDoc.LoadXml(xmlstr);
            }
        }
        catch (Exception ex)
        {
            xDoc = ExceptionUtil.GetExceptionDocument(ex);
        }
        Response.ContentType = System.Net.Mime.MediaTypeNames.Text.Xml;
        xDoc.Save(Response.Output);
    }
}