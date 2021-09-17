<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="classview.aspx.cs" Inherits="WebPage_classview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            if ($.getQueryString("guid") != '') {
                getData();
                /*getForums();*/
            }
            else {
                alert("Parameter error! You will be redirected back to the Online Courses");
                location.href = "classlist.aspx";
            }

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
                    url: "../Handler/AddClassForums.aspx",
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
                    url: "../Handler/AddClassForums.aspx",
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
        });

        function getData() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Handler/GetClassList.aspx",
                data: {
                    type: "data",
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
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                //if ($(this).children("MC_IsFinish").text().trim() == 'Y')
                                //    $("#sp_isFinish").show();
                                $("#div_classname").append($(this).children("C_Name").text().trim());
                                $("#div_embedcode").append($(this).children("EncodeEmbedCode").text().trim());
                                $("#div_teachername").append('Speaker：<sapn>' + $(this).children("C_TeacherName").text().trim() + '</span>');
                            });
                        }
                        if ($(data).find("data_item2").length > 0) {
                            $(data).find("data_item2").each(function (i) {
                                //$("#div_file").append('<i class="fa fa-download IconCa" aria-hidden="true"></i> <a href="../DOWNLOAD.aspx?type=02&v=' + $(this).children("EncodeGuid").text().trim() + '&encryname=' + $(this).children("File_Encryname").text().trim() + '">Download ' + (i + 1) + '</a>&ensp;');
                                $("#div_file").append('<i class="fa fa-download IconCa" aria-hidden="true"></i> <a href="../DOWNLOAD.aspx?type=02&v=' + $(this).children("EncodeGuid").text().trim() + '&encryname=' + $(this).children("File_Encryname").text().trim() + '">Download ' + '</a>&ensp;');
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
                url: "../Handler/GetClassForums.aspx",
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
                                tabstr += '<div class="margin5T lineheight02">' + $(this).children("CF_Content").text().trim() + '</div>';
                                tabstr += '<div class="twocol margin5T">';
                                tabstr += '<div class="right"><a name="popreply" href="javascript:void(0);" class="genbtnS" aid="' + $(this).children("CF_Guid").text().trim() + '">Reply</a></div>';
                                tabstr += '</div>';

                                $.ajax({
                                    type: "POST",
                                    async: false, //在沒有返回值之前,不會執行下一步動作
                                    url: "../Handler/GetClassForums.aspx",
                                    data: {
                                        type: "reply",
                                        cguid: $.getQueryString("guid"),
                                        guid: $(this).children("CF_Guid").text().trim(),
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
                                                    replystr += '<div class="margin5T lineheight02">' + $(this).children("CF_Content").text().trim() + '</div></div>';
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
    <style>
        /*.embed-container {
            position: relative;
            padding-bottom: 56.25%;
            height: 0; overflow: hidden;
            max-width: 100%; height: auto;
        }

        .embed-container, .embed-container object, .embed-container embed {
           width: 940px;
           height: 563px;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="CommentGuid" />
    <div class="container marT5v margin10B">
        <div id="Insidemaincontent">
            <!-- 所有網站內容放在此以下 -->
            <%--<div class="filetitlewrapper">
                <span class="filetitle font-size5">Online Courses</span>
                <span id="sp_isFinish" style="display: none" class="itemright">
                    <span class="IconCb font-size3"><i class="fa fa-check-square-o" aria-hidden="true"></i>FINISH</span>
                </span>
            </div>--%>

            <div class="paddingMVRL">

                <div class="margin10T BoxBgOb BoxRadiusB">

                    <div class="padding10ALL">
                        <div class="twocol">
                            <div class="left">
                                <div id="div_classname" class="font-size4 font-white"></div>
                            </div>
                            <div class="right">

                            </div>
                        </div>
                    </div>

                    <div id="div_embedcode" class="margin10T"></div>

                    <div class="twocol margin10T">
                        <div class="left font-normal">
                           <div id="div_teachername" class="font-size2 font-white opa6"></div>
                        </div>
                        <div class="right font-normal font-bold">
                        </div>
                    </div>
                    <div id="div_file" class="margin10T font-normal">
                    </div>
                </div>
                <!-- BoxBorderSa -->

                <%--<div class="twocol margin20T">
                    <div class="left"><span class="font-size4 font-title">Forums</span></div>
                    <div class="right"><a id="popupcomment" href="javascript:void(0);" class="genbtn">Comment</a> </div>
                </div>--%>

                <div id="forumsList"></div>
            </div>
            <!-- paddingMVRL -->

            <!-- 所有網站內容放在此以上 -->
        </div>
        <!-- Insidemaincontent -->
    </div>
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
    <script src="https://player.vimeo.com/api/player.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            var iframe = document.querySelector('iframe');
            var player = new Vimeo.Player(iframe);

            player.on('seeking', function (data) {
                //Triggered when the player starts seeking to a specific time
                console.log("切換到的時間點:", data.seconds);

                if (data.percent >= 0.9) {
                    updateMemberClass();
                }
            });

            player.on('pause', function (data) {
                //Triggered when the player starts seeking to a specific time
                console.log("暫停的時間點:", data.seconds);

                if (data.percent >= 0.9) {
                    updateMemberClass();
                }
            });

            player.on('timeupdate', function (data) {
                //Triggered when the player starts seeking to a specific time
                console.log("現在的時間點:", data.seconds);

                if (data.percent >= 0.9) {
                    updateMemberClass();
                }
            });
        });

        function updateMemberClass() {
            $.ajax({
                type: "POST",
                async: false,
                url: "../Handler/UpdateMemberClass.aspx",
                data: {
                    cguid: $.getQueryString("guid"),
                },
                error: function (xhr) {
                    alert(xhr);
                },
                success: function (data) {
                    if (data == "error") {
                        alert("Error");
                        return false;
                    }
                    if (data != null) {
                        $("#sp_isFinish").show();
                    }
                },
            });
        }
    </script>
</asp:Content>