using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;


/// <summary>
/// Class_DB 的摘要描述
/// </summary>
public class Class_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string C_ID = string.Empty;
    string C_Guid = string.Empty;
    string C_Name = string.Empty;
    string C_EmbedCode = string.Empty;
    string C_TeacherName = string.Empty;
    string C_OpenDate = string.Empty;
    string C_CloseDate = string.Empty;
    string C_Sort = string.Empty;
    DateTime C_CreateDate;
    string C_CreateId = string.Empty;
    DateTime C_ModDate;
    string C_ModId = string.Empty;
    string C_Status = string.Empty;
    #endregion
    #region Public
    public string _C_ID { set { C_ID = value; } }
    public string _C_Guid { set { C_Guid = value; } }
    public string _C_Name { set { C_Name = value; } }
    public string _C_EmbedCode { set { C_EmbedCode = value; } }
    public string _C_TeacherName { set { C_TeacherName = value; } }
    public string _C_OpenDate { set { C_OpenDate = value; } }
    public string _C_CloseDate { set { C_CloseDate = value; } }
    public string _C_Sort { set { C_Sort = value; } }
    public DateTime _C_CreateDate { set { C_CreateDate = value; } }
    public string _C_CreateId { set { C_CreateId = value; } }
    public DateTime _C_ModDate { set { C_ModDate = value; } }
    public string _C_ModId { set { C_ModId = value; } }
    public string _C_Status { set { C_Status = value; } }
    #endregion

    public DataTable GetList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from Class where C_Status='A' 
order by convert(int, C_Sort) asc 
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
into #tmp from Class ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by convert(int, C_Sort)) itemNo,* from #tmp
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

    public DataTable GetClassSort(string mode)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        if(mode == "new")
            sb.Append(@"
declare @sortCount int

SELECT @sortCount=COUNT(*) from Class

if(@sortCount>0)
    begin
        SELECT MAX(CONVERT(int, C_Sort))+1 as C_Sort from Class
    end
else
    begin
        SELECT 1 as C_Sort
    end
");
        else
            sb.Append(@"SELECT C_Sort from Class order by convert(int, C_Sort) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@C_Guid", C_Guid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from Class where C_Guid=@C_Guid ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@C_Guid", C_Guid);
        oda.Fill(ds);
        return ds;
    }

    public void addClass(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"insert into Class (
C_Guid,
C_Name,
C_EmbedCode,
C_TeacherName,
C_OpenDate,
C_CloseDate,
C_Sort,
C_CreateId,
C_ModId,
C_Status
) values (
@C_Guid,
@C_Name,
@C_EmbedCode,
@C_TeacherName,
@C_OpenDate,
@C_CloseDate,
@C_Sort,
@C_CreateId,
@C_ModId,
@C_Status 
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@C_Guid", C_Guid);
        oCmd.Parameters.AddWithValue("@C_Name", C_Name);
        oCmd.Parameters.AddWithValue("@C_EmbedCode", C_EmbedCode);
        oCmd.Parameters.AddWithValue("@C_TeacherName", C_TeacherName);
        oCmd.Parameters.AddWithValue("@C_OpenDate", C_OpenDate);
        oCmd.Parameters.AddWithValue("@C_CloseDate", C_CloseDate);
        oCmd.Parameters.AddWithValue("@C_Sort", C_Sort);
        oCmd.Parameters.AddWithValue("@C_CreateId", C_CreateId);
        oCmd.Parameters.AddWithValue("@C_ModId", C_ModId);
        oCmd.Parameters.AddWithValue("@C_Status", C_Status);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateClass(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
declare @orgSort nvarchar(3)  
declare @nowGuid nvarchar(50) 
select @orgSort=C_Sort from Class where C_Guid=@C_Guid 
select @nowGuid=C_Guid from Class where C_Sort=@C_Sort 

if(@C_Guid <> @nowGuid)
	begin
		update Class
		set C_Sort=@orgSort
		where C_Guid=@nowGuid

		update Class
		set C_Sort=@C_Sort
		where C_Guid=@C_Guid
	end

update Class set
C_Guid=@C_Guid,
C_Name=@C_Name,
C_EmbedCode=@C_EmbedCode,
C_TeacherName=@C_TeacherName,
C_OpenDate=@C_OpenDate,
C_CloseDate=@C_CloseDate, 
C_ModId=@C_ModId,
C_ModDate=@C_ModDate,
C_Status=@C_Status
where C_Guid=@C_Guid 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@C_Guid", C_Guid);
        oCmd.Parameters.AddWithValue("@C_Name", C_Name);
        oCmd.Parameters.AddWithValue("@C_EmbedCode", C_EmbedCode);
        oCmd.Parameters.AddWithValue("@C_TeacherName", C_TeacherName);
        oCmd.Parameters.AddWithValue("@C_OpenDate", C_OpenDate);
        oCmd.Parameters.AddWithValue("@C_CloseDate", C_CloseDate);
        oCmd.Parameters.AddWithValue("@C_Sort", C_Sort);
        oCmd.Parameters.AddWithValue("@C_ModId", C_ModId);
        oCmd.Parameters.AddWithValue("@C_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@C_Status", C_Status);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}