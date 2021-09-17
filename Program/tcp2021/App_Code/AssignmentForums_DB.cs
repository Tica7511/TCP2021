using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// AssignmentForums_DB 的摘要描述
/// </summary>
public class AssignmentForums_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string AF_ID = string.Empty;
    string AF_Guid = string.Empty;
    string AF_Cguid = string.Empty;
    string AF_Type = string.Empty;
    string AF_Parentid = string.Empty;
    string AF_Mguid = string.Empty;
    string AF_Content = string.Empty;
    DateTime AF_CreateDate;
    string AF_CreateId = string.Empty;
    DateTime AF_ModDate;
    string AF_ModId = string.Empty;
    string AF_Status = string.Empty;
    #endregion
    #region Public

    public string _AF_ID { set { AF_ID = value; } }
    public string _AF_Guid { set { AF_Guid = value; } }
    public string _AF_Cguid { set { AF_Cguid = value; } }
    public string _AF_Type { set { AF_Type = value; } }
    public string _AF_Parentid { set { AF_Parentid = value; } }
    public string _AF_Mguid { set { AF_Mguid = value; } }
    public string _AF_Content { set { AF_Content = value; } }
    public DateTime _AF_CreateDate { set { AF_CreateDate = value; } }
    public string _AF_CreateId { set { AF_CreateId = value; } }
    public DateTime _AF_ModDate { set { AF_ModDate = value; } }
    public string _AF_ModId { set { AF_ModId = value; } }
    public string _AF_Status { set { AF_Status = value; } }
    #endregion

    public DataSet GetList(string pStart, string pEnd, string sort)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @aguid nvarchar(50)

select @aguid=A_Guid from Assignment where A_Sort=@A_Sort and A_Status='A' 

SELECT convert(nvarchar(20), AF_ModDate, 111) as contentDate, 
  convert(nvarchar(20), AF_ModDate, 108) as contentTime,* 
into #tmp from AssignmentForums  
LEFT JOIN Member m ON AF_Mguid=M_Guid 
where AF_Cguid=@aguid and AF_Status='A' ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by AF_ModDate desc) itemNo,* from #tmp
)#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oCmd.Parameters.AddWithValue("@A_Sort", sort);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from AssignmentForums 
where AF_Guid=@AF_Guid and AF_Status=@AF_Status
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@AF_Guid", AF_Guid);
        oCmd.Parameters.AddWithValue("@AF_Status", "A");
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetComment()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select convert(nvarchar(20), AF_ModDate, 111) as contentDate, 
  convert(nvarchar(20), AF_ModDate, 108) as contentTime, * FROM AssignmentForums
  left join Member on AF_Mguid=M_Guid 
  where AF_Cguid=@AF_Cguid and AF_Type=@AF_Type and AF_Status='A' 
  order by AF_ModDate desc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@AF_Type", AF_Type);
        oCmd.Parameters.AddWithValue("@AF_Cguid", AF_Cguid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetReply()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select convert(nvarchar(20), AF_ModDate, 111) as contentDate, 
  convert(nvarchar(20), AF_ModDate, 108) as contentTime, * FROM AssignmentForums 
  left join Member on AF_Mguid=M_Guid 
  where AF_Parentid=@AF_Parentid and AF_Status='A' 
  order by AF_ModDate desc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@AF_Parentid", AF_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public void addContent(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"insert into AssignmentForums (
AF_Guid,
AF_Cguid,
AF_Type,
AF_Parentid,
AF_Mguid,
AF_Content,
AF_CreateDate,
AF_CreateId,
AF_ModDate,
AF_ModId,
AF_Status 
) values (
@AF_Guid,
@AF_Cguid,
@AF_Type,
@AF_Parentid,
@AF_Mguid,
@AF_Content,
@AF_CreateDate,
@AF_CreateId,
@AF_ModDate,
@AF_ModId,
@AF_Status 
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@AF_Guid", AF_Guid);
        oCmd.Parameters.AddWithValue("@AF_Cguid", AF_Cguid);
        oCmd.Parameters.AddWithValue("@AF_Type", AF_Type);
        oCmd.Parameters.AddWithValue("@AF_Parentid", AF_Parentid);
        oCmd.Parameters.AddWithValue("@AF_Content", AF_Content);
        oCmd.Parameters.AddWithValue("@AF_Mguid", AF_Mguid);
        oCmd.Parameters.AddWithValue("@AF_CreateDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@AF_CreateId", AF_CreateId);
        oCmd.Parameters.AddWithValue("@AF_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@AF_ModId", AF_ModId);
        oCmd.Parameters.AddWithValue("@AF_Status", "A");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateContent(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update AssignmentForums set 
            AF_Content=@AF_Content, 
            AF_ModId=@AF_ModId,
            AF_ModDate=@AF_ModDate 
            where AF_Guid=@AF_Guid  
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@AF_Guid", AF_Guid);
        oCmd.Parameters.AddWithValue("@AF_Content", AF_Content);
        oCmd.Parameters.AddWithValue("@AF_ModId", AF_ModId);
        oCmd.Parameters.AddWithValue("@AF_ModDate", DateTime.Now);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void DeleteComment(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update AssignmentForums set
            AF_Status=@AF_Status,
            AF_ModId=@AF_ModId,
            AF_ModDate=@AF_ModDate
            where AF_Guid=@AF_Guid  
");
        if (AF_Type == "01")
            sb.Append(@"update AssignmentForums set
            AF_Status=@AF_Status,
            AF_ModId=@AF_ModId,
            AF_ModDate=@AF_ModDate
            where AF_Parentid=@AF_Parentid");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@AF_Guid", AF_Guid);
        oCmd.Parameters.AddWithValue("@AF_Parentid", AF_Guid);
        oCmd.Parameters.AddWithValue("@AF_ModId", AF_ModId);
        oCmd.Parameters.AddWithValue("@AF_Type", AF_Type);
        oCmd.Parameters.AddWithValue("@AF_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@AF_Status", "D");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}