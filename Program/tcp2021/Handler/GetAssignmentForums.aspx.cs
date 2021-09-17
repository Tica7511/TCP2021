using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class Handler_GetAssignmentForums : System.Web.UI.Page
{
    AssignmentForums_DB db = new AssignmentForums_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 作業留言板
        ///說明:
        /// * Request["type"]: comment=留言 reply=回覆
        /// * Request["guid"]: 留言guid
        /// * Request["cguid"]: 課程guid
        ///-----------------------------------------------------
        XmlDocument xDoc = new XmlDocument();
        try
        {
            string type = (string.IsNullOrEmpty(Request["type"].ToString().Trim())) ? "" : Request["type"].ToString().Trim();
            string guid = (string.IsNullOrEmpty(Request["guid"].ToString().Trim())) ? "" : Request["guid"].ToString().Trim();
            string cguid = (string.IsNullOrEmpty(Request["cguid"].ToString().Trim())) ? "" : Request["cguid"].ToString().Trim();

            if (type == "comment")
            {
                db._AF_Type = "01";
                db._AF_Cguid = cguid;
                DataTable dt = db.GetComment();
                string xmlstr = string.Empty;
                xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + "</root>";
                xDoc.LoadXml(xmlstr);
            }
            else
            {
                db._AF_Parentid = guid;
                DataTable dt = db.GetReply();
                string xmlstr = string.Empty;
                xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + "</root>";
                xDoc.LoadXml(xmlstr);
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