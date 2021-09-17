using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

/// <summary>
/// MemberAssignment_DB 的摘要描述
/// </summary>
public class MemberAssignment_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord { set { KeyWord = value; } }
    #region Private
    string MA_ID = string.Empty;
    string MA_Parentid = string.Empty;
    string MA_Mguid = string.Empty;
    string MA_Number = string.Empty;
    string MA_Applicability = string.Empty;
    string MA_IsShare = string.Empty;
    string MA_RelevantStandards = string.Empty;
    string MA_Justification = string.Empty;
    string MA_CreateId = string.Empty;
    DateTime MA_CreateDate;
    string MA_ModId = string.Empty;
    DateTime MA_ModDate;
    string MA_Status = string.Empty;
    #endregion
    #region Public
    public string _MA_ID { set { MA_ID = value; } }
    public string _MA_Parentid { set { MA_Parentid = value; } }
    public string _MA_Mguid { set { MA_Mguid = value; } }
    public string _MA_Number { set { MA_Number = value; } }
    public string _MA_Applicability { set { MA_Applicability = value; } }
    public string _MA_IsShare { set { MA_IsShare = value; } }
    public string _MA_RelevantStandards { set { MA_RelevantStandards = value; } }
    public string _MA_Justification { set { MA_Justification = value; } }
    public string _MA_CreateId { set { MA_CreateId = value; } }
    public DateTime _MA_CreateDate { set { MA_CreateDate = value; } }
    public string _MA_ModId { set { MA_ModId = value; } }
    public DateTime _MA_ModDate { set { MA_ModDate = value; } }
    public string _MA_Status { set { MA_Status = value; } }
    #endregion

    public DataTable GetIsFinish()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @AcountNum int
declare @RcountNum int

select @AcountNum=count(*) from MemberAssignment 
where MA_Applicability='' and MA_Parentid=@MA_Parentid and MA_Mguid=@MA_Mguid and MA_Status='A'

select @RcountNum=count(*) from MemberAssignment 
where MA_Applicability='Y' and MA_RelevantStandards='' and MA_Parentid=@MA_Parentid and MA_Mguid=@MA_Mguid and MA_Status='A'

if(@AcountNum>0 or @RcountNum>0)
    begin
        select 'N' as MA_IsFinish
    end
else
    begin
        select 'Y' as MA_IsFinish
    end 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@MA_Parentid", MA_Parentid);
        oCmd.Parameters.AddWithValue("@MA_Mguid", MA_Mguid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetNumList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select m.M_Name, ma.* from MemberAssignment ma 
left join Member m on ma.MA_Mguid = m.M_Guid 
where MA_Number=@MA_Number and MA_Status='A' 
and MA_Parentid=@MA_Parentid 
order by m.M_Name asc 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@MA_Number", MA_Number);
        oCmd.Parameters.AddWithValue("@MA_Parentid", MA_Parentid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetCount()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @aCount int
declare @ma1Count int
declare @ma2Count int
declare @ma1ACount int
declare @ma1RCount int
declare @ma2ACount int
declare @ma2RCount int
declare @a1Giud nvarchar(50)
declare @a2Giud nvarchar(50)

select @aCount=count(*) from Assignment where A_Status='A'
select @a1Giud=A_Guid from Assignment where A_Sort='1' and A_Status='A'
select @a2Giud=A_Guid from Assignment where A_Sort='2' and A_Status='A'
select @ma1Count=COUNT(*) from MemberAssignment where MA_Parentid=@a1Giud and MA_Mguid=@MA_Mguid and MA_Status='A'
select @ma2Count=COUNT(*) from MemberAssignment where MA_Parentid=@a2Giud and MA_Mguid=@MA_Mguid and MA_Status='A'
select @ma1ACount=COUNT(*) from MemberAssignment where MA_Parentid=@a1Giud and MA_Mguid=@MA_Mguid and MA_Applicability='' and MA_Status='A'
select @ma1RCount=COUNT(*) from MemberAssignment where MA_Parentid=@a1Giud and MA_Mguid=@MA_Mguid and MA_Applicability='Y' and MA_RelevantStandards='' and MA_Status='A'
select @ma2ACount=COUNT(*) from MemberAssignment where MA_Parentid=@a2Giud and MA_Mguid=@MA_Mguid and MA_Applicability='' and MA_Status='A'
select @ma2RCount=COUNT(*) from MemberAssignment where MA_Parentid=@a2Giud and MA_Mguid=@MA_Mguid and MA_Applicability='Y' and MA_RelevantStandards='' and MA_Status='A'

if(@ma1Count>0)
	begin
		if(@ma1ACount>0 or @ma1RCount>0)
		    begin
				set @ma1Count = 0
			end
		else
			begin
				set @ma1Count = 1
			end
	end
else
	begin
		set @ma1Count = 0
	end

if(@ma2Count>0)
	begin
		if(@ma2ACount>0 or @ma2RCount>0)
		    begin
				set @ma2Count = 0
			end
		else
			begin
				set @ma2Count = 1
			end
	end
else
	begin
		set @ma2Count = 0
	end

select @ma1Count+@ma2Count as maCount, @aCount as aCount
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        
        oCmd.Parameters.AddWithValue("@MA_Mguid", MA_Mguid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetMemberData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select * from  MemberAssignment 
where  MA_Parentid=@MA_Parentid and MA_Mguid=@MA_Mguid and MA_Status='A' 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        
        oCmd.Parameters.AddWithValue("@MA_Parentid", MA_Parentid);
        oCmd.Parameters.AddWithValue("@MA_Mguid", MA_Mguid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable GetAssignmentData()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.AppSettings["ConnectionString"]);
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
select m.M_Name, ma.* from  MemberAssignment ma
left join Member m on ma.MA_Mguid = m.M_Guid 
where MA_Number=@MA_Number and MA_Parentid=@MA_Parentid and MA_Status='A' and MA_IsShare='Y' 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        
        oCmd.Parameters.AddWithValue("@MA_Parentid", MA_Parentid);
        oCmd.Parameters.AddWithValue("@MA_Number", MA_Number);
        oda.Fill(ds);
        return ds;
    }

    public void addAssignment(SqlConnection oConn, SqlTransaction oTran)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append(@"
declare @Acount int 

select @Acount = count(*) from MemberAssignment Where MA_Number=@MA_Number and MA_Parentid=@MA_Parentid and MA_Mguid=@MA_Mguid and MA_Status='A' 

if(@Acount > 0)
    begin 
        update MemberAssignment
        set MA_Applicability=@MA_Applicability, 
            MA_IsShare=@MA_IsShare, 
            MA_RelevantStandards=@MA_RelevantStandards, 
            MA_Justification=@MA_Justification, 
            MA_ModId=@MA_ModId, 
            MA_ModDate=@MA_ModDate 
        where MA_Number=@MA_Number and MA_Parentid=@MA_Parentid and MA_Mguid=@MA_Mguid and MA_Status='A' 
    end
else
    begin
        insert into MemberAssignment (
        MA_Parentid,
        MA_Mguid,
        MA_Number,
        MA_Applicability,
        MA_IsShare,
        MA_RelevantStandards,
        MA_Justification,
        MA_CreateId,
        MA_ModId,
        MA_Status 
        ) values (
        @MA_Parentid,
        @MA_Mguid,
        @MA_Number,
        @MA_Applicability,
        @MA_IsShare,
        @MA_RelevantStandards,
        @MA_Justification,
        @MA_CreateId,
        @MA_ModId,
        'A'  
        ) 
    end 
");
        SqlCommand oCmd = oConn.CreateCommand();
        oCmd.CommandText = sb.ToString();

        oCmd.Parameters.AddWithValue("@MA_Parentid", MA_Parentid);
        oCmd.Parameters.AddWithValue("@MA_Mguid", MA_Mguid);
        oCmd.Parameters.AddWithValue("@MA_Number", MA_Number);
        oCmd.Parameters.AddWithValue("@MA_Applicability", MA_Applicability);
        oCmd.Parameters.AddWithValue("@MA_IsShare", MA_IsShare);
        oCmd.Parameters.AddWithValue("@MA_RelevantStandards", MA_RelevantStandards);
        oCmd.Parameters.AddWithValue("@MA_Justification", MA_Justification);
        oCmd.Parameters.AddWithValue("@MA_CreateId", MA_CreateId);
        oCmd.Parameters.AddWithValue("@MA_ModId", MA_ModId);
        oCmd.Parameters.AddWithValue("@MA_ModDate", DateTime.Now);

        oCmd.Transaction = oTran;
        oCmd.ExecuteNonQuery();
    }
}