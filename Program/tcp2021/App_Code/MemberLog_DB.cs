using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// MemberLog_DB 的摘要描述
/// </summary>
public class MemberLog_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string ML_ID = string.Empty;
    string ML_MID = string.Empty;
    string ML_Type = string.Empty;
    string ML_IP = string.Empty;
    DateTime ML_CreateDate;
    string ML_CreateId = string.Empty;
    DateTime ML_ModDate;
    string ML_ModId = string.Empty;
    string ML_Status = string.Empty;
    #endregion
    #region Public
    public string _ML_ID { set { ML_ID = value; } }
    public string _ML_MID { set { ML_MID = value; } }
    public string _ML_Type { set { ML_Type = value; } }
    public string _ML_IP { set { ML_IP = value; } }
    public DateTime _ML_CreateDate { set { ML_CreateDate = value; } }
    public string _ML_CreateId { set { ML_CreateId = value; } }
    public DateTime _ML_ModDate { set { ML_ModDate = value; } }
    public string _ML_ModId { set { ML_ModId = value; } }
    public string _ML_Status { set { ML_Status = value; } }
    #endregion

    public void addLog()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        oCmd.CommandText = @"insert into MemberLog (
ML_MID,
ML_Type,
ML_IP,
ML_CreateId,
ML_ModId,
ML_Status
) values (
@ML_MID,
@ML_Type,
@ML_IP,
@ML_CreateId,
@ML_ModId,
@ML_Status
) ";

        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);

        oCmd.Parameters.AddWithValue("@ML_MID", ML_MID);
        oCmd.Parameters.AddWithValue("@ML_Type", ML_Type);
        oCmd.Parameters.AddWithValue("@ML_IP", ML_IP);
        oCmd.Parameters.AddWithValue("@ML_CreateId", ML_CreateId);
        oCmd.Parameters.AddWithValue("@ML_ModId", ML_ModId);
        oCmd.Parameters.AddWithValue("@ML_Status", "A");


        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
}