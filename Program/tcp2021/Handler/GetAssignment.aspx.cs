using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class Handler_GetAssignment : System.Web.UI.Page
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
        /// * Request["number"]: 作業序號
        ///-----------------------------------------------------
        XmlDocument xDoc = new XmlDocument();
        try
        {
            //string SearchStr = (Request["SearchStr"] != null) ?Request["SearchStr"].ToString().Trim() : "";
            string type = (string.IsNullOrEmpty(Request["type"].ToString().Trim())) ? "" : Request["type"].ToString().Trim();
            string aguid = (string.IsNullOrEmpty(Request["aguid"].ToString().Trim())) ? "" : Request["aguid"].ToString().Trim();
            string number = (string.IsNullOrEmpty(Request["number"].ToString().Trim())) ? "" : Request["number"].ToString().Trim();

            if (type == "list")
            {
                //mdb._KeyWord = SearchStr;
                DataTable dt = adb.GetList();

                if (dt.Rows.Count > 0)
                {
                    dt.Columns.Add("MA_IsFinish", typeof(string));
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        madb._MA_Parentid = dt.Rows[i]["A_Guid"].ToString().Trim();
                        madb._MA_Mguid = LogInfo.mGuid;
                        DataTable dt2 = madb.GetMemberData();
                        if (dt2.Rows.Count > 0)
                        {
                            DataTable dt3 = madb.GetIsFinish();
                            if (dt3.Rows.Count > 0)
                            {
                                dt.Rows[i]["MA_IsFinish"] = dt3.Rows[0]["MA_IsFinish"].ToString().Trim();
                            }
                        }
                        else
                        {
                            dt.Rows[i]["MA_IsFinish"] = "N";
                        }
                    }
                }

                string xmlstr = string.Empty;

                xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + "</root>";
                xDoc.LoadXml(xmlstr);
            }
            else
            {
                DataTable dt = new DataTable();
                madb._MA_Parentid = aguid;
                madb._MA_Mguid = LogInfo.mGuid;

                if (!string.IsNullOrEmpty(number))
                {
                    madb._MA_Number = number;
                    dt = madb.GetAssignmentData();
                }
                else
                {
                    dt = madb.GetMemberData();
                }

                adb._A_Guid = aguid;
                DataTable dt2 = adb.GetData();

                string xmlstr = string.Empty;
                string xmlstr2 = string.Empty;

                xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                xmlstr2 = DataTableToXml.ConvertDatatableToXML(dt2, "dataList2", "data_item2");
                xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + xmlstr2 + "</root>";
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