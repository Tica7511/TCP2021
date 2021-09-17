using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// Assignment_DB 的摘要描述
/// </summary>
public class Assignment_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string A_ID = string.Empty;
    string A_Guid = string.Empty;
    string A_Name = string.Empty;
    string A_OpenDate = string.Empty;
    string A_CloseDate = string.Empty;
    string A_Sort = string.Empty;
    DateTime A_CreateDate;
    string A_CreateId = string.Empty;
    DateTime A_ModDate;
    string A_ModId = string.Empty;
    string A_Status = string.Empty;
    #endregion
    #region Public
    public string _A_ID { set { A_ID = value; } }
    public string _A_Guid { set { A_Guid = value; } }
    public string _A_Name { set { A_Name = value; } }
    public string _A_OpenDate { set { A_OpenDate = value; } }
    public string _A_CloseDate { set { A_CloseDate = value; } }
    public string _A_Sort { set { A_Sort = value; } }
    public DateTime _A_CreateDate { set { A_CreateDate = value; } }
    public string _A_CreateId { set { A_CreateId = value; } }
    public DateTime _A_ModDate { set { A_ModDate = value; } }
    public string _A_ModId { set { A_ModId = value; } }
    public string _A_Status { set { A_Status = value; } }
    #endregion

    public DataTable GetList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from Assignment where A_Status='A' 
order by convert(int, A_Sort) asc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oda.Fill(ds);
        return ds;
    }

    public DataTable GetData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from Assignment where A_Status='A' and  A_Guid=@A_Guid 
order by A_Sort asc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@A_Guid", A_Guid);
        oda.Fill(ds);
        return ds;
    }

    public void UpdateAsssignment(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
update Assignment set 
A_Name=@A_Name,
A_OpenDate=@A_OpenDate,
A_CloseDate=@A_CloseDate, 
A_ModId=@A_ModId,
A_ModDate=@A_ModDate 
where A_Guid=@A_Guid and A_Status='A' 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@A_Guid", A_Guid);
        oCmd.Parameters.AddWithValue("@A_Name", A_Name);
        oCmd.Parameters.AddWithValue("@A_OpenDate", A_OpenDate);
        oCmd.Parameters.AddWithValue("@A_CloseDate", A_CloseDate);
        oCmd.Parameters.AddWithValue("@A_ModId", A_ModId);
        oCmd.Parameters.AddWithValue("@A_ModDate", DateTime.Now);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}