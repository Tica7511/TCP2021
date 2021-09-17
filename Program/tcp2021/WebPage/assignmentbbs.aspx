<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="assignmentbbs.aspx.cs" Inherits="WebPage_assignmentbbs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            if ($.getQueryString("guid") != '') {
                getForums();
            }
            else {
                alert("Parameter error! You will be redirected back to the Online Courses");
                location.href = "classlist.aspx";
            }

            $(document).on("click", "#a_assignment", function () {
                locationAssignment();
            });

            //發送留言
            $(document).on("click", "#csubbtn", function () {
                var msg = '';
                if ($("#txt_comment").val() == "")
                    msg += "Please type something in the textarea before you send";

                if (msg != "") {
                    $("#errMsg").html(msg);
                    return false;
                }

                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../Handler/AddAssignmentForums.aspx",
                    data: {
                        guid: "",
                        cguid: $.getQueryString("guid"),
                        content: $("#txt_comment").val(),
                    },
                    error: function (xhr) {
                        $("#errMsg").html("Error: " + xhr.status);
                        console.log(xhr.responseText);
                    },
                    success: function (data) {
                        if ($(data).find("Error").length > 0) {
                            $("#errMsg").html($(data).find("Error").attr("Message"));
                        }
                        else {
                            alert($("Response", data).text());
                            $.magnificPopup.close();
                            getForums();
                        }
                    }
                });
            });

            $(document).on("click", "#popupcomment", function (e) {
                $("#errMsg").html('');
                e.preventDefault();
                $(".emoji-wysiwyg-editor").html('');
                doOpenCommentPopup();
            });

            //發送回覆
            $(document).on("click", "#rsubbtn", function () {
                var msg = '';
                if ($("#txt_reply").val() == "")
                    msg += "Please type something in the textarea before you send";

                if (msg != "") {
                    $("#errMsg2").html(msg);
                    return false;
                }

                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "../Handler/AddAssignmentForums.aspx",
                    data: {
                        guid: $("#CommentGuid").val(),
                        cguid: $.getQueryString("guid"),
                        content: $("#txt_reply").val(),
                    },
                    error: function (xhr) {
                        $("#errMsg2").html("Error: " + xhr.status);
                        console.log(xhr.responseText);
                    },
                    success: function (data) {
                        if ($(data).find("Error").length > 0) {
                            $("#errMsg2").html($(data).find("Error").attr("Message"));
                        }
                        else {
                            alert($("Response", data).text());
                            $.magnificPopup.close();
                            getForums();
                            //location.href = "members.aspx";
                        }
                    }
                });
            });

            $(document).on("click", "a[name='popreply']", function (e) {
                $("#errMsg2").html('');
                $("#CommentGuid").val($(this).attr("aid"));
                e.preventDefault();
                $(".emoji-wysiwyg-editor").html('');
                doOpenReplyPopup();
            });

            //tabs 20210805
            $('#tab-container').easytabs({
                defaultTab: "li:nth-child(2)",//預設開啟
                updateHash: false,//停止切換頁籤跳轉到內容
            });
        });

        function locationAssignment() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Handler/GetAssignment.aspx",
                data: {
                    type: "data",
                    aguid: $.getQueryString("guid"),
                    number: "",
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
                        if ($(data).find("data_item2").length > 0) {
                            $(data).find("data_item2").each(function (i) {
                                location.href = "assignmentview" + $(this).children("A_Sort").text().trim() + ".aspx?guid=" + $(this).children("A_Guid").text().trim();
                            });
                        }
                    }
                }
            });
        }

        function doOpenCommentPopup() {
            $.magnificPopup.open({
                items: {
                    src: '#popComment'
                },
                type: 'inline',
                midClick: false, // 是否使用滑鼠中鍵
                closeOnBgClick: true,//點擊背景關閉視窗
                showCloseBtn: true,//隱藏關閉按鈕
                fixedContentPos: true,//彈出視窗是否固定在畫面上
                mainClass: 'mfp-fade',//加入CSS淡入淡出效果
                tClose: '關閉',//翻譯字串
            });
        }

        function doOpenReplyPopup() {
            $.magnificPopup.open({
                items: {
                    src: '#popReply'
                },
                type: 'inline',
                midClick: false, // 是否使用滑鼠中鍵
                closeOnBgClick: true,//點擊背景關閉視窗
                showCloseBtn: true,//隱藏關閉按鈕
                fixedContentPos: true,//彈出視窗是否固定在畫面上
                mainClass: 'mfp-fade',//加入CSS淡入淡出效果
                tClose: '關閉',//翻譯字串
            });
        }

        function getForums() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Handler/GetAssignmentForums.aspx",
                data: {
                    type: "comment",
                    guid: "",
                    cguid: $.getQueryString("guid"),
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
                        $("#forumsList").empty();
                        var tabstr = '';
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                tabstr += '<div class="BoxBorderSa BoxRadiusB padding10ALL margin10T"><div class="twocol">';
                                tabstr += '<div class="left"><span class="font-title font-bold">' + $(this).children("M_Name").text().trim() + '</span> say </div>';
                                tabstr += '<div class="right">' + $(this).children("contentDate").text().trim() + '&nbsp;' + $(this).children("contentTime").text().trim() + "(GMT+8)" + '</div></div>';
                                tabstr += '<div class="margin5T lineheight02">' + $(this).children("AF_Content").text().trim() + '</div>';
                                tabstr += '<div class="twocol margin5T">';
                                tabstr += '<div class="right"><a name="popreply" href="javascript:void(0);" class="genbtnS" aid="' + $(this).children("AF_Guid").text().trim() + '">Reply</a></div>';
                                tabstr += '</div>';

                                $.ajax({
                                    type: "POST",
                                    async: false, //在沒有返回值之前,不會執行下一步動作
                                    url: "../Handler/GetAssignmentForums.aspx",
                                    data: {
                                        type: "reply",
                                        cguid: $.getQueryString("guid"),
                                        guid: $(this).children("AF_Guid").text().trim(),
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
                                            var replystr = '';
                                            if ($(data).find("data_item").length > 0) {
                                                $(data).find("data_item").each(function (i) {
                                                    replystr += '<div class="BoxRadiusB ReComm BoxBorderDb padding10ALL margin10T"><div class="twocol">';
                                                    replystr += '<div class="left"><span class="font-title font-bold">' + $(this).children("M_Name").text().trim() + '</span> say </div>';
                                                    replystr += '<div class="right">' + $(this).children("contentDate").text().trim() + '&nbsp;' + $(this).children("contentTime").text().trim() + "(GMT+8)" + '</div></div>';
                                                    replystr += '<div class="margin5T lineheight02">' + $(this).children("AF_Content").text().trim() + '</div></div>';
                                                });
                                                tabstr += replystr;
                                            }
                                        }
                                    }
                                });

                                tabstr += '</div>';
                            });
                        }
                        else
                            tabstr += '<div class="BoxBorderSa BoxRadiusB padding10ALL margin10T"><div class="left"><span class="font-title font-bold">There is no comment below.</span></div></div>'
                        $("#forumsList").append(tabstr);
                    }
                }
            });
        }

        $(function () {
            // Initializes and creates emoji set from sprite sheet
            window.emojiPicker = new EmojiPicker({
                emojiable_selector: '[data-emojiable=true]',
                assetsPath: '../images/',
                popupButtonClasses: 'fa fa-smile-o'
            });
            // Finds all elements with `emojiable_selector` and converts them to rich emoji input fields
            // You may want to delay this step if you have dynamically created input fields that appear later in the loading process
            // It can be called as many times as necessary; previously converted input fields will not be converted again
            window.emojiPicker.discover();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="CommentGuid" />
    <div class="container margin15T">

        <div id="Insidemaincontent">
            <!-- 所有網站內容放在此以下 -->
            <div class="filetitlewrapper">
                <span class="filetitle font-size5">Assignment</span>
                <span class="itemright font-black"></span>
            </div>

            <div class="paddingMVRL">

                <div class="twocol margin10T">
                    <div class="left">
                        <span class="font-size4 font-title">Essential Principles of Safety and Performance of Medical Devices and IVD Medical Devices</span>
                    </div>
                    <div class="right">
                        <span class="font-normal"></span>
                    </div>
                </div>

                <div id="tab-container" class='easytabH'>
                    <ul class="menubar">
                        <li><a id="a_assignment" href="javascript:void(0);" target="_self" data-target="#tabs-ajax-js">Assignment</a></li>
                        <li><a href="#tabs2">Forums</a></li>
                    </ul>
                    <div class='panel-container'>
                        <div id="tabs2">
                            <div class="textright"><a id="popupcomment" href="javascript:void(0);" class="genbtn">Comment</a></div>

                            <div id="forumsList"></div>
                        </div>
                        <!-- tabs2 -->
                    </div>
                    <!-- panel-container -->
                </div>
                <!-- tab-container -->
            </div>
            <!-- paddingMVRL -->

            <!-- 所有網站內容放在此以上 -->
        </div>
        <!-- Insidemaincontent -->
    </div>
    <!-- conainer -->

    <div id="popComment" class="magpopup magSizeM mfp-hide">
        <div class="magpopupTitle">Comment</div>
        <div class="padding10ALL">
            <p class="lead emoji-picker-container">
                <textarea id="txt_comment" class="form-control textarea-control" rows="5" style="height: 200px;" placeholder="Please type something here" data-emojiable="true" data-emoji-input="unicode"></textarea>
            </p>

            <div class="twocol margin10T">
                <div class="left">
                    <span id="errMsg" style="color: red;"></span>
                </div>
                <div class="right">
                    <a href="javascript:void(0);" class="genbtn closemagnificPopup">Cancel</a>
                    <a id="csubbtn" href="javascript:void(0);" class="genbtn">Send</a>
                </div>
            </div>
            <!-- twocol -->
        </div>
        <!-- padding10ALL -->
    </div>
    <!--magpopup -->

    <div id="popReply" class="magpopup magSizeM mfp-hide">
        <div class="magpopupTitle">Reply</div>
        <div class="padding10ALL">
            <p class="lead emoji-picker-container">
                <textarea id="txt_reply" class="form-control textarea-control" rows="5" style="height: 200px;" placeholder="Please type something here" data-emojiable="true" data-emoji-input="unicode"></textarea>
            </p>

            <div class="twocol margin10T">
                <div class="left">
                    <span id="errMsg2" style="color: red;"></span>
                </div>
                <div class="right">
                    <a href="javascript:void(0);" class="genbtn closemagnificPopup">Cancel</a>
                    <a id="rsubbtn" href="javascript:void(0);" class="genbtn">Send</a>
                </div>
            </div>
            <!-- twocol -->
        </div>
        <!-- padding10ALL -->
    </div>
    <!--magpopup -->

    <!-- 本頁面使用的JS -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/config.js") %>"></script>
    <!-- Emoji -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/util.js") %>"></script>
    <!-- Emoji -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.emojiarea.js") %>"></script>
    <!-- Emoji -->
    <script type="text/javascript" src="<%= ResolveUrl("~/js/emoji-picker.js") %>"></script>
    <!-- Emoji -->
</asp:Content>