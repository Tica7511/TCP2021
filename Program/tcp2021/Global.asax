<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // 在應用程式啟動時執行的程式碼

    }

    void Application_End(object sender, EventArgs e)
    {
        //  在應用程式關閉時執行的程式碼

    }

    void Application_Error(object sender, EventArgs e)
    {
        // 在發生未處理的錯誤時執行的程式碼
        string Message = "";
		Exception ex = Server.GetLastError();
		Message = "發生錯誤的網頁:{0}錯誤訊息:{1}堆疊內容:{2}";
		Message = String.Format(Message, Request.Path + Environment.NewLine, ex.GetBaseException().Message + Environment.NewLine, Environment.NewLine + ex.StackTrace);

		//寫入事件撿視器,方法一
		//System.Diagnostics.EventLog.WriteEntry("WebAppError", Message, System.Diagnostics.EventLogEntryType.Error);

		//寫入文字檔,方法二
		//System.IO.File.AppendAllText(Server.MapPath(string.Format("Log\\{0}.txt", DateTime.Now.Ticks.ToString())), Message);

		//寄出Email,方法三
		//此方法請參考System.Net.Mail.MailMessage

		//清除Error
		Server.ClearError();

		Response.Write("Error Message: " + ex.GetBaseException().Message);
		Response.End();

    }

    void Session_Start(object sender, EventArgs e)
    {
        // 在新的工作階段啟動時執行的程式碼

    }

    void Session_End(object sender, EventArgs e)
    {
        // 在工作階段結束時執行的程式碼
        // 注意: 只有在  Web.config 檔案中將 sessionstate 模式設定為 InProc 時，
        // 才會引起 Session_End 事件。如果將 session 模式設定為 StateServer 
        // 或 SQLServer，則不會引起該事件。

    }

</script>
