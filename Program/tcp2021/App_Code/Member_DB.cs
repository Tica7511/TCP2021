using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// Member_DB 的摘要描述
/// </summary>
public class Member_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region private
    string M_Guid = string.Empty;
    string M_Account = string.Empty;
    string M_Pwd = string.Empty;
    string M_Name = string.Empty;
    string M_Group = string.Empty;
    string M_BirthDay = string.Empty;
    string M_Email = string.Empty;
    string M_Introduction = string.Empty;
    string M_Competence = string.Empty;
    DateTime M_CreateDate;
    string M_CreateId = string.Empty;
    DateTime M_ModDate;
    string M_ModId = string.Empty;
    string M_Status = string.Empty;
    #endregion
    #region public
    public string _M_Guid { set { M_Guid = value; } }
    public string _M_Account { set { M_Account = value; } }
    public string _M_Pwd { set { M_Pwd = value; } }
    public string _M_Name { set { M_Name = value; } }
    public string _M_Group { set { M_Group = value; } }
    public string _M_BirthDay { set { M_BirthDay = value; } }
    public string _M_Email { set { M_Email = value; } }
    public string _M_Introduction { set { M_Introduction = value; } }
    public string _M_Competence { set { M_Competence = value; } }
    public DateTime _M_CreateDate { set { M_CreateDate = value; } }
    public string _M_CreateId { set { M_CreateId = value; } }
    public DateTime _M_ModDate { set { M_ModDate = value; } }
    public string _M_ModId { set { M_ModId = value; } }
    public string _M_Status { set { M_Status = value; } }
    #endregion

    public DataTable CheckMember()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from Member where M_Status='A' ");
        if (M_Account != "")
            sb.Append(@"and M_Account=@M_Account ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@M_Account", M_Account);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetListManage()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT m.*, g.G_Name 
from Member m 
left join Groups g
on m.M_Group=g.G_Guid 
where M_Status='A' and M_Competence<>'01' 
order by  g.G_Name, m.M_Name ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oda.Fill(ds);
        return ds;
    }

    public DataTable GetListLeader()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT m.*, g.G_Name 
from Member m 
left join Groups g
on m.M_Group=g.G_Guid 
where M_Group=@M_Group and M_Status='A' 
order by m.M_Name ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@M_Group", M_Group);
        oda.Fill(ds);
        return ds;
    }

    public DataSet GetList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT *
into #tmp from Member ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by M_CreateDate asc ) itemNo,* from #tmp
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

    public DataSet GetList2(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT m.*, g.G_Name 
into #tmp from Member m 
left join Groups g
on m.M_Group=g.G_Guid 
where M_Status='A' and M_Competence<>'01' ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp 

select * from (
           select ROW_NUMBER() over (order by G_Name, M_Name ) itemNo,* from #tmp
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

    public DataSet GetList3(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT m.*, g.G_Name 
into #tmp from Member m 
left join Groups g
on m.M_Group=g.G_Guid ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp 

select * from (
           select ROW_NUMBER() over (order by G_Name, M_Name ) itemNo,* from #tmp
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

    public DataSet GetListLeader2(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT m.*, g.G_Name 
into #tmp from Member m 
left join Groups g
on m.M_Group=g.G_Guid 
where M_Group=@M_Group and M_Status='A' 
order by m.M_Name ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp 

select * from (
           select ROW_NUMBER() over (order by G_Name, M_Name ) itemNo,* from #tmp
)#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@M_Group", M_Group);
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

        sb.Append(@"SELECT * from Member where M_Guid=@M_Guid");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@M_Guid", M_Guid);
        oda.Fill(ds);
        return ds;
    }

    public void addMember(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"insert into Member (
M_Guid,
M_Account,
M_Pwd,
M_Name,
M_BirthDay,
M_Email,
M_Group,
M_Competence,
M_CreateId,
M_ModId,
M_Status 
) values (
@M_Guid,
@M_Account,
@M_Pwd,
@M_Name,
@M_BirthDay,
@M_Email,
@M_Group,
@M_Competence,
@M_CreateId,
@M_ModId,
@M_Status 
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@M_Guid", M_Guid);
        oCmd.Parameters.AddWithValue("@M_Account", M_Account);
        oCmd.Parameters.AddWithValue("@M_Pwd", M_Pwd);
        oCmd.Parameters.AddWithValue("@M_Name", M_Name);
        oCmd.Parameters.AddWithValue("@M_BirthDay", M_BirthDay);
        oCmd.Parameters.AddWithValue("@M_Email", M_Email);
        oCmd.Parameters.AddWithValue("@M_Group", M_Group);
        oCmd.Parameters.AddWithValue("@M_Introduction", M_Introduction);
        oCmd.Parameters.AddWithValue("@M_Competence", M_Competence);
        oCmd.Parameters.AddWithValue("@M_CreateId", M_CreateId);
        oCmd.Parameters.AddWithValue("@M_ModId", M_ModId);
        oCmd.Parameters.AddWithValue("@M_Status", "A");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateMember(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update Member set
M_Account=@M_Account,
M_Pwd=@M_Pwd,
M_Name=@M_Name,
M_BirthDay=@M_BirthDay,
M_Email=@M_Email,
M_Group=@M_Group,
M_Competence=@M_Competence,
M_Status=@M_Status,
M_ModDate=@M_ModDate,
M_ModId=@M_ModId 
where M_Guid=@M_Guid 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@M_Guid", M_Guid);
        oCmd.Parameters.AddWithValue("@M_Account", M_Account);
        oCmd.Parameters.AddWithValue("@M_Pwd", M_Pwd);
        oCmd.Parameters.AddWithValue("@M_Name", M_Name);
        oCmd.Parameters.AddWithValue("@M_BirthDay", M_BirthDay);
        oCmd.Parameters.AddWithValue("@M_Email", M_Email);
        oCmd.Parameters.AddWithValue("@M_Group", M_Group);
        //oCmd.Parameters.AddWithValue("@M_Introduction", M_Introduction);
        oCmd.Parameters.AddWithValue("@M_Competence", M_Competence);
        oCmd.Parameters.AddWithValue("@M_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@M_ModId", M_ModId);
        oCmd.Parameters.AddWithValue("@M_Status", M_Status);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateFrontMember(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update Member set 
M_Introduction=@M_Introduction,
M_ModDate=@M_ModDate,
M_ModId=@M_ModId 
where M_Guid=@M_Guid 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@M_Guid", M_Guid);
        oCmd.Parameters.AddWithValue("@M_Introduction", M_Introduction);
        oCmd.Parameters.AddWithValue("@M_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@M_ModId", M_ModId);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}