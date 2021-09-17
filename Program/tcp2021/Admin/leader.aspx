<%@ Page Language="C#" AutoEventWireup="true" CodeFile="leader.aspx.cs" Inherits="Admin_leader" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="keywords" content="關鍵字內容" />
    <meta name="description" content="描述" /><!--告訴搜尋引擎這篇網頁的內容或摘要。--> 
    <meta name="generator" content="Notepad" /><!--告訴搜尋引擎這篇網頁是用什麼軟體製作的。--> 
    <meta name="author" content="工研院 資科中心" /><!--告訴搜尋引擎這篇網頁是由誰製作的。--> 
    <meta name="copyright" content="本網頁著作權所有" /><!--告訴搜尋引擎這篇網頁是...... --> 
    <meta name="revisit-after" content="3 days" /><!--告訴搜尋引擎3天之後再來一次這篇網頁，也許要重新登錄。-->
    <title>TCP Manage Interface</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/bootstrap.css") %>" /><!-- normalize & bootstrap's grid system -->
    <link href="<%= ResolveUrl("~/Admin/css/font-awesome.min.css") %>" rel="stylesheet" /><!-- css icon -->
    <link href="<%= ResolveUrl("~/Admin/css/superfish.css") %>" rel="stylesheet" type="text/css" /><!-- 下拉選單 -->
    <link href="<%= ResolveUrl("~/Admin/css/jquery.mmenu.css") %>" rel="stylesheet" type="text/css" /><!-- mmenu css:行動裝置選單 -->
    <link href="<%= ResolveUrl("~/Admin/css/jquery.powertip.css") %>" rel="stylesheet" type="text/css" /><!-- powertip:tooltips -->
    <link href="<%= ResolveUrl("~/Admin/css/jquery.datetimepicker.css") %>" rel="stylesheet" type="text/css" /><!-- datepicker -->
    <link href="<%= ResolveUrl("~/Admin/css/magnific-popup.css") %>" rel="stylesheet" type="text/css" /><!-- popup dialog -->
    <link href="<%= ResolveUrl("~/Admin/css/OchiLayout.css") %>" rel="stylesheet" type="text/css" /><!-- ochsion layout base -->
    <link href="<%= ResolveUrl("~/Admin/css/OchiColor.css") %>" rel="stylesheet" type="text/css" /><!-- ochsion layout color -->
    <link href="<%= ResolveUrl("~/Admin/css/OchiRWD.css") %>" rel="stylesheet" type="text/css" /><!-- ochsion layout RWD -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%= ResolveUrl("~/Admin/css/emoji.css") %>" rel="stylesheet" type="text/css" /><!-- Emoji -->
    <link href="<%= ResolveUrl("~/Admin/css/style.css") %>" rel="stylesheet" type="text/css" />
    <!-- IE 瀏覽器版本低於 9 處理 -->
    <!--[if lte IE 9]>
    <link href="css/cssie9.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery-1.11.2.min.js") %>"></script>
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery.breakpoint-min.js") %>"></script><!-- 斷點設定 -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/superfish.min.js") %>"></script><!-- 下拉選單 -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/supposition.js") %>"></script><!-- 下拉選單:修正最後項在視窗大小不夠時的BUG -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery.mmenu.min.js") %>"></script><!-- mmenu js:行動裝置選單 -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery.touchSwipe.min.js") %>"></script><!-- 增加JS觸控操作 for mmenu -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery.powertip.min.js") %>"></script><!-- powertip:tooltips -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery.datetimepicker.js") %>"></script><!-- datepicker -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery.easytabs.min.js") %>"></script><!-- easytabs tab -->
    <script type="text/javascript" src="<%= ResolveUrl("~/Admin/js/jquery.magnific-popup.min.js") %>"></script><!-- popup dialog -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.cookie.js") %>"></script><!-- cookie -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.matchHeight-min.js") %>"></script><!-- equal height解決bootstrap grid layout內容不等高時排版問題 -->
    <!--my.js-->
	<script type="text/javascript" src="<%= ResolveUrl("~/js/NickCommon.js") %>"></script>
	<script type="text/javascript" src="<%= ResolveUrl("~/js/PageList.js") %>"></script>
	<script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-ui.1.12.1.js") %>"></script>
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
					PageSize: 10,
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
                                    tabstr += '<td class="" align="center">Yes</td>';
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
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }
    </script>
</head>
<body>
    <!-- 開頭用div:修正mmenu form bug -->
    <div>
        <form id="form1" runat="server">
            <div class="WrapperBody">
            	<div class="WrapperHeader">
                    <div class="container">
                        <div class="loginfo font-normal">
                        User：<%= username %>
                        <!-- RWD 外部連結 start -->
                            <div class="HeaderOtherLinkWrapper">
                                <span id="HeaderOtherLink">
                                    <ul>
                                    	<li><a href="<%= ResolveUrl("~/Handler/logout.aspx") %>">Logout</a></li>
                                    </ul>
                                </span>
                            </div><!-- HeaderOtherLinkWrapper -->
                            <span class="HeaderOtherLinkOpen"><a href="#HeaderOtherLinkS" class="open-popup-link">外部連結</a></span> 
                            <div id="HeaderOtherLinkS" class="magpopup magSizeM mfp-hide">
              		        	<div class="magpopupTitle textcenter">外部連結</div>
                                <span id="HeaderOtherLinkCopy"></span>
            		        </div><!--magpopup -->
                        <!-- RWD 外部連結 end -->
                        </div><!-- loginfo -->
                    
            		    <div class="logo"><img alt="logo" src="<%= ResolveUrl("~/Admin/images/logo.png") %>" class="img-responsive" /> </div>
                    </div><!-- container -->
                    
            		<div class="MainMenu">
                    <!-- 置中版面控制:滿版可移除container或改成container-fluid -->
            		    <div class="container">
                        <!-- 側邊選單開關容器 -->	
            		    <div id="opensidemenu"></div>
            		    <!-- 桌機主選單 -->          
                        	<div class="superfishmenu">
                                <ul>
                                    <li><a href="<%= ResolveUrl("~/Admin/leader.aspx") %>" title="index">index</a></li>
                                </ul>
                            </div><!-- superfishmenu -->
                        </div><!-- container -->        
            		</div><!-- MainMenu -->    
                </div><!-- WrapperHeader -->
               
                <div class="container margin15T">
                    <div class="filetitlewrapper">
                        <span class="filetitle font-size6">Track Record</span>
                        <!--<span class="itemright">麵包屑</span>-->
                    </div>

                    <div class="twocol margin20T">
                        <div class="left">
                            <span class="font-size4 font-bold font-title">Member List</span>
                        </div><!-- left -->
                        <div class="right">
                             <a href="<%= ResolveUrl("../EXPORTEXCEL.aspx") %>" class="genbtnS">Export</a>
                        </div><!-- right -->
                    </div><!-- twocol -->

                    <div class="stripeMe margin5T" style="overflow-x: auto">
                        <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
                            <thead>
                                <tr>
                                    <th nowrap width="250">Name</th>
                                    <th nowrap width="100">Online Courses</th>
                                    <th nowrap width="200">Group</th>
                                    <th nowrap width="100">Finish</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                        <div class="margin10B margin10T textcenter">
	                		<div id="pageblock"></div>
	                	</div>
                    </div><!-- stripeMe -->
                </div><!-- conainer -->
            </div><!-- WrapperBody -->
        </form>
    </div>
</body>
</html>
