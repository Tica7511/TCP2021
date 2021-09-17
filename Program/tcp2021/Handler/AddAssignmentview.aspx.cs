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

public partial class Handler_AddAssignmentview : System.Web.UI.Page
{
    MemberAssignment_DB db = new MemberAssignment_DB();
    Assignment_DB adb = new Assignment_DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        ///-----------------------------------------------------
        ///功    能: 儲存作業
        ///說    明:
        /// * Request["aguid"]: 作業guid
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

            string aguid = (string.IsNullOrEmpty(Request["aguid"].ToString().Trim())) ? "" : Request["aguid"].ToString().Trim();
            string sort = string.Empty;

            adb._A_Guid = aguid;
            DataTable dt = adb.GetData();

            if (dt.Rows.Count > 0)
            {
                sort = dt.Rows[0]["A_Sort"].ToString().Trim();
            }

            db._MA_Parentid = aguid;
            db._MA_Mguid = LogInfo.mGuid;
            db._MA_CreateId = LogInfo.mGuid;
            db._MA_ModId = LogInfo.mGuid;

            int lv1 = 0;
            int lv2 = 0;
            int lv3 = 0;

            for (lv1 = 5; lv1 <= 7; lv1++)
            {
                if (lv1 == 5)
                {
                    for (lv2 = 1; lv2 <= 13; lv2++)
                    {
                        if (lv2 == 1)
                        {
                            for (lv3 = 1; lv3 <= 9; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 2)
                        {
                            for (lv3 = 1; lv3 <= 2; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 3)
                        {
                            for (lv3 = 1; lv3 <= 5; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 4)
                        {
                            for (lv3 = 1; lv3 <= 7; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 5)
                        {
                            for (lv3 = 1; lv3 <= 8; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 6)
                        {
                            for (lv3 = 1; lv3 <= 5; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 7)
                        {
                            for (lv3 = 1; lv3 <= 7; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 8)
                        {
                            for (lv3 = 1; lv3 <= 5; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 9)
                        {
                            for (lv3 = 1; lv3 < 2; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 10)
                        {
                            for (lv3 = 1; lv3 < 2; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 11)
                        {
                            for (lv3 = 1; lv3 <= 6; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 12)
                        {
                            for (lv3 = 1; lv3 <= 3; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                        if (lv2 == 13)
                        {
                            for (lv3 = 1; lv3 <= 3; lv3++)
                            {
                                db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                db.addAssignment(oConn, myTrans);
                            }
                        }
                    }
                }
                if(sort != "1")
                {
                    if (lv1 == 7)
                    {
                        for (lv2 = 1; lv2 <= 2; lv2++)
                        {
                            if (lv2 == 1)
                            {
                                for (lv3 = 1; lv3 < 2; lv3++)
                                {
                                    db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                    db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db.addAssignment(oConn, myTrans);
                                }
                            }
                            if (lv2 == 2)
                            {
                                for (lv3 = 1; lv3 <= 4; lv3++)
                                {
                                    db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                    db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db.addAssignment(oConn, myTrans);
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (lv1 == 6)
                    {
                        for (lv2 = 1; lv2 <= 5; lv2++)
                        {
                            if (lv2 == 1)
                            {
                                for (lv3 = 1; lv3 <= 3; lv3++)
                                {
                                    db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                    db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db.addAssignment(oConn, myTrans);
                                }
                            }
                            if (lv2 == 2)
                            {
                                for (lv3 = 1; lv3 <= 2; lv3++)
                                {
                                    db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                    db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db.addAssignment(oConn, myTrans);
                                }
                            }
                            if (lv2 == 3)
                            {
                                for (lv3 = 1; lv3 <= 2; lv3++)
                                {
                                    db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                    db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db.addAssignment(oConn, myTrans);
                                }
                            }
                            if (lv2 == 4)
                            {
                                for (lv3 = 1; lv3 <= 2; lv3++)
                                {
                                    db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                    db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db.addAssignment(oConn, myTrans);
                                }
                            }
                            if (lv2 == 5)
                            {
                                for (lv3 = 1; lv3 < 2; lv3++)
                                {
                                    db._MA_Number = lv1 + "_" + lv2 + "_" + lv3;
                                    db._MA_Applicability = string.IsNullOrEmpty(Request["rda_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rda_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_IsShare = string.IsNullOrEmpty(Request["rds_" + lv1 + "_" + lv2 + "_" + lv3]) ? "" : Request["rds_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_RelevantStandards = string.IsNullOrEmpty(Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtrs_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db._MA_Justification = string.IsNullOrEmpty(Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim()) ? "" : Request["txtjf_" + lv1 + "_" + lv2 + "_" + lv3].ToString().Trim();
                                    db.addAssignment(oConn, myTrans);
                                }
                            }
                        }
                    }
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