using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// File_DB 的摘要描述
/// </summary>
public class File_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string File_ID = string.Empty;
    string File_Parentid = string.Empty;
    string File_Type = string.Empty;
    string File_Orgname = string.Empty;
    string File_Encryname = string.Empty;
    string File_Exten = string.Empty;
    string File_Size = string.Empty;
    DateTime File_CreateDate;
    string File_CreateId = string.Empty;
    DateTime File_ModDate;
    string File_ModId = string.Empty;
    string File_Status = string.Empty;
    #endregion
    #region Public
    public string _File_ID { set { File_ID = value; } }
    public string _File_Parentid { set { File_Parentid = value; } }
    public string _File_Type { set { File_Type = value; } }
    public string _File_Orgname { set { File_Orgname = value; } }
    public string _File_Encryname { set { File_Encryname = value; } }
    public string _File_Exten { set { File_Exten = value; } }
    public string _File_Size { set { File_Size = value; } }
    public DateTime _File_CreateDate { set { File_CreateDate = value; } }
    public string _File_CreateId { set { File_CreateId = value; } }
    public DateTime _File_ModDate { set { File_ModDate = value; } }
    public string _File_ModId { set { File_ModId = value; } }
    public string _File_Status { set { File_Status = value; } }
    #endregion

    public DataSet GetList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT convert(nvarchar(20), File_CreateDate, 111) as contentDate, 
  convert(nvarchar(20), File_CreateDate, 108) as contentTime,* 
into #tmp from FileTable  
where File_Parentid=@File_Parentid and File_Status='A' ");

        if (File_Type != "")
            sb.Append(@"and File_Type=@File_Type ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by File_CreateDate desc) itemNo,* from #tmp
)#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oCmd.Parameters.AddWithValue("@File_Parentid", File_Parentid);
        oCmd.Parameters.AddWithValue("@File_Type", File_Type);
        oda.Fill(ds);
        return ds;
    }

    public void InsertFile()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        oCmd.CommandText = @"insert into FileTable (
File_Parentid,
File_Type,
File_Orgname,
File_Encryname, 
File_Exten, 
File_Size,
File_CreateId,
File_ModId,
File_Status
) values (
@File_Parentid,
@File_Type,
@File_Orgname,
@File_Encryname, 
@File_Exten, 
@File_Size,
@File_CreateId,
@File_ModId,
@File_Status
) ";

        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@File_Parentid", File_Parentid);
        oCmd.Parameters.AddWithValue("@File_Type", File_Type);
        oCmd.Parameters.AddWithValue("@File_Orgname", File_Orgname);
        oCmd.Parameters.AddWithValue("@File_Encryname", File_Encryname);
        oCmd.Parameters.AddWithValue("@File_Exten", File_Exten);
        oCmd.Parameters.AddWithValue("@File_Size", File_Size);
        oCmd.Parameters.AddWithValue("@File_CreateId", File_CreateId);
        oCmd.Parameters.AddWithValue("@File_ModId", File_ModId);
        oCmd.Parameters.AddWithValue("@File_Status", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable GetFileDetail()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from FileTable where File_Parentid=@File_Parentid and File_Status='A' ");

        if (File_Type != "")
            sb.Append(@"and File_Type=@File_Type ");
        if (File_Encryname !="")
            sb.Append(@"and File_Encryname=@File_Encryname ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@File_Type", File_Type);
        oCmd.Parameters.AddWithValue("@File_Parentid", File_Parentid);
        oCmd.Parameters.AddWithValue("@File_Encryname", File_Encryname);
        oda.Fill(ds);
        return ds;
    }

    public void DeleteFile()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        oCmd.CommandText = @"update FileTable set
File_ModDate=@File_ModDate,
File_ModId=@File_ModId,
File_Status='D'
where File_Parentid=@File_Parentid and File_Encryname=@File_Encryname and File_Type=@File_Type ";

        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@File_Parentid", File_Parentid);
        oCmd.Parameters.AddWithValue("@File_Encryname", File_Encryname);
        oCmd.Parameters.AddWithValue("@File_Type", File_Type);
        oCmd.Parameters.AddWithValue("@File_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@File_ModId", File_ModId);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }


    public void DeleteFile_Trans(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"update FileTable set
File_ModDate=@File_ModDate,
File_ModId=@File_ModId,
File_Status='D'
where File_Parentid=@File_Parentid ");

        if (File_Type != "")
            sb.Append(@"and File_Type=@File_Type");

        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@File_Type", File_Type);
        oCmd.Parameters.AddWithValue("@File_Parentid", File_Parentid);
        oCmd.Parameters.AddWithValue("@File_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@File_ModId", File_ModId);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateFile()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        oCmd.CommandText = @"update FileTable set 
File_Type=@File_Type,
File_Orgname=@File_Orgname,
File_Encryname=@File_Encryname, 
File_Exten=	@File_Exten, 
File_Size=@File_Size,
File_ModDate=@File_ModDate,
File_ModId=@File_ModId,
File_Status=@File_Status
where File_Parentid=@File_Parentid ";

        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@File_Parentid", File_Parentid);
        oCmd.Parameters.AddWithValue("@File_Type", File_Type);
        oCmd.Parameters.AddWithValue("@File_Orgname", File_Orgname);
        oCmd.Parameters.AddWithValue("@File_Encryname", File_Encryname);
        oCmd.Parameters.AddWithValue("@File_Exten", File_Exten);
        oCmd.Parameters.AddWithValue("@File_Size", File_Size);
        oCmd.Parameters.AddWithValue("@File_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@File_ModId", File_ModId);
        oCmd.Parameters.AddWithValue("@File_Status", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void UpdateFile_Trans(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
declare @fCount int

select @fCount=count(*) from FileTable where File_Parentid=@File_Parentid and File_Status='A' 

if(@fCount>0)
    begin
        update FileTable set
        File_Orgname=@File_Orgname,
        File_Encryname=@File_Encryname,
        File_Exten=@File_Exten,
        File_Size=@File_Size,
        File_ModId=@File_ModId,
        File_ModDate=@File_ModDate
        where File_Parentid=@File_Parentid and File_Type=@File_Type and File_Status=@File_Status 
    end
else
    begin
        insert into FileTable (
        File_Parentid,
        File_Type,
        File_Orgname,
        File_Encryname, 
        File_Exten, 
        File_Size,
        File_CreateId,
        File_ModId,
        File_Status
        ) values (
        @File_Parentid,
        @File_Type,
        @File_Orgname,
        @File_Encryname, 
        @File_Exten, 
        @File_Size,
        @File_CreateId,
        @File_ModId,
        @File_Status) 
    end 
 ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@File_Parentid", File_Parentid);
        oCmd.Parameters.AddWithValue("@File_Type", File_Type);
        oCmd.Parameters.AddWithValue("@File_Orgname", File_Orgname);
        oCmd.Parameters.AddWithValue("@File_Encryname", File_Encryname);
        oCmd.Parameters.AddWithValue("@File_Exten", File_Exten);
        oCmd.Parameters.AddWithValue("@File_Size", File_Size);
        oCmd.Parameters.AddWithValue("@File_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@File_CreateId", File_CreateId);
        oCmd.Parameters.AddWithValue("@File_ModId", File_ModId);
        oCmd.Parameters.AddWithValue("@File_Status", "A");

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}