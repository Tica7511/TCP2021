<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="lessonlist.aspx.cs" Inherits="Admin_lessonlist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            getData();
        });

        function getData() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "BackEnd/GetAssignment.aspx",
                data: {
                    type: "list",
                    aguid: "",
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
                                tabstr += '<tr>';
                                tabstr += '<td class=""><a href="lessonview.aspx?guid='+ $(this).children("A_Guid").text().trim() + '">' + $(this).children("A_Name").text().trim() + '</a></td>';
                                tabstr += '<td align="center">' + getDate($(this).children("A_OpenDate").text().trim()) + '&nbsp;' + getHH($(this).children("A_OpenDate").text().trim()) + ':' + getMM($(this).children("A_OpenDate").text().trim())
                                    + ' ~ ' + getDate($(this).children("A_CloseDate").text().trim()) + '&nbsp;' + getHH($(this).children("A_CloseDate").text().trim()) + ':' + getMM($(this).children("A_CloseDate").text().trim()) + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
                        $("#tablist tbody").append(tabstr);
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
           <span class="filetitle font-size6">作業管理</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>

       <div class="stripeMe margin5T" style="overflow-x: auto">
           <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
               <thead>
                   <tr>
                       <th nowrap>作業名稱</th>
                       <th nowrap width="350">開放時間</th>
                   </tr>
               </thead>
               <tbody></tbody>
           </table>
       </div><!-- stripeMe -->
   </div><!-- conainer -->
</asp:Content>

