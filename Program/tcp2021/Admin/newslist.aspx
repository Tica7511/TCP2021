<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="newslist.aspx.cs" Inherits="Admin_newslist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            getData(0);
        });

        function getData(p) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Admin/BackEnd/GetNews.aspx",
                data: {
                    type: "list",
                    nid: "",
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
                                var Status = $(this).children("N_Status").text().trim();
                                tabstr += '<tr>';
                                tabstr += '<td class="">';
                                tabstr += '<a href="../Admin/newsview.aspx?id=' + $(this).children("N_ID").text().trim() + '">' + $(this).children("N_Title").text().trim() + '</a>'
                                tabstr += '</td>';
                                tabstr += '<td align="center">' + getDate($(this).children("N_Date").text().trim()) + '&nbsp;' + getHH($(this).children("N_Date").text().trim()) + ':' + getMM($(this).children("N_Date").text().trim()) + '</td>';
                                tabstr += '<td align="center">' + $(this).children("N_Sort").text().trim() + '</td>';
                                if (Status == 'A')
                                    tabstr += '<td align="center">上架</td>';
                                else
                                    tabstr += '<td align="center">下架</td>';
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
    <div class="container margin15T">

       <div class="filetitlewrapper">
           <span class="filetitle font-size6">最新消息</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>



       <div class="twocol margin20T">
           <div class="left">
               <span class="font-size4 font-bold font-title">最新消息清單</span>
           </div><!-- left -->
           <div class="right">
                <a href="newsview.aspx" class="genbtnS">新增</a>
           </div><!-- right -->
       </div><!-- twocol -->


       <div class="stripeMe margin5T" style="overflow-x: auto">
           <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
               <thead>
                   <tr>
                       <th nowrap>新聞名稱</th>
                       <th nowrap>發表時間</th>
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


     
   </div><!-- conainer -->
</asp:Content>

