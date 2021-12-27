using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// News_DB 的摘要描述
/// </summary>
public class News_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region Private
    string N_ID = string.Empty;
    string N_Guid = string.Empty;
    string N_Date = string.Empty;
    string N_Title = string.Empty;
    string N_Sort = string.Empty;
    string N_Content = string.Empty;
    string N_CreateId = string.Empty;
    string N_ModId = string.Empty;
    string N_Status = string.Empty;

    DateTime N_CreateDate;
    DateTime N_ModDate;
    #endregion
    #region Public
    public string _N_ID
    {
        set { N_ID = value; }
    }
    public string _N_Guid
    {
        set { N_Guid = value; }
    }
    public string _N_Date
    {
        set { N_Date = value; }
    }
    public string _N_Title
    {
        set { N_Title = value; }
    }
    public string _N_Sort
    {
        set { N_Sort = value; }
    }
    public string _N_Content
    {
        set { N_Content = value; }
    }
    public string _N_CreateId
    {
        set { N_CreateId = value; }
    }
    public string _N_ModId
    {
        set { N_ModId = value; }
    }
    public string _N_Status
    {
        set { N_Status = value; }
    }
    public DateTime _N_CreateDate
    {
        set { N_CreateDate = value; }
    }
    public DateTime _N_ModDate
    {
        set { N_ModDate = value; }
    }
    #endregion

    public DataSet GetList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT *
into #tmp from News ");

        //if (KeyWord != "")
        //{
        //	sb.Append(@"and (lower(
        //                              isnull(M_Name,'')+isnull(M_Email,'')+isnull(M_Account,'')
        //                              ) like '%" + KeyWord.ToLower() + "%')  ");
        //}

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by convert(int, N_Sort)) itemNo,* from #tmp
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

    public DataTable GetList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from News where N_Status='A' 
order by convert(int, N_Sort) asc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oda.Fill(ds);
        return ds;
    }

    public DataTable GetNewsDetail()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT *,
imglength=(select count(*) from FileTable where File_Parentid=N_Guid and File_Status='A')
from News where N_ID=@N_ID ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@N_ID", N_ID);
        oda.Fill(ds);
        return ds;
    }

    public DataSet GetFrontEndNews(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * 
  into #tmp from News
  where N_Status='A' ");

        sb.Append(@"
select count(*) as total from #tmp

select * from (
           select ROW_NUMBER() over (order by convert(int, N_Sort)) itemNo,* from #tmp
)#t where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oda.Fill(EncodeDS(ds));
        return ds;
    }

    /// <summary>
    /// 解stored XSS
    /// </summary>
    /// <param name="ds"></param>
    /// <returns></returns>
    public DataSet EncodeDS(DataSet ds)
    {
        DataSet _ds = new DataSet();
        _ds = ds;
        return _ds;
    }

    public DataTable GetFrontEndDetail()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * 
from News where N_ID=@N_ID and N_Status='A' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@N_ID", N_ID);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetNewsSort(string mode)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        if (mode == "new")
            sb.Append(@"
declare @sortCount int

SELECT @sortCount=COUNT(*) from News

if(@sortCount>0)
    begin
        SELECT MAX(CONVERT(int, N_Sort))+1 as N_Sort from News
    end
else
    begin
        SELECT 1 as N_Sort
    end
");
        else
            sb.Append(@"SELECT N_Sort from News order by convert(int, N_Sort) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oda.Fill(ds);
        return ds;
    }

    public void addNews(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"insert into News (
N_Guid,
N_Sort,
N_Date,
N_Title,
N_Content,
N_CreateId,
N_ModId,
N_Status
) values (
@N_Guid,
@N_Sort,
@N_Date,
@N_Title,
@N_Content,
@N_CreateId,
@N_ModId,
@N_Status
) ");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@N_Guid", N_Guid);
        oCmd.Parameters.AddWithValue("@N_Sort", N_Sort);
        oCmd.Parameters.AddWithValue("@N_Date", N_Date);
        oCmd.Parameters.AddWithValue("@N_Title", N_Title);
        oCmd.Parameters.AddWithValue("@N_Content", N_Content);
        oCmd.Parameters.AddWithValue("@N_CreateId", N_CreateId);
        oCmd.Parameters.AddWithValue("@N_ModId", N_ModId);
        oCmd.Parameters.AddWithValue("@N_Status", N_Status);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }

    public void UpdateNews(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
declare @orgSort nvarchar(3)  
declare @nowID nvarchar(50) 
select @orgSort=N_Sort from News where N_ID=@N_ID 
select @nowID=N_ID from News where N_Sort=@N_Sort 

if(@N_ID <> @nowID)
	begin
		update News
		set N_Sort=@orgSort
		where N_ID=@nowID

		update News
		set N_Sort=@N_Sort
		where N_ID=@N_ID
	end


update News set
N_Date=@N_Date,
N_Title=@N_Title,
N_Content=@N_Content,
N_ModDate=@N_ModDate,
N_ModId=@N_ModId,
N_Status=@N_Status 
where N_ID=@N_ID
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();
        oCmd.Parameters.AddWithValue("@N_ID", N_ID);
        oCmd.Parameters.AddWithValue("@N_Sort", N_Sort);
        oCmd.Parameters.AddWithValue("@N_Date", N_Date);
        oCmd.Parameters.AddWithValue("@N_Title", N_Title);
        oCmd.Parameters.AddWithValue("@N_Content", N_Content);
        oCmd.Parameters.AddWithValue("@N_ModDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@N_ModId", N_ModId);
        oCmd.Parameters.AddWithValue("@N_Status", N_Status);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}