using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// MemberClass_DB 的摘要描述
/// </summary>
public class MemberClass_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string MC_ID = string.Empty;
    string MC_Parentid = string.Empty;
    string MC_Mguid = string.Empty;
    string MC_IsFinish = string.Empty;
    string MC_CreateId = string.Empty;
    DateTime MC_CreateDate;
    string MC_ModId = string.Empty;
    DateTime MC_ModDate;
    string MC_Status = string.Empty;
    #endregion
    #region Public
    public string _MC_ID { set { MC_ID = value; } }
    public string _MC_Parentid { set { MC_Parentid = value; } }
    public string _MC_Mguid { set { MC_Mguid = value; } }
    public string _MC_IsFinish { set { MC_IsFinish = value; } }
    public string _MC_CreateId { set { MC_CreateId = value; } }
    DateTime _MC_CreateDate { set { MC_CreateDate = value; } }
    public string _MC_ModId { set { MC_ModId = value; } }
    DateTime _MC_ModDate { set { MC_ModDate = value; } }
    public string _MC_Status { set { MC_Status = value; } }
    #endregion

    public DataTable GetList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from MemberClass 
where MC_Parentid=@MC_Parentid and MC_Mguid=@MC_Mguid and MC_Status = 'A' 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@MC_Mguid", MC_Mguid);
        oCmd.Parameters.AddWithValue("@MC_Parentid", MC_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetCount()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @courseCount int
declare @membercourseCount int

select @courseCount=count(*) from Class where C_Status='A'
select @membercourseCount=count(*) from MemberClass mc
left join Class c on mc.MC_Parentid=c.C_Guid 
where MC_Mguid=@MC_Mguid and MC_Status='A' and C_Status='A' and MC_IsFinish='Y'

select @courseCount as cCount, @membercourseCount as mcCount
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@MC_Mguid", MC_Mguid);
        oda.Fill(ds);
        return ds;
    }

    public DataSet GetList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT m.M_Name, mc.* 
into #tmp from MemberClass mc  
left join Member m on M_Guid = MC_Mguid 
where MC_Parentid=@MC_Parentid and MC_Status='A' ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by MC_ModDate desc) itemNo,* from #tmp
)#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oCmd.Parameters.AddWithValue("@MC_Parentid", MC_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @countnb int 
select @countnb = count(*) from MemberClass where MC_Parentid=@MC_Parentid and MC_Mguid=@MC_Mguid and MC_Status='A' 

if(@countnb < 1)
    begin
        insert into MemberClass(
            MC_Parentid, 
            MC_Mguid, 
            MC_IsFinish, 
            MC_CreateId, 
            MC_ModId, 
            MC_Status
            ) values (
            @MC_Parentid,
            @MC_Mguid,
            'N',
            @MC_CreateId, 
            @MC_ModId,
            'A' )            
    end

select mc.MC_IsFinish, c.* 
from Class c 
left join MemberClass mc on c.C_Guid = mc.MC_Parentid 
where mc.MC_Mguid=@MC_Mguid and c.C_Guid=@MC_Parentid and mc.MC_Status='A' and c.C_Status='A' 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@MC_Mguid", MC_Mguid);
        oCmd.Parameters.AddWithValue("@MC_Parentid", MC_Parentid);
        oCmd.Parameters.AddWithValue("@MC_CreateId", MC_CreateId);
        oCmd.Parameters.AddWithValue("@MC_ModId", MC_ModId);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetData2()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @countnb int 
select @countnb = count(*) from MemberClass where MC_Parentid=@MC_Parentid and MC_Mguid=@MC_Mguid and MC_Status='A' 

if(@countnb < 1)
    begin
        insert into MemberClass(
            MC_Parentid, 
            MC_Mguid, 
            MC_IsFinish, 
            MC_CreateId, 
            MC_ModId, 
            MC_Status
            ) values (
            @MC_Parentid,
            @MC_Mguid,
            'N',
            @MC_CreateId, 
            @MC_ModId,
            'A' )            
    end

select mc.MC_IsFinish, c.* 
from OtherClass c 
left join MemberClass mc on c.OC_Guid = mc.MC_Parentid 
where mc.MC_Mguid=@MC_Mguid and c.OC_Guid=@MC_Parentid and mc.MC_Status='A' and c.OC_Status='A' 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@MC_Mguid", MC_Mguid);
        oCmd.Parameters.AddWithValue("@MC_Parentid", MC_Parentid);
        oCmd.Parameters.AddWithValue("@MC_CreateId", MC_CreateId);
        oCmd.Parameters.AddWithValue("@MC_ModId", MC_ModId);
        oda.Fill(ds);
        return ds;
    }

    public void updateMemberClass(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@" update MemberClass 
set MC_IsFinish=@MC_IsFinish  
where MC_Parentid=@MC_Parentid and MC_Mguid=@MC_Mguid and MC_Status='A' 
 ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@MC_Parentid", MC_Parentid);
        oCmd.Parameters.AddWithValue("@MC_IsFinish", MC_IsFinish);
        oCmd.Parameters.AddWithValue("@MC_Mguid", MC_Mguid);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}