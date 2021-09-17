using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// MemberPwdLog_DB 的摘要描述
/// </summary>
public class MemberPwdLog_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string MPL_ID = string.Empty;
    string MPL_MID = string.Empty;
    string MPL_ModPwd = string.Empty;
    string MPL_IP = string.Empty;
    DateTime MPL_CreateDate;
    string MPL_CreateId = string.Empty;
    DateTime MPL_ModDate;
    string MPL_ModId = string.Empty;
    string MPL_Status = string.Empty;
    #endregion
    #region Public
    public string _MPL_ID { set { MPL_ID = value; } }
    public string _MPL_MID { set { MPL_MID = value; } }
    public string _MPL_ModPwd { set { MPL_ModPwd = value; } }
    public string _MPL_IP { set { MPL_IP = value; } }
    public DateTime _MPL_CreateDate { set { MPL_CreateDate = value; } }
    public string _MPL_CreateId { set { MPL_CreateId = value; } }
    public DateTime _MPL_ModDate { set { MPL_ModDate = value; } }
    public string _MPL_ModId { set { MPL_ModId = value; } }
    public string _MPL_Status { set { MPL_Status = value; } }
    #endregion

    public void addLog()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        oCmd.CommandText = @"insert into MemberPwdLog (
MPL_MID,
MPL_ModPwd,
MPL_IP,
MPL_CreateId,
MPL_ModId,
MPL_Status
) values (
@MPL_MID,
@MPL_ModPwd,
@MPL_IP,
@MPL_CreateId,
@MPL_ModId,
@MPL_Status
) ";

        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);

        oCmd.Parameters.AddWithValue("@MPL_MID", MPL_MID);
        oCmd.Parameters.AddWithValue("@MPL_ModPwd", MPL_ModPwd);
        oCmd.Parameters.AddWithValue("@MPL_IP", MPL_IP);
        oCmd.Parameters.AddWithValue("@MPL_CreateId", MPL_CreateId);
        oCmd.Parameters.AddWithValue("@MPL_ModId", MPL_ModId);
        oCmd.Parameters.AddWithValue("@MPL_Status", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable CheckRepeatPw()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select top 3 * into #tmp from MemberPwdLog where MPL_MID=@MPL_MID and MPL_Status='A' order by MPL_CreateDate desc

select * from #tmp where MPL_ModPwd=@MPL_ModPwd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@MPL_MID", MPL_MID);
        oCmd.Parameters.AddWithValue("@MPL_ModPwd", MPL_ModPwd);
        oda.Fill(ds);
        return ds;
    }
}