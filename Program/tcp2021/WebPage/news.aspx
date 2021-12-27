<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="news.aspx.cs" Inherits="WebPage_news" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            /*getData();*/
        });

        function getData() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Handler/GetNews.aspx",
                data: {
                    type: "list",
                    nid: "",
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
                        $("#div_content").empty();
                        var divstr = '';
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                var nDate = $(this).children("N_Date").text().trim();
                                var nID = $(this).children("N_ID").text().trim();
                                divstr += '<div class="container padding10RL padding20B"><div class="row margin20T margin10B"><div class="col-lg-10 col-md-9 col-sm-8 BoxBgOb equalheightblock padding10ALL movieticketL">';
                                divstr += '<div class="font-size3 font-white">' + $(this).children("N_Title").text().trim() + '</div>';
                                divstr += '<div class="margin10T font-size2 font-white opa6">' + getDate(nDate) + " " + getHH(nDate) + ":" + getMM(nDate) + '</div></div>';
                                divstr += '<div class="col-lg-2 col-md-3 col-sm-4 BoxBgCa equalheightblock padding10ALL movieticketR"><div class="textcenter font-white">';
                                divstr += '<a target="_self" href="newsview.aspx?id=' + (this).children("N_ID").text().trim() + '"><div class="font-size9"><i class="fa fa-newspaper-o" aria-hidden="true"></i></div><div class="font-size3">View</div></a></div></div></div>';
                            });
                        }

                        $("#div_content").append(divstr);
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
    <div class="container marT5v margin10B">

   
   <div id="Insidemaincontent">
       <!-- 所有網站內容放在此以下 -->
       <div class=""><a name="blockA"></a></div>
       <div class="filetitlewrapper">
           <span class="filetitle font-white font-size5">News</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>

       <div id="div_content" class="paddingMVRL margin10B">
           <div class="container padding10RL padding20B">
               <asp:Repeater ID="NewsList" runat="server">
                   <ItemTemplate>
                    <div class="row margin20T margin10B">
                        <div class="col-lg-10 col-md-9 col-sm-8 BoxBgOb equalheightblock padding10ALL movieticketL">
                            <div class="font-size3 font-white"><%# System.Web.HttpUtility.HtmlEncode(Eval("N_Title")) %></div>
                            <div class="margin10T font-size2 font-white opa6"><%# System.Web.HttpUtility.HtmlEncode(Eval("Detail_Date")) %></div>
                        </div><!-- col -->
                        <div class="col-lg-2 col-md-3 col-sm-4 BoxBgCa equalheightblock padding10ALL movieticketR">
                            <div class="textcenter font-white">
                                <!--<a href="#">
                                    <div class="font-size9"><i class="fa fa-lock" aria-hidden="true"></i></div>
                                    <div class="font-size3">Lock</div>
                                </a>-->
                                <a href="newsview.aspx?id=<%# System.Web.HttpUtility.HtmlEncode(Eval("Detail_ID")) %>" target="_self">
                                    <div class="font-size9"><i class="fa fa-newspaper-o" aria-hidden="true"></i></div>
                                    <div class="font-size3">View</div>
                                </a>
                            </div>
                        </div><!-- col -->
                    </div><!-- row -->
                    </ItemTemplate>
               </asp:Repeater>
               <div class="margin10B margin10T textcenter">
					<asp:Repeater ID="PageList" runat="server" OnItemDataBound="Repeater_ItemDataBound">
						<HeaderTemplate>
							<asp:LinkButton ID="prevPage" runat="server" CssClass="pagestylegen" title="上一頁" OnClick="PrevPage_click"><</asp:LinkButton>
						</HeaderTemplate>
						<ItemTemplate>
							<a href="<%# Eval("url") %>" class="pagestylegen <%# pNoClass(Eval("page")) %>" title="第<%# Eval("page") %>頁"><%# Eval("page") %></a>
						</ItemTemplate>
						<FooterTemplate>
							<asp:LinkButton ID="nextPage" runat="server" CssClass="pagestylegen" title="下一頁" OnClick="NextPage_click">></asp:LinkButton>
						</FooterTemplate>
					</asp:Repeater>
				</div>
                <!-- news list end -->
           </div><!-- container -->
       </div><!-- paddingMVRL -->


       <!-- 所有網站內容放在此以上 -->
   </div><!-- Insidemaincontent -->
   
   </div><!-- conainer -->
</asp:Content>

