using System;
using System.Web;
using System.Configuration;
using System.Net;
using System.Data;
using System.IO;
using System.Linq;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using System.Text.RegularExpressions;

namespace ED.HR.EXPORTEXCEL.WebForm
{
    public partial class Excel : System.Web.UI.Page
    {
        Member_DB mdb = new Member_DB();
        Class_DB cdb = new Class_DB();
        MemberClass_DB mcdb = new MemberClass_DB();
        public const string invalidCharsRegex = @"[/\\*'?[\]:]+";
        public const int maxLength = 31;

        protected void Page_Load(object sender, EventArgs e)
        {
            string FilePath = string.Empty;
            HSSFWorkbook hssfworkbook;
            FileStream sampleFile;

            FilePath = Server.MapPath("~/Sample/會員觀看清單.xls");

            sampleFile = new FileStream(FilePath, FileMode.Open, FileAccess.Read);

            using (sampleFile)
            {
                //建立Excel
                hssfworkbook = new HSSFWorkbook(sampleFile);
            }

            DataTable cdt = cdb.GetList();

            if (cdt.Rows.Count > 0)
            {
                hssfworkbook.RemoveSheetAt(hssfworkbook.GetSheetIndex("工作表1"));

                for (int i = 0; i < cdt.Rows.Count; i++)
                {
                    InsertIntoSheetVer(hssfworkbook, cdt.Rows[i]["C_Guid"].ToString().Trim(), cdt.Rows[i]["C_Sort"].ToString().Trim());
                }
            }

            Response.ContentType = "application / vnd.ms - excel";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode("MemberList.xls", System.Text.Encoding.UTF8));
            Response.Clear();

            using (MemoryStream ms = new MemoryStream())
            {
                hssfworkbook.Write(ms);

                Response.BinaryWrite(ms.GetBuffer());
                Response.Flush();
                Response.End();
            }
        }

        public void InsertIntoSheetVer(HSSFWorkbook hssfworkbook, string classGuid, string className)
        {
            DataTable dt = new DataTable();

            if (LogInfo.competence == "01")
            {
                dt = getClassList(classGuid, mdb.GetListManage());

                if (dt.Rows.Count > 0)
                {
                    //className = Regex.Replace(className, invalidCharsRegex, " ").Replace("  ", " ").Trim();

                    //if (string.IsNullOrEmpty(className))
                    //{
                    //    className = "Default";   // cannot be empty
                    //}
                    //else if (className.Length > maxLength)
                    //{
                    //    className = className.Substring(0, maxLength);
                    //}

                    Sheet sheet = hssfworkbook.CreateSheet("Course " + className);

                    sheet.CreateRow(0);
                    sheet.GetRow(0).CreateCell(0).SetCellValue("會員姓名");
                    sheet.GetRow(0).CreateCell(1).SetCellValue("組別");
                    sheet.GetRow(0).CreateCell(2).SetCellValue("是否完成");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sheet.CreateRow(i + 1);
                        sheet.GetRow(i + 1).CreateCell(0).SetCellValue(dt.Rows[i]["M_Name"].ToString().Trim());
                        sheet.GetRow(i + 1).CreateCell(1).SetCellValue(dt.Rows[i]["G_Name"].ToString().Trim());
                        sheet.GetRow(i + 1).CreateCell(2).SetCellValue(dt.Rows[i]["isFinished"].ToString().Trim());
                    }
                }
            }
            else
            {
                mdb._M_Group = LogInfo.group;

                dt = getClassList(classGuid, mdb.GetListLeader());

                if(dt.Rows.Count > 0)
                {
                    Sheet sheet = hssfworkbook.CreateSheet("Course " + className);

                    sheet.CreateRow(0);
                    sheet.GetRow(0).CreateCell(0).SetCellValue("Name");
                    sheet.GetRow(0).CreateCell(1).SetCellValue("Group");
                    sheet.GetRow(0).CreateCell(2).SetCellValue("Finished");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sheet.CreateRow(i + 1);
                        sheet.GetRow(i + 1).CreateCell(0).SetCellValue(dt.Rows[i]["M_Name"].ToString().Trim());
                        sheet.GetRow(i + 1).CreateCell(1).SetCellValue(dt.Rows[i]["G_Name"].ToString().Trim());
                        sheet.GetRow(i + 1).CreateCell(2).SetCellValue(dt.Rows[i]["isFinished"].ToString().Trim());
                    }
                }
            }
        }

        public DataTable getClassList(string classGuid, DataTable dt)
        {
            dt.Columns.Add("isFinished", typeof(string));

            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    mcdb._MC_Parentid = classGuid;
                    mcdb._MC_Mguid = dt.Rows[i]["M_Guid"].ToString().Trim();
                    DataTable mcdt = mcdb.GetList();

                    if (mcdt.Rows.Count > 0)
                    {
                        dt.Rows[i]["isFinished"] = mcdt.Rows[0]["MC_IsFinish"].ToString().Trim();
                    }
                }
            }
            return dt;
        }

    }
}