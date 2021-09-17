using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// OtherClass_DB 的摘要描述
/// </summary>
public class OtherClass_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string OC_ID = string.Empty;
    string OC_Guid = string.Empty;
    string OC_Name = string.Empty;
    string OC_EmbedCode = string.Empty;
    string OC_TeacherName = string.Empty;
    string OC_OpenDate = string.Empty;
    string OC_CloseDate = string.Empty;
    string OC_Sort = string.Empty;
    DateTime OC_CreateDate;
    string OC_CreateId = string.Empty;
    DateTime OC_ModDate;
    string OC_ModId = string.Empty;
    string OC_Status = string.Empty;
    #endregion
    #region Public
    public string _OC_ID { set { OC_ID = value; } }
    public string _OC_Guid { set { OC_Guid = value; } }
    public string _OC_Name { set { OC_Name = value; } }
    public string _OC_EmbedCode { set { OC_EmbedCode = value; } }
    public string _OC_TeacherName { set { OC_TeacherName = value; } }
    public string _OC_OpenDate { set { OC_OpenDate = value; } }
    public string _OC_CloseDate { set { OC_CloseDate = value; } }
    public string _OC_Sort { set { OC_Sort = value; } }
    public DateTime _OC_CreateDate { set { OC_CreateDate = value; } }
    public string _OC_CreateId { set { OC_CreateId = value; } }
    public DateTime _OC_ModDate { set { OC_ModDate = value; } }
    public string _OC_ModId { set { OC_ModId = value; } }
    public string _OC_Status { set { OC_Status = value; } }
    #endregion

    public DataTable GetList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from OtherClass where OC_Status='A' 
order by OC_Sort asc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oda.Fill(ds);
        return ds;
    }

    public DataSet GetList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT *
into #tmp from OtherClass ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by OC_Sort) itemNo,* from #tmp
)#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetOtherClassSort(string mode)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        if (mode == "new")
            sb.Append(@"
declare @sortCount int

SELECT @sortCount=COUNT(*) from OtherClass

if(@sortCount>0)
    begin
        SELECT MAX(CONVERT(int, OC_Sort))+1 as OC_Sort from OtherClass
    end
else
    begin
        SELECT 1 as OC_Sort
    end
");
        else
            sb.Append(@"SELECT OC_Sort from OtherClass order by OC_Sort ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@OC_Guid", OC_Guid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from OtherClass where OC_Guid=@OC_Guid ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@OC_Guid", OC_Guid);
        oda.Fill(ds);
        return ds;
    }

    public void addOtherClass(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"insert into OtherClass (
OC_Guid,
OC_Name,
OC_EmbedCode,
OC_TeacherName,
OC_OpenDate,
OC_CloseDate,
OC_Sort,
OC_CreateId,
OC_ModId,
OC_Status
) values (
@OC_Guid,
@OC_Name,
@OC_EmbedCode,
@OC_TeacherName,
@OC_OpenDate,
@OC_CloseDate,
@OC_Sort,
@OC_CreateId,
@OC_ModId,
@OC_Status 
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@OC_Guid", OC_Guid);
        oCmd.Parameters.AddWithValue("@OC_Name", OC_Name);
        oCmd.Parameters.AddWithValue("@OC_EmbedCode", OC_EmbedCode);
        oCmd.Parameters.AddWithValue("@OC_TeacherName", OC_TeacherName);
        oCmd.Parameters.AddWithValue("@OC_OpenDate", OC_OpenDate);
        oCmd.Parameters.AddWithValue("@OC_CloseDate", OC_CloseDate);
        oCmd.Parameters.AddWithValue("@OC_Sort", OC_Sort);
        oCmd.Parameters.AddWithValue("@OC_CreateId", OC_CreateId);
        oCmd.Parameters.AddWithValue("@OC_ModId", OC_ModId);
        oCmd.Parameters.AddWithValue("@OC_Status", OC_Status);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateOtherClass(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
declare @orgSort nvarchar(3)  
declare @nowGuid nvarchar(50) 
select @orgSort=OC_Sort from OtherClass where OC_Guid=@OC_Guid 
select @nowGuid=OC_Guid from OtherClass where OC_Sort=@OC_Sort 

if(@OC_Guid <> @nowGuid)
	begin
		update OtherClass
		set OC_Sort=@orgSort
		where OC_Guid=@nowGuid

		update OtherClass
		set OC_Sort=@OC_Sort
		where OC_Guid=@OC_Guid
	end

update OtherClass set
OC_Guid=@OC_Guid,
OC_Name=@OC_Name,
OC_EmbedCode=@OC_EmbedCode,
OC_TeacherName=@OC_TeacherName,
OC_OpenDate=@OC_OpenDate,
OC_CloseDate=@OC_CloseDate, 
OC_ModId=@OC_ModId,
OC_ModDate=@OC_ModDate,
OC_Status=@OC_Status
where OC_Guid=@OC_Guid 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@OC_Guid", OC_Guid);
        oCmd.Parameters.AddWithValue("@OC_Name", OC_Name);
        oCmd.Parameters.AddWithValue("@OC_EmbedCode", OC_EmbedCode);
        oCmd.Parameters.AddWithValue("@OC_TeacherName", OC_TeacherName);
        oCmd.Parameters.AddWithValue("@OC_OpenDate", OC_OpenDate);
        oCmd.Parameters.AddWithValue("@OC_CloseDate", OC_CloseDate);
        oCmd.Parameters.AddWithValue("@OC_Sort", OC_Sort);
        oCmd.Parameters.AddWithValue("@OC_ModId", OC_ModId);
        oCmd.Parameters.AddWithValue("@OC_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@OC_Status", OC_Status);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}