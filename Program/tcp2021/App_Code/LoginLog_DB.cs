using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// LoginLog_DB 的摘要描述
/// </summary>
public class LoginLog_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string L_ID = string.Empty;
    string L_LoginAccount = string.Empty;
    string L_Result = string.Empty;
    string L_IP = string.Empty;
    DateTime L_CreateDate;
    string L_CreateId = string.Empty;
    DateTime L_ModDate;
    string L_ModId = string.Empty;
    string L_Status = string.Empty;

    #endregion
    #region Public
    public string _L_ID { set { L_ID = value; } }
    public string _L_LoginAccount { set { L_LoginAccount = value; } }
    public string _L_Result { set { L_Result = value; } }
    public string _L_IP { set { L_IP = value; } }
    public DateTime _L_CreateDate { set { L_CreateDate = value; } }
    public string _L_CreateId { set { L_CreateId = value; } }
    public DateTime _L_ModDate { set { L_ModDate = value; } }
    public string _L_ModId { set { L_ModId = value; } }
    public string _L_Status { set { L_Status = value; } }
    #endregion

    public void addLog()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        oCmd.CommandText = @"insert into LoginLog (
L_LoginAccount,
L_Result,
L_IP,
L_CreateId,
L_ModId,
L_Status
) values (
@L_LoginAccount,
@L_Result,
@L_IP,
@L_CreateId,
@L_ModId,
@L_Status
) ";

        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);

        oCmd.Parameters.AddWithValue("@L_LoginAccount", L_LoginAccount);
        oCmd.Parameters.AddWithValue("@L_Result", L_Result);
        oCmd.Parameters.AddWithValue("@L_IP", L_IP);
        oCmd.Parameters.AddWithValue("@L_CreateId", L_CreateId);
        oCmd.Parameters.AddWithValue("@L_ModId", L_ModId);
        oCmd.Parameters.AddWithValue("@L_Status", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable CheckLoginStatus(string Account)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @checkTime int =15;--登入失敗要等幾分鐘
declare @continueTime int =15;--幾分鐘內連續登入失敗  @continueTime不能>@checkTime

declare @chkLastFail datetime;--最後一次登入失敗時間
declare @LCount int=0;--15分鐘內連續錯誤次數

select @chkLastFail = L_CreateDate
from LoginLog
where L_LoginAccount = @acc
and L_Result='Fail' --登入失敗

if DATEDIFF(MINUTE, @chkLastFail,getdate())  <= @checkTime
 begin
 select @LCount = count(*) 
  from LoginLog
  where L_LoginAccount = @acc
  and L_Result='Fail' --登入失敗
  and DATEDIFF(MINUTE, L_CreateDate,getdate())  <= @continueTime

  if @LCount>=3
   begin
    --15分鐘內累計登入失敗3次 回傳X
    select 'X' as reStatus
   end
  else
   begin
    --15分鐘內沒有累計登入失敗3次
    select 'Y' as reStatus
  end
 end
else
 begin
  select 'Y' as reStatus
 end ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@acc", Account);
        oda.Fill(ds);
        return ds;
    }
}