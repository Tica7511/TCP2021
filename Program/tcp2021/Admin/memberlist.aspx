<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="memberlist.aspx.cs" Inherits="Admin_memberlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            getData(0);
        });

        function getData(p) {
			$.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetMember.aspx",
                data: {
                    type: "list",
                    guid: "",
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
                                var Competence = $(this).children("M_Competence").text().trim();
                                var Status = $(this).children("M_Status").text().trim();
                                if (Competence == '01')
                                    Competence = '管理者';
                                else if (Competence == '02')
                                    Competence = '會員';
                                else
                                    Competence = '會員組長';
								tabstr += '<tr>';
                                tabstr += '<td class="">';
                                tabstr += '<a href="../Admin/memberview.aspx?guid=' + $(this).children("M_Guid").text().trim() + '">' + $(this).children("M_Account").text().trim() + '</a>'
                                tabstr += '</td>';
                                tabstr += '<td align="center">' + $(this).children("M_Name").text().trim() + '</td>';
                                tabstr += '<td align="center">' + $(this).children("G_Name").text().trim() + '</td>';
                                tabstr += '<td align="center">' + Competence + '</td>';
                                if (Status == 'A') {
                                    tabstr += '<td align="center">上架</td>';
                                }
                                else {
                                    tabstr += '<td align="center">下架</td>';
                                }
								tabstr += '</tr>';
							});
						}
						else
							tabstr += '<tr><td colspan="5">查詢無資料</td></tr>';
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
        <span class="filetitle font-size6">會員管理</span>
        <!--<span class="itemright">麵包屑</span>-->
    </div>



    <div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">會員管理清單</span>
        </div><!-- left -->
        <div class="right">
             <a href="<%= ResolveUrl("~/Admin/memberview.aspx") %>" class="genbtnS">新增會員</a>
        </div><!-- right -->
    </div><!-- twocol -->


    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap>信箱</th>
                    <th nowrap>姓名</th>
                    <th nowrap>組別</th>
                    <th nowrap>角色</th>
                    <th nowrap>顯示</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
			<div id="pageblock"></div>
		</div>
    </div><!-- stripeMe -->
    <%--<div class="margin5T">
        <ul>
            <li>會員帳號為信箱，密碼為生日(格式：YYYYMMDD)</li>
        </ul>
    </div>--%>
</asp:Content>

