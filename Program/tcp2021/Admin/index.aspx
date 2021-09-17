<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="Admin_index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            getData(0);
        });

        function getData(p) {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "BackEnd/GetTranscript.aspx",
                data: {
                    PageNo: p,
					PageSize: 20,
				},
				error: function (xhr) {
					alert("Error: " + xhr.status);
					console.log(xhr.responseText);
				},
				success: function (data) {
					if ($(data).find("Error").length > 0) {
						alert($(data).find("Error").attr("Message"));
					}
                    else {
                        $("#tablist tbody").empty();
						var tabstr = '';
						if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) { 
                                tabstr += '<tr>'
                                tabstr += '<td class="">' + $(this).children("M_Name").text().trim() + '</td>'
                                tabstr += '<td class="" align="center">' + $(this).children("mcCount").text().trim() + '/' + $(this).children("cCount").text().trim() + '</td>'
                                tabstr += '<td class="" align="center">' + $(this).children("G_Name").text().trim() + '</td>'
                                if ($(this).children("allCount").text().trim() == 'Y')
                                    tabstr += '<td class="" align="center">完成</td>';
                                else
                                    tabstr += '<td class="" align="center"></td>';
                                tabstr += '</tr>'
							});
                        }
                        else
							tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
                        $("#tablist tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock";
                        Page.Option.FunctionName = "getData";
                        Page.Option.PageSize = 20;
                        Page.Option.HomeBtn = true;
                        Page.Option.LastBtn = true;
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="filetitlewrapper">
        <span class="filetitle font-size6">會員授課總覽</span>
        <!--<span class="itemright">麵包屑</span>-->
    </div>

    <div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">會員清單</span>
        </div><!-- left -->
        <div class="right">
             <a href="<%= ResolveUrl("../EXPORTEXCEL.aspx") %>" class="genbtnS">匯出</a>
        </div><!-- right -->
    </div><!-- twocol -->

    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap width="250">會員名稱</th>
                    <th nowrap width="100">線上影片</th>
                    <th nowrap width="200">組別</th>
                    <th nowrap width="100">結業</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
			<div id="pageblock"></div>
		</div>
    </div><!-- stripeMe -->
</asp:Content>

