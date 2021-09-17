using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;

public partial class Admin_BackEnd_GetTranscript : System.Web.UI.Page
{
    MemberClass_DB mcdb = new MemberClass_DB();
    Questionnaires_DB qdb = new Questionnaires_DB();
    MemberAssignment_DB madb = new MemberAssignment_DB();
    Member_DB mdb = new Member_DB();

    public string cCount;
    public string mcCount;
    //public string qCount;
    //public string aCount;
    //public string maCount;
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 成員成績
        ///說明:
        /// * Request["PageNo"]:欲顯示的頁碼, 由零開始
        /// * Request["PageSize"]:每頁顯示的資料筆數, 未指定預設10
        ///-----------------------------------------------------
        XmlDocument xDoc = new XmlDocument();
        try
        {
            string PageNo = (Request["PageNo"] != null) ? Request["PageNo"].ToString().Trim() : "0";
            int PageSize = (Request["PageSize"] != null) ? int.Parse(Request["PageSize"].ToString().Trim()) : 10;

            //計算起始與結束
            int pageEnd = (int.Parse(PageNo) + 1) * PageSize;
            int pageStart = pageEnd - PageSize + 1;

            DataSet ds = new DataSet();

            if (LogInfo.competence == "01")
            {
                ds = mdb.GetList2(pageStart.ToString(), pageEnd.ToString());
            }
            else
            {
                mdb._M_Group = LogInfo.group;
                ds = mdb.GetListLeader2(pageStart.ToString(), pageEnd.ToString());
            }

            DataTable dt = ds.Tables[1];

            dt.Columns.Add("cCount", typeof(string));
            dt.Columns.Add("mcCount", typeof(string));
            //dt.Columns.Add("qCount", typeof(string));
            //dt.Columns.Add("maCount", typeof(string));
            //dt.Columns.Add("aCount", typeof(string));
            dt.Columns.Add("allCount", typeof(string));

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    getClass(dt.Rows[i]["M_Guid"].ToString().Trim());
                    //getQuestion(dt.Rows[i]["M_Guid"].ToString().Trim());
                    //getAssignment(dt.Rows[i]["M_Guid"].ToString().Trim());

                    dt.Rows[i]["cCount"] = cCount;
                    dt.Rows[i]["mcCount"] = mcCount;
                    //dt.Rows[i]["qCount"] = qCount;
                    //dt.Rows[i]["maCount"] = maCount;
                    //dt.Rows[i]["aCount"] = aCount;

                    if ((cCount == mcCount) && (mcCount != "0"))
                    {
                        dt.Rows[i]["allCount"] = "Y";
                    }
                    else
                    {
                        dt.Rows[i]["allCount"] = "N";
                    }

                    cCount = string.Empty;
                    mcCount = string.Empty;
                    //qCount = string.Empty;
                    //maCount = string.Empty;
                    //aCount = string.Empty;
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

    #region 課程
    public void getClass(string mguid)
    {
        mcdb._MC_Mguid = mguid;
        DataTable mcdt = mcdb.GetCount();
        if (mcdt.Rows.Count > 0)
        {
            cCount = mcdt.Rows[0]["cCount"].ToString().Trim();
            mcCount = mcdt.Rows[0]["mcCount"].ToString().Trim();
        }
    }
    #endregion

    //#region 問卷
    //public void getQuestion(string mguid)
    //{
    //    qdb._Q_Parentid = mguid;
    //    DataTable qdt = qdb.GetCount();
    //    if (qdt.Rows.Count > 0)
    //    {
    //        qCount = qdt.Rows[0]["qCount"].ToString().Trim();
    //    }
    //}
    //#endregion

    //#region 作業
    //public void getAssignment(string mguid)
    //{
    //    madb._MA_Mguid = mguid;
    //    DataTable madt = madb.GetCount();
    //    if (madt.Rows.Count > 0)
    //    {
    //        maCount = madt.Rows[0]["maCount"].ToString().Trim();
    //        aCount = madt.Rows[0]["aCount"].ToString().Trim();
    //    }
    //}
    //#endregion
}