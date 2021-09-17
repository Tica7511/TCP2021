using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// Forums_DB 的摘要描述
/// </summary>
public class Forums_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string FM_ID = string.Empty;
    string FM_Guid = string.Empty;
    string FM_Type = string.Empty;
    string FM_Parentid = string.Empty;
    string FM_Mguid = string.Empty;
    string FM_Content = string.Empty;
    DateTime FM_CreateDate;
    string FM_CreateId = string.Empty;
    DateTime FM_ModDate;
    string FM_ModId = string.Empty;
    string FM_Status = string.Empty;
    #endregion
    #region Public

    public string _FM_ID { set { FM_ID = value; } }
    public string _FM_Guid { set { FM_Guid = value; } }
    public string _FM_Type { set { FM_Type = value; } }
    public string _FM_Parentid { set { FM_Parentid = value; } }
    public string _FM_Mguid { set { FM_Mguid = value; } }
    public string _FM_Content { set { FM_Content = value; } }
    public DateTime _FM_CreateDate { set { FM_CreateDate = value; } }
    public string _FM_CreateId { set { FM_CreateId = value; } }
    public DateTime _FM_ModDate { set { FM_ModDate = value; } }
    public string _FM_ModId { set { FM_ModId = value; } }
    public string _FM_Status { set { FM_Status = value; } }
    #endregion

    public DataSet GetList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT convert(nvarchar(20), FM_ModDate, 111) as contentDate, 
  convert(nvarchar(20), FM_ModDate, 108) as contentTime,* 
into #tmp from Forums  
LEFT JOIN Member ON FM_Mguid=M_Guid 
where FM_Status='A' ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by FM_ModDate desc) itemNo,* from #tmp
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

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from Forums 
where FM_Guid=@FM_Guid and FM_Status=@FM_Status
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@FM_Guid", FM_Guid);
        oCmd.Parameters.AddWithValue("@FM_Status", "A");
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetComment()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select convert(nvarchar(20), FM_ModDate, 111) as contentDate, 
  convert(nvarchar(20), FM_ModDate, 108) as contentTime, * FROM Forums
  left join Member on FM_Mguid=M_Guid 
  where FM_Type=@FM_Type and FM_Status='A' 
  order by FM_CreateDate desc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@FM_Type", FM_Type);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetReply()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select convert(nvarchar(20), FM_ModDate, 111) as contentDate, 
  convert(nvarchar(20), FM_ModDate, 108) as contentTime, * FROM Forums 
  left join Member on FM_Mguid=M_Guid 
  where FM_Parentid=@FM_Parentid and FM_Status='A' 
  order by FM_CreateDate desc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@FM_Parentid", FM_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public void addContent(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"insert into Forums (
FM_Guid,
FM_Type,
FM_Parentid,
FM_Mguid,
FM_Content,
FM_CreateDate,
FM_CreateId,
FM_ModDate,
FM_ModId,
FM_Status 
) values (
@FM_Guid,
@FM_Type,
@FM_Parentid,
@FM_Mguid,
@FM_Content,
@FM_CreateDate,
@FM_CreateId,
@FM_ModDate,
@FM_ModId,
@FM_Status 
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@FM_Guid", FM_Guid);
        oCmd.Parameters.AddWithValue("@FM_Type", FM_Type);
        oCmd.Parameters.AddWithValue("@FM_Parentid", FM_Parentid);
        oCmd.Parameters.AddWithValue("@FM_Content", FM_Content);
        oCmd.Parameters.AddWithValue("@FM_Mguid", FM_Mguid);
        oCmd.Parameters.AddWithValue("@FM_CreateDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@FM_CreateId", FM_CreateId);
        oCmd.Parameters.AddWithValue("@FM_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@FM_ModId", FM_ModId);
        oCmd.Parameters.AddWithValue("@FM_Status", "A");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateContent(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update Forums set 
            FM_Content=@FM_Content, 
            FM_ModId=@FM_ModId,
            FM_ModDate=@FM_ModDate 
            where FM_Guid=@FM_Guid  
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@FM_Guid", FM_Guid);
        oCmd.Parameters.AddWithValue("@FM_Content", FM_Content);
        oCmd.Parameters.AddWithValue("@FM_ModId", FM_ModId);
        oCmd.Parameters.AddWithValue("@FM_ModDate", DateTime.Now);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void DeleteComment(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update Forums set
            FM_Status=@FM_Status,
            FM_ModId=@FM_ModId,
            FM_ModDate=@FM_ModDate
            where FM_Guid=@FM_Guid  
");
        if (FM_Type == "01")
            sb.Append(@"update Forums set
            FM_Status=@FM_Status,
            FM_ModId=@FM_ModId,
            FM_ModDate=@FM_ModDate
            where FM_Parentid=@FM_Parentid");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@FM_Guid", FM_Guid);
        oCmd.Parameters.AddWithValue("@FM_Parentid", FM_Guid);
        oCmd.Parameters.AddWithValue("@FM_ModId", FM_ModId);
        oCmd.Parameters.AddWithValue("@FM_Type", FM_Type);
        oCmd.Parameters.AddWithValue("@FM_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@FM_Status", "D");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}