using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class Handler_GetTranscript : System.Web.UI.Page
{
    MemberClass_DB mcdb = new MemberClass_DB();
    //Questionnaires_DB qdb = new Questionnaires_DB();
    //MemberAssignment_DB madb = new MemberAssignment_DB();

    public string cCount;
    public string mcCount;
    public string qCount;
    public string aCount;
    public string maCount;
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 成員成績
        ///說明:
        ///-----------------------------------------------------
        XmlDocument xDoc = new XmlDocument();
        try
        {
            #region 課程
            mcdb._MC_Mguid = LogInfo.mGuid;
            DataTable mcdt = mcdb.GetCount();
            if (mcdt.Rows.Count > 0)
            {
                cCount = mcdt.Rows[0]["cCount"].ToString().Trim();
                mcCount = mcdt.Rows[0]["mcCount"].ToString().Trim();
            }
            #endregion

            //#region 問卷
            //qdb._Q_Parentid = LogInfo.mGuid;
            //DataTable qdt = qdb.GetCount();
            //if (qdt.Rows.Count > 0)
            //{
            //    qCount = qdt.Rows[0]["qCount"].ToString().Trim();
            //}
            //#endregion

            //#region 作業
            //madb._MA_Mguid = LogInfo.mGuid;
            //DataTable madt = madb.GetCount();
            //if (madt.Rows.Count > 0)
            //{
            //    maCount = madt.Rows[0]["maCount"].ToString().Trim();
            //    aCount = madt.Rows[0]["aCount"].ToString().Trim();
            //}
            //#endregion

            DataTable dt = new DataTable();
            dt.Columns.Add("cCount", typeof(string));
            dt.Columns.Add("mcCount", typeof(string));
            dt.Columns.Add("qCount", typeof(string));
            dt.Columns.Add("maCount", typeof(string));
            dt.Columns.Add("aCount", typeof(string));
            dt.Columns.Add("allCount", typeof(string));

            DataRow row = dt.NewRow();

            row["cCount"] = cCount;
            row["mcCount"] = mcCount;
            row["qCount"] = qCount;
            row["maCount"] = maCount;
            row["aCount"] = aCount;

            if ((cCount == mcCount) && (Convert.ToInt32(qCount) > 0) && (Convert.ToInt32(maCount) >= 1))
            {
                row["allCount"] = "Y";
            }
            else
            {
                row["allCount"] = "N";
            }

            dt.Rows.Add(row);
            
            string xmlstr = string.Empty;
            xmlstr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
            xmlstr = "<?xml version='1.0' encoding='utf-8'?><root>" + xmlstr + "</root>";
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