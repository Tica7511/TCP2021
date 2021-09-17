using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// Questionnaires_DB 的摘要描述
/// </summary>
public class Questionnaires_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string Q_ID = string.Empty;
    string Q_Parentid = string.Empty;
    string Q_Number = string.Empty;
    string Q_Content = string.Empty;
    DateTime Q_CreateDate;
    string Q_CreateId = string.Empty;
    DateTime Q_ModDate;
    string Q_ModId = string.Empty;
    string Q_Status = string.Empty;
    #endregion
    #region Public
    public string _Q_ID { set { Q_ID = value; } }
    public string _Q_Parentid { set { Q_Parentid = value; } }
    public string _Q_Number { set { Q_Number = value; } }
    public string _Q_Content { set { Q_Content = value; } }
    DateTime _Q_CreateDate { set { Q_CreateDate = value; } }
    public string _Q_CreateId { set { Q_CreateId = value; } }
    DateTime _Q_ModDate { set { Q_ModDate = value; } }
    public string _Q_ModId { set { Q_ModId = value; } }
    public string _Q_Status { set { Q_Status = value; } }
    #endregion

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from Questionnaires 
where Q_Parentid=@Q_Parentid and Q_Status='A' 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@Q_Parentid", Q_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetCount()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @qCount int

select @qCount=count(*) from Questionnaires 
where Q_Parentid=@Q_Parentid and Q_Status='A' 

if(@qCount>0)
    begin
        set @qCount = 1
    end
else
    begin
        set @qCount = 0
    end

select @qCount as qCount
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@Q_Parentid", Q_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetNumList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select m.M_Name, q.* from Questionnaires q 
left join Member m on q.Q_Parentid = m.M_Guid 
where Q_Number=@Q_Number and Q_Status='A' 
order by m.M_Name asc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@Q_Number", Q_Number);
        oda.Fill(ds);
        return ds;
    }

    public void addQuestionnaires(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
declare @Qcount int 

select @Qcount = count(*) from Questionnaires Where Q_Number=@Q_Number and Q_Parentid=@Q_Parentid and Q_Status='A' 

if(@Qcount > 0)
    begin 
        update Questionnaires
        set Q_Content=@Q_Content, 
            Q_ModId=@Q_ModId, 
            Q_ModDate=@Q_ModDate 
        where Q_Number=@Q_Number and Q_Parentid=@Q_Parentid and Q_Status='A' 
    end
else
    begin
        insert into Questionnaires (
        Q_Parentid,
        Q_Number,
        Q_Content,
        Q_CreateId,
        Q_ModId,
        Q_Status 
        ) values (
        @Q_Parentid,
        @Q_Number,
        @Q_Content,
        @Q_CreateId,
        @Q_ModId,
        'A'  
        ) 
    end 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@Q_Parentid", Q_Parentid);
        oCmd.Parameters.AddWithValue("@Q_Number", Q_Number);
        oCmd.Parameters.AddWithValue("@Q_Content", Q_Content);
        oCmd.Parameters.AddWithValue("@Q_CreateId", Q_CreateId);
        oCmd.Parameters.AddWithValue("@Q_ModId", Q_ModId);
        oCmd.Parameters.AddWithValue("@Q_ModDate", DateTime.Now);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}