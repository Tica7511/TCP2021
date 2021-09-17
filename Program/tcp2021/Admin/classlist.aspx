<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="classlist.aspx.cs" Inherits="Admin_classlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            getData(0);
            /*getData2(0);*/
        });

        function getData(p) {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetClassList.aspx",
                data: {
                    type: "list",
                    cguid: "",
                    PageNo: p,
					PageSize: Page.Option.PageSize,
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
                                tabstr += '<td><a name="editbtn" href="classview.aspx?guid=' + $(this).children("C_Guid").text().trim() +'">' + $(this).children("C_Name").text().trim() + '</a></td>'
                                tabstr += '<td align="center">' + getDate($(this).children("C_OpenDate").text().trim()) + '&nbsp;' + getHH($(this).children("C_OpenDate").text().trim()) + ':' + getMM($(this).children("C_OpenDate").text().trim())
                                    + ' ~ ' + getDate($(this).children("C_CloseDate").text().trim()) + '&nbsp;' + getHH($(this).children("C_CloseDate").text().trim()) + ':' + getMM($(this).children("C_CloseDate").text().trim()) + '</td>';
                                tabstr += '<td align="center">' + $(this).children("C_Sort").text().trim() + '</td>';
                                var status = $(this).children("C_Status").text().trim();
                                if (status == 'A')
                                    status = '上架';
                                else
                                    status = '下架';
                                tabstr += '<td align="center">' + status + '</td>';
                                tabstr += '</tr>';
							});
                        }
                        else
							tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
						$("#tablist tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock";
                        Page.Option.FunctionName = "getData";
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }

        function getData2(p) {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetOtherClassList.aspx",
                data: {
                    type: "list",
                    cguid: "",
                    PageNo: p,
					PageSize: Page.Option.PageSize,
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
						$("#tablist2 tbody").empty();
						var tabstr = '';
						if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                tabstr += '<tr>'
                                tabstr += '<td><a name="editbtn" href="otherclassview.aspx?guid=' + $(this).children("OC_Guid").text().trim() +'">' + $(this).children("OC_Name").text().trim() + '</a></td>'
                                tabstr += '<td align="center">' + getDate($(this).children("OC_OpenDate").text().trim()) + '&nbsp;' + getHH($(this).children("OC_OpenDate").text().trim()) + ':' + getMM($(this).children("OC_OpenDate").text().trim())
                                    + ' ~ ' + getDate($(this).children("OC_CloseDate").text().trim()) + '&nbsp;' + getHH($(this).children("OC_CloseDate").text().trim()) + ':' + getMM($(this).children("OC_CloseDate").text().trim()) + '</td>';
                                tabstr += '<td align="center">' + $(this).children("OC_Sort").text().trim() + '</td>';
                                var status = $(this).children("OC_Status").text().trim();
                                if (status == 'A')
                                    status = '上架';
                                else
                                    status = '下架';
                                tabstr += '<td align="center">' + status + '</td>';
                                tabstr += '</tr>';
							});
                        }
                        else
							tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
						$("#tablist2 tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock2";
                        Page.Option.FunctionName = "getData2";
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }

        function getDate(fulldate) {
            if (fulldate != '') {
                var year = fulldate.substring("0", "4");
                var month = fulldate.substring("4", "6");
                var date = fulldate.substring("6", "8");

                return year + "/" + month + "/" + date;
            }
            else {
                return fulldate;
            }
        }

        function getHH(fulltime) {
            if (fulltime != '') {
                var hh = fulltime.substring("8", "10");
                return hh;
            }
            else {
                return fulltime;
            }
        }

        function getMM(fulltime) {
            if (fulltime != '') {
                var mm = fulltime.substring("10", "12");
                return mm;
            }
            else {
                return fulltime;
            }
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="filetitlewrapper">
        <span class="filetitle font-size6">線上課程</span>
        <!--<span class="itemright">麵包屑</span>-->
    </div>

    <div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">線上課程列表</span>
        </div><!-- left -->
        <div class="right">
            <a class="genbtn" href="classview.aspx">新增課程</a>
        </div><!-- right -->
    </div><!-- twocol -->


    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap>影片名稱</th>
                    <th nowrap width="350">開放時間</th>
                    <th nowrap>排序</th>
                    <th nowrap>顯示</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
	        <div id="pageblock"></div>
	    </div>
    </div><!-- stripeMe -->

    <%--<div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">選修線上課程列表</span>
        </div><!-- left -->
        <div class="right">
            <a class="genbtn" href="otherclassview.aspx">新增課程</a>
        </div><!-- right -->
    </div><!-- twocol -->


    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist2" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap>影片名稱</th>
                    <th nowrap width="350">開放時間</th>
                    <th nowrap>排序</th>
                    <th nowrap>顯示</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
	        <div id="pageblock2"></div>
	    </div>
    </div><!-- stripeMe -->--%>
</asp:Content>

