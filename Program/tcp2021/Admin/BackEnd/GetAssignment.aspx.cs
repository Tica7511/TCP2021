using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class Admin_BackEnd_GetAssignment : System.Web.UI.Page
{
    Assignment_DB adb = new Assignment_DB();
    MemberAssignment_DB madb = new MemberAssignment_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 作業列表
        ///說明:
        /// * Request["type"]: list=列表 data=細項 
        /// * Request["aguid"]: 作業guid 
        ///-----------------------------------------------------
        XmlDocument xDoc = new XmlDocument();
        try
        {
            //string SearchStr = (Request["SearchStr"] != null) ?Request["SearchStr"].ToString().Trim() : "";
            string type = (string.IsNullOrEmpty(Request["type"].ToString().Trim())) ? "" : Request["type"].ToString().Trim();
            string aguid = (string.IsNullOrEmpty(Request["aguid"].ToString().Trim())) ? "" : Request["aguid"].ToString().Trim();

            DataTable dt = new DataTable();

            if (type == "list")
            {
                //mdb._KeyWord = SearchStr;
                dt = adb.GetList();

                string xmlstr = string.Empty;

                xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + "</root>";
                xDoc.LoadXml(xmlstr);
            }
            else
            {
                adb._A_Guid = aguid;
                dt = adb.GetData();

                if (dt.Rows.Count > 0)
                {
                    dt.Columns.Add("EncodeGuid", typeof(string));
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        dt.Rows[i]["EncodeGuid"] = Server.UrlEncode(Common.Encrypt(dt.Rows[i]["A_Guid"].ToString()));
                    }
                }

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