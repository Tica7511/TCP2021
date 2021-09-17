<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="WebPage_login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="zh-TW">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="content-language" content="zh-TW" />
    <meta http-equiv="X-UA-Compatible" content="IE=11; IE=10; IE=9; IE=8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="keywords" content="關鍵字內容" />
    <meta name="description" content="描述" /><!--告訴搜尋引擎這篇網頁的內容或摘要。--> 
    <meta name="generator" content="Notepad" /><!--告訴搜尋引擎這篇網頁是用什麼軟體製作的。--> 
    <meta name="author" content="工研院 資科中心" /><!--告訴搜尋引擎這篇網頁是由誰製作的。--> 
    <meta name="copyright" content="本網頁著作權所有" /><!--告訴搜尋引擎這篇網頁是...... --> 
    <meta name="revisit-after" content="3 days" /><!--告訴搜尋引擎3天之後再來一次這篇網頁，也許要重新登錄。-->
    <title>2021 TCP</title>
    <link rel="stylesheet" href="<%= ResolveUrl("~/css/bootstrap.css") %>" /><!-- normalize & bootstrap's grid system -->
    <link href="<%= ResolveUrl("~/css/font-awesome.min.css") %>" rel="stylesheet" /><!-- css icon -->
    <link href="<%= ResolveUrl("~/css/superfish.css") %>" rel="stylesheet" type="text/css" /><!-- 下拉選單 -->
    <link href="<%= ResolveUrl("~/css/jquery.mmenu.css") %>" rel="stylesheet" type="text/css" /><!-- mmenu css:行動裝置選單 -->
    <link href="<%= ResolveUrl("~/css/jquery.powertip.css") %>" rel="stylesheet" type="text/css" /><!-- powertip:tooltips -->
    <link href="<%= ResolveUrl("~/css/jquery.datetimepicker.css") %>" rel="stylesheet" type="text/css" /><!-- datepicker -->
    <link href="<%= ResolveUrl("~/css/magnific-popup.css") %>" rel="stylesheet" type="text/css" /><!-- popup dialog -->
    <link href="<%= ResolveUrl("~/css/OchiLayout.css") %>" rel="stylesheet" type="text/css" /><!-- ochsion layout base -->
    <link href="<%= ResolveUrl("~/css/OchiColor.css") %>" rel="stylesheet" type="text/css" /><!-- ochsion layout color -->
    <link href="<%= ResolveUrl("~/css/OchiRWD.css") %>" rel="stylesheet" type="text/css" /><!-- ochsion layout RWD -->
    <link href="<%= ResolveUrl("~/css/style.css") %>" rel="stylesheet" type="text/css" />
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" />
    <link href="<%= ResolveUrl("~/css/emoji.css") %>" rel="stylesheet" type="text/css" /><!-- Emoji -->    
    <!-- IE 瀏覽器版本低於 9 處理 -->
    <!--[if lte IE 9]>
    <link href="css/cssie9.css" rel="stylesheet" type="text/css" />
    <![endif]-->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-1.11.2.min.js") %>"></script>
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.breakpoint-min.js") %>"></script><!-- 斷點設定 -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/superfish.js") %>"></script><!-- 下拉選單 -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.mmenu.all.js") %>"></script><!-- mmenu js:行動裝置選單 -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.touchSwipe.min.js") %>"></script><!-- 增加JS觸控操作 for mmenu -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.powertip.min.js") %>"></script><!-- powertip:tooltips -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.datetimepicker.js") %>"></script><!-- datepicker -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.easytabs.min.js") %>"></script><!-- easytabs tab -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.magnific-popup.min.js") %>"></script><!-- popup dialog -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.cookie.js") %>"></script><!-- cookie -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.matchHeight-min.js") %>"></script><!-- equal height解決bootstrap grid layout內容不等高時排版問題 -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/animatescroll.min.js") %>"></script><!-- 動態滾動 -->    

    <!--my.js-->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/NickCommon.js") %>"></script>
    <script type="text/javascript" src="<%= ResolveUrl("~/js/PageList.js") %>"></script>
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery-ui.1.12.1.js") %>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).on("keyup", "body", function (e) {
                if (e.keyCode == 13)
                    $("#lgbtn").click();
            });

            $(document).on("click", "#lgbtn", function () {
                $("#errMsg").empty();
                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../Handler/Login.aspx",
                    data: {
                        acc: $("#acStr").val(),
                        pw: encodeURIComponent($("#pStr").val())
                    },
                    error: function (xhr) {
                        $("#errMsg").html("Error: " + xhr.status);
                        console.log(xhr.responseText);
                    },
                    success: function (data) {
                        if ($(data).find("Error").length > 0)
                            $("#errMsg").html($(data).find("Error").attr("Message"));
                        else {
                            location.href = "classlist.aspx";
                        }
                    }
                });
            });
        });
    </script>
    <style type="text/css">
    
    </style>
</head>
<body class="">
    <!-- 開頭用div:修正mmenu form bug -->
    <div class="tcpbg">
        <form id="form1" runat="server">
            <a href="#Insidemaincontent" id="jumptocontent" title="跳到主要內容區塊" tabindex="1">跳到主要內容區塊</a>
            <div class="WrapperBody">
            	<div class="WrapperHeader nonebg">
            
                    <div class="container">
            
                        <div class="textcenter margin20T">
                            <div class="logocolor logosize font-bold margin10T">TCPIII</div>
                            <div class="font-size4 logocolor font-white opa6">EU Notified Body Partners Training Workshop</div>
                        </div>
            
                        <div class="BoxBgOb BoxRadiusA font-white margin20T">
                            <div class="padding10ALL">
                                <div class="OchiFixTable width100 TitleLength05 font-size3">
                                    <div class="OchiRow">
                                        <div class="OchiCell OchiTitle TitleSetWidth">ID</div>
                                        <div class="OchiCell width100"><input type="text" id="acStr" class="width99 inputex" /></div>
                                    </div><!-- OchiRow -->
                                    <div class="OchiRow">
                                        <div class="OchiCell OchiTitle TitleSetWidth">Password</div>
                                        <div class="OchiCell width100"><input type="password" id="pStr" class="width99 inputex" /></div>
                                    </div><!-- OchiRow -->
                                </div><!-- OchiFixTable -->
                            </div><!-- padding10ALL -->
                            <div id="errMsg" style="color: red; text-align: center;"></div>
                            <a id="lgbtn" href="javascript:void(0);" class="fullbtn font-size5">login</a>
                        </div><!-- Box -->
                    </div>
                </div><!-- WrapperHeader -->
            </div><!-- WrapperBody -->
            <div class="WrapperFooter">
            	<div class="footerblock container font-white">
                    Copyright © 2021 Industrial Technology Research Institute.
            	</div><!--{* footerblock *}-->
            </div><!-- WrapperFooter -->
            <!-- 側邊選單內容:動態複製主選單內容 -->
            <div id="sidebar-wrapper">
            
            </div><!-- sidebar-wrapper -->
        </form>
    </div>

<!-- 本頁面使用的JS -->
<script type="text/javascript">
    $(document).ready(function () {
        $(".container").css("max-width", "700px");

        $('.equalheightblock').matchHeight({
            byRow: true,//若為false,則所有區塊等高
            property: 'height',//使用min-height會出問題
            target: null,//設定等高對象:$('.sidebar')
            remove: false
        });

    });
</script>
<script type="text/javascript" src="<%= ResolveUrl("~/js/GenCommon.js") %>"></script><!-- UIcolor JS -->
<script type="text/javascript" src="<%= ResolveUrl("~/js/PageCommon.js") %>"></script><!-- 系統共用 JS -->
<script type="text/javascript" src="<%= ResolveUrl("~/js/autoHeight.js") %>"></script><!-- 高度不足頁面的絕對置底footer -->

</body>
</html>
