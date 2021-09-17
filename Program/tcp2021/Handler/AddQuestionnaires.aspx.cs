using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.IO;
using System.Data.SqlClient;
using System.Data;
using System.Xml;

public partial class Handler_AddQuestionnaires : System.Web.UI.Page
{
    Questionnaires_DB db = new Questionnaires_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 儲存問卷
        ///說    明:
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

            db._Q_Parentid = LogInfo.mGuid;
            db._Q_CreateId = LogInfo.mGuid;
            db._Q_ModId = LogInfo.mGuid;

            int lv1 = 0;
            int lv2 = 0;
            int lv3 = 0;

            for(lv1 = 1; lv1 <= 5; lv1++)
            {
                if (lv1 == 1)
                {
                    for (lv2 = 1; lv2 <= 8; lv2++)
                    {
                        if (lv2 == 1)
                        {
                            for (lv3 = 1; lv3 <= 3; lv3++)
                            {
                                db._Q_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addQuestionnaires(oConn, myTrans);
                            }
                        }
                        if (lv2 == 2)
                        {
                            for (lv3 = 1; lv3 <= 2; lv3++)
                            {
                                db._Q_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addQuestionnaires(oConn, myTrans);
                            }
                        }
                        if (lv2 == 3)
                        {
                            for (lv3 = 1; lv3 <= 3; lv3++)
                            {
                                db._Q_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addQuestionnaires(oConn, myTrans);
                            }
                        }
                        if (lv2 == 4)
                        {
                            for (lv3 = 1; lv3 <= 2; lv3++)
                            {
                                db._Q_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addQuestionnaires(oConn, myTrans);
                            }
                        }
                        if (lv2 == 5)
                        {
                            for (lv3 = 1; lv3 <= 3; lv3++)
                            {
                                db._Q_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addQuestionnaires(oConn, myTrans);
                            }
                        }
                        if (lv2 == 6)
                        {
                            for (lv3 = 1; lv3 <= 2; lv3++)
                            {
                                db._Q_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addQuestionnaires(oConn, myTrans);
                            }
                        }
                    }
                }
                if (lv1 == 2)
                {
                    db._Q_Number = "2_1";
                    db._Q_Content = string.IsNullOrEmpty(Request["rd_2_1"].ToString().Trim()) ? "" : Request["rd_2_1"].ToString().Trim();
                    db.addQuestionnaires(oConn, myTrans);
                }
                if (lv1 == 3)
                {
                    for (lv2 = 1; lv2 <= 6; lv2++)
                    {
                        db._Q_Number = lv1 + "_" + lv2;
                        db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2].ToString().Trim();
                        db.addQuestionnaires(oConn, myTrans);
                    }
                }
                if (lv1 == 4)
                {
                    for (lv2 = 1; lv2 <= 2; lv2++)
                    {
                        db._Q_Number = lv1 + "_" + lv2;
                        db._Q_Content = string.IsNullOrEmpty(Request["rd_" + lv1 + "_" + lv2].ToString().Trim()) ? "" : Request["rd_" + lv1 + "_" + lv2].ToString().Trim();
                        db.addQuestionnaires(oConn, myTrans);
                    }
                }
                if (lv1 == 5)
                {
                    db._Q_Number = "5_1";
                    db._Q_Content = string.IsNullOrEmpty(Request["rd_5_1"].ToString().Trim()) ? "" : Request["rd_5_1"].ToString().Trim();
                    db.addQuestionnaires(oConn, myTrans);
                }
            }

            myTrans.Commit();

            string xmlstr = string.Empty;
            xmlstr = "<?xml version='1.0' encoding='utf-8'?><root><Response>Submit Successful</Response></root>";
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