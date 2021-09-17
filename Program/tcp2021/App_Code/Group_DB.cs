using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// Group_DB 的摘要描述
/// </summary>
public class Group_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string G_ID = string.Empty;
    string G_Guid = string.Empty;
    string G_Name = string.Empty;
    string G_Item = string.Empty;
    DateTime G_CreateDate;
    string G_CreateId = string.Empty;
    DateTime G_ModDate;
    string G_ModId = string.Empty;
    string G_Status = string.Empty;
    #endregion
    #region Public
    public string _G_ID { set { G_ID = value; } }
    public string _G_Guid { set { G_Guid = value; } }
    public string _G_Name { set { G_Name = value; } }
    public string _G_Item { set { G_Item = value; } }
    public DateTime _G_CreateDate { set { G_CreateDate = value; } }
    public string _G_CreateId { set { G_CreateId = value; } }
    public DateTime _G_ModDate { set { G_ModDate = value; } }
    public string _G_ModId { set { G_ModId = value; } }
    public string _G_Status { set { G_Status = value; } }
    #endregion

    public DataTable GetList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from Groups where G_Status='A' 
order by G_Name asc 
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
into #tmp from Groups ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by G_Name) itemNo,* from #tmp
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

    public void InsertGroup(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
insert into Groups(
G_Guid,
G_Name,
G_CreateId,
G_ModId,
G_Status 
) values( 
@G_Guid,
@G_Name,
@G_CreateId,
@G_ModId,
@G_Status 
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@G_Name", G_Name);
        oCmd.Parameters.AddWithValue("@G_CreateId", G_CreateId);
        oCmd.Parameters.AddWithValue("@G_ModId", G_ModId);
        oCmd.Parameters.AddWithValue("@G_Status", G_Status);
        oCmd.Parameters.AddWithValue("@G_Guid", G_Guid);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateGroup(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
            update Groups set 
            G_Name=@G_Name, 
            G_ModId=@G_ModId,
            G_ModDate=@G_ModDate,
            G_Status=@G_Status 
            where G_Guid=@G_Guid  

            update Member set
            M_Status=@G_Status 
            where M_Group=@G_Guid 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@G_Name", G_Name);
        oCmd.Parameters.AddWithValue("@G_ModId", G_ModId);
        oCmd.Parameters.AddWithValue("@G_Status", G_Status);
        oCmd.Parameters.AddWithValue("@G_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@G_Guid", G_Guid);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public DataTable CheckName()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from Groups where G_Name=@G_Name ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@G_Name", G_Name);
        oda.Fill(ds);
        return ds;
    }
}