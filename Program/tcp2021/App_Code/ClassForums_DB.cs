using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// ClassForums 的摘要描述
/// </summary>
public class ClassForums_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string CF_ID = string.Empty;
    string CF_Guid = string.Empty;
    string CF_Cguid = string.Empty;
    string CF_Type = string.Empty;
    string CF_Parentid = string.Empty;
    string CF_Mguid = string.Empty;
    string CF_Content = string.Empty;
    DateTime CF_CreateDate;
    string CF_CreateId = string.Empty;
    DateTime CF_ModDate;
    string CF_ModId = string.Empty;
    string CF_Status = string.Empty;
    #endregion
    #region Public

    public string _CF_ID { set { CF_ID = value; } }
    public string _CF_Guid { set { CF_Guid = value; } }
    public string _CF_Cguid { set { CF_Cguid = value; } }
    public string _CF_Type { set { CF_Type = value; } }
    public string _CF_Parentid { set { CF_Parentid = value; } }
    public string _CF_Mguid { set { CF_Mguid = value; } }
    public string _CF_Content { set { CF_Content = value; } }
    public DateTime _CF_CreateDate { set { CF_CreateDate = value; } }
    public string _CF_CreateId { set { CF_CreateId = value; } }
    public DateTime _CF_ModDate { set { CF_ModDate = value; } }
    public string _CF_ModId { set { CF_ModId = value; } }
    public string _CF_Status { set { CF_Status = value; } }
    #endregion

    public DataSet GetList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT convert(nvarchar(20), CF_ModDate, 111) as contentDate, 
  convert(nvarchar(20), CF_ModDate, 108) as contentTime,* 
into #tmp from ClassForums  
LEFT JOIN Member m ON CF_Mguid=M_Guid 
where CF_Cguid=@CF_Cguid and CF_Status='A' ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by CF_ModDate desc) itemNo,* from #tmp
)#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oCmd.Parameters.AddWithValue("@CF_Cguid", CF_Cguid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from ClassForums 
where CF_Guid=@CF_Guid and CF_Status=@CF_Status
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@CF_Guid", CF_Guid);
        oCmd.Parameters.AddWithValue("@CF_Status", "A");
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetComment()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select convert(nvarchar(20), CF_ModDate, 111) as contentDate, 
  convert(nvarchar(20), CF_ModDate, 108) as contentTime, * FROM ClassForums
  left join Member on CF_Mguid=M_Guid 
  where CF_Cguid=@CF_Cguid and CF_Type=@CF_Type and CF_Status='A' 
  order by CF_ModDate desc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@CF_Type", CF_Type);
        oCmd.Parameters.AddWithValue("@CF_Cguid", CF_Cguid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetReply()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select convert(nvarchar(20), CF_ModDate, 111) as contentDate, 
  convert(nvarchar(20), CF_ModDate, 108) as contentTime, * FROM ClassForums 
  left join Member on CF_Mguid=M_Guid 
  where CF_Parentid=@CF_Parentid and CF_Status='A' 
  order by CF_ModDate desc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@CF_Parentid", CF_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public void addContent(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"insert into ClassForums (
CF_Guid,
CF_Cguid,
CF_Type,
CF_Parentid,
CF_Mguid,
CF_Content,
CF_CreateDate,
CF_CreateId,
CF_ModDate,
CF_ModId,
CF_Status 
) values (
@CF_Guid,
@CF_Cguid,
@CF_Type,
@CF_Parentid,
@CF_Mguid,
@CF_Content,
@CF_CreateDate,
@CF_CreateId,
@CF_ModDate,
@CF_ModId,
@CF_Status 
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@CF_Guid", CF_Guid);
        oCmd.Parameters.AddWithValue("@CF_Cguid", CF_Cguid);
        oCmd.Parameters.AddWithValue("@CF_Type", CF_Type);
        oCmd.Parameters.AddWithValue("@CF_Parentid", CF_Parentid);
        oCmd.Parameters.AddWithValue("@CF_Content", CF_Content);
        oCmd.Parameters.AddWithValue("@CF_Mguid", CF_Mguid);
        oCmd.Parameters.AddWithValue("@CF_CreateDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@CF_CreateId", CF_CreateId);
        oCmd.Parameters.AddWithValue("@CF_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@CF_ModId", CF_ModId);
        oCmd.Parameters.AddWithValue("@CF_Status", "A");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateContent(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update ClassForums set 
            CF_Content=@CF_Content, 
            CF_ModId=@CF_ModId,
            CF_ModDate=@CF_ModDate 
            where CF_Guid=@CF_Guid  
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@CF_Guid", CF_Guid);
        oCmd.Parameters.AddWithValue("@CF_Content", CF_Content);
        oCmd.Parameters.AddWithValue("@CF_ModId", CF_ModId);
        oCmd.Parameters.AddWithValue("@CF_ModDate", DateTime.Now);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void DeleteComment(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update ClassForums set
            CF_Status=@CF_Status,
            CF_ModId=@CF_ModId,
            CF_ModDate=@CF_ModDate
            where CF_Guid=@CF_Guid  
");
        if (CF_Type == "01")
            sb.Append(@"update ClassForums set
            CF_Status=@CF_Status,
            CF_ModId=@CF_ModId,
            CF_ModDate=@CF_ModDate
            where CF_Parentid=@CF_Parentid");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@CF_Guid", CF_Guid);
        oCmd.Parameters.AddWithValue("@CF_Parentid", CF_Guid);
        oCmd.Parameters.AddWithValue("@CF_ModId", CF_ModId);
        oCmd.Parameters.AddWithValue("@CF_Type", CF_Type);
        oCmd.Parameters.AddWithValue("@CF_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@CF_Status", "D");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}