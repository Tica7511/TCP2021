<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="assignmentview2.aspx.cs" Inherits="WebPage_assignmentview1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {
            if ($.getQueryString("guid") != '')
                getData();
            else {
                alert("Parameter error! You will be redirected back to the Online Courses");
                location.href = "classlist.aspx";
            }

            $(document).on("click", "#a_forums", function () {
                var str = confirm('You are going to the Forums now, If the answers have been saved, press confirm.');

                if (str) {
                    location.href = "assignmentbbs.aspx?guid=" + $.getQueryString("guid");
                }
            });

            $(document).on("click", "#subbtn", function () {

                var msg = ValidSubmit();
                var msg2 = ValidSubmit2();

                if (msg != '') {
                    alert('Please remember to check if all the EPs are answered.\nUnfinished：' + msg.substr(1) + '');
                }

                if (msg2 != '') {
                    alert('Please fill in the relevant standards.\nUnfilled：' + msg2.substr(1) + '');
                }

                var form = $('#form1')[0];

                // Create an FormData object
                var data = new FormData(form);

                // If you want to add an extra field for the FormData
                data.append("aguid", $.getQueryString("guid"));

                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../Handler/AddAssignmentview.aspx",
                    data: data,
                    processData: false,
                    contentType: false,
                    cache: false,
                    error: function (xhr) {
                        $("#errMsg").html("Error: " + xhr.status);
                        console.log(xhr.responseText);
                    },
                    beforeSend: function () {
                        $("#subbtn").val("Process Data...");
                        $("#subbtn").prop("disabled", true);
                    },
                    complete: function () {
                        $("#subbtn").val("Submit");
                        $("#subbtn").prop("disabled", false);
                    },
                    success: function (data) {
                        if ($(data).find("Error").length > 0) {
                            $("#errMsg").html($(data).find("Error").attr("Message"));
                        }
                        else {
                            alert($("Response", data).text());
                            location.href = "assignmentview2.aspx?guid=" + $.getQueryString("guid");
                        }
                    }
                });
            });

            $('.equalheightblock').matchHeight({
                byRow: true,//若為false,則所有區塊等高
                property: 'height',//使用min-height會出問題
                target: null,//設定等高對象:$('.sidebar')
                remove: false
            });

            $("#collapse1").collapse({
                query: 'div.collapseTitle',//收合標題樣式名
                persist: false,//是否記憶收合,需配合jquery.collapse_storage.js
                open: function () {
                    this.slideDown(100);//動畫效果
                },
                close: function () {
                    this.slideUp(100);//動畫效果
                },
            });

            $('#tab-container').easytabs({
                //defaultTab:"li:nth-child(2)",//預設開啟第二個頁籤
                updateHash: false,//停止切換頁籤跳轉到內容
            });

            $("#collapse1").trigger("open") // 預設全開啟
            //$("#collapse1").trigger("close") // 預設全關閉(default)
            $("#collapse1 div:nth-child(1) div.collapseTitle a").trigger("open") // 控制第幾個開啟

            //全部收合展開按鈕動作
            $("#collapse1open").click(function () {
                $("#collapse1").trigger("open");
                return false;
            });
            $("#collapse1close").click(function () {
                $("#collapse1").trigger("close");
                return false;
            });

            /* 共享答案 */
            $(".sharinganstb").hide();
            $(".sharingansbtn").click(function () {
                //切換子項顯示與隱藏
                $(this).next(".sharinganstb").slideToggle();
                //文字切換  ?:運算式是if else的快捷方式
                $(this).text($(this).text() == 'Show sharing answer' ? 'Hide sharing answer' : 'Show sharing answer');
            });

            //快速選單
            var backTotopBtn = $(".backTop");
            var backTotopTrigger = $("#Insidemaincontent");
            //動畫內容
            var backtopbtnMV = gsap.to(backTotopBtn, {
                scrollTrigger: {
                    trigger: backTotopTrigger,//觸發器
                    start: "top top",
                    end: "bottom bottom",
                    scrub: false,
                    toggleActions: "play none none reverse",
                    //markers: true,
                },
                duration: 0.2, x: 150
            });
            //選單滾動
            $(".submenuselect").on("change", function () {
                var selection = $(this).val();
                function defval() {
                    $(".submenuselect").val("def");
                }
                switch (selection) {
                    case "500":
                        $('.WrapperHeader').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "501":
                        $('#goto501').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "502":
                        $('#goto502').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "503":
                        $('#goto503').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "504":
                        $('#goto504').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "505":
                        $('#goto505').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "506":
                        $('#goto506').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "507":
                        $('#goto507').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "508":
                        $('#goto508').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "509":
                        $('#goto509').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "510":
                        $('#goto510').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "511":
                        $('#goto511').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "512":
                        $('#goto512').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "513":
                        $('#goto513').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "700":
                        $('#goto700').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;
                    case "702":
                        $('#goto702').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;

                    case "999":
                        $('#gotoend').animatescroll({ scrollSpeed: 1000, padding: 0 });
                        defval();
                        return false;
                        break;

                }
            });

            //tabs 20210805
            $('#tab-container').easytabs({
                defaultTab: "li:nth-child(1)",//預設開啟
                updateHash: false,//停止切換頁籤跳轉到內容
            });
        });

        function getData() {
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
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                var number = $(this).children("MA_Number").text().trim()

                                if ($(this).children("MA_Applicability").text().trim() != '')
                                    $("input[name='rda_" + number + "'][value='" + $(this).children("MA_Applicability").text().trim() + "']").prop("checked", true);
                                if ($(this).children("MA_IsShare").text().trim() != '')
                                    $("input[name='rds_" + number + "'][value='" + $(this).children("MA_IsShare").text().trim() + "']").prop("checked", true);
                                $("input[name='txtrs_" + number + "']").val($(this).children("MA_RelevantStandards").text().trim());
                                $("textarea[name='txtjf_" + number + "']").val($(this).children("MA_Justification").text().trim());

                                getAssignmentList(number);
                            });
                        }
                        else {
                            var lv1 = 0;
                            var lv2 = 0;
                            var lv3 = 0;

                            for (lv1 = 5; lv1 <= 7; lv1++) {
                                if (lv1 == 5) {
                                    for (lv2 = 1; lv2 <= 13; lv2++) {
                                        if (lv2 == 1) {
                                            for (lv3 = 1; lv3 <= 9; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 2) {
                                            for (lv3 = 1; lv3 <= 2; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 3) {
                                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 4) {
                                            for (lv3 = 1; lv3 <= 7; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 5) {
                                            for (lv3 = 1; lv3 <= 8; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 6) {
                                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 7) {
                                            for (lv3 = 1; lv3 <= 7; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 8) {
                                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 9) {
                                            for (lv3 = 1; lv3 < 2; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 10) {
                                            for (lv3 = 1; lv3 < 2; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 11) {
                                            for (lv3 = 1; lv3 <= 6; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 12) {
                                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 13) {
                                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                    }
                                }
                                if (lv1 == 7) {
                                    for (lv2 = 1; lv2 <= 2; lv2++) {
                                        if (lv2 == 1) {
                                            for (lv3 = 1; lv3 < 2; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                        if (lv2 == 2) {
                                            for (lv3 = 1; lv3 <= 4; lv3++) {
                                                getAssignmentList(lv1 + '_' + lv2 + '_' + lv3);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if ($(data).find("data_item2").length > 0) {
                            $(data).find("data_item2").each(function (i) {
                                $("#sp_Name").html($(this).children("A_Name").text().trim());
                            });
                        }
                    }
                }
            });
        }

        function getAssignmentList(number) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Handler/GetAssignment.aspx",
                data: {
                    type: "data",
                    aguid: $.getQueryString("guid"),
                    number: number,
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
                        $("#tablist_" + number + " tbody").empty();
                        var tabstr = '';
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                var applicability = ''
                                if ($(this).children("MA_Applicability").text().trim() == 'Y')
                                    applicability = 'Yes';
                                else
                                    applicability = 'No';
                                tabstr += '<tr>';
                                tabstr += '<td align="center">' + $(this).children("M_Name").text().trim() + '</td>';
                                tabstr += '<td align="center">' + applicability + '</td>';
                                tabstr += '<td>' + $(this).children("MA_RelevantStandards").text().trim() + '</td>';
                                tabstr += '<td>' + $(this).children("MA_Justification").text().trim() + '</td>';
                                tabstr += '</tr>';
                            });
                        }
                        else
                            tabstr += '<tr><td colspan="4">Query no data</td></tr>';
                        $("#tablist_" + number + " tbody").append(tabstr);
                    }
                }
            });
        }

        function ValidSubmit() {
            var msg = '';
            var lv1 = 0;
            var lv2 = 0;
            var lv3 = 0;

            for (lv1 = 5; lv1 <= 7; lv1++) {
                if (lv1 == 5) {
                    for (lv2 = 1; lv2 <= 13; lv2++) {
                        if (lv2 == 1) {
                            for (lv3 = 1; lv3 <= 9; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 2) {
                            for (lv3 = 1; lv3 <= 2; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 3) {
                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 4) {
                            for (lv3 = 1; lv3 <= 7; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 5) {
                            for (lv3 = 1; lv3 <= 8; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 6) {
                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 7) {
                            for (lv3 = 1; lv3 <= 7; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 8) {
                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 9) {
                            for (lv3 = 1; lv3 < 2; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 10) {
                            for (lv3 = 1; lv3 < 2; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 11) {
                            for (lv3 = 1; lv3 <= 6; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 12) {
                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 13) {
                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                    }
                }
                if (lv1 == 7) {
                    for (lv2 = 1; lv2 <= 2; lv2++) {
                        if (lv2 == 1) {
                            for (lv3 = 1; lv3 < 2; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 2) {
                            for (lv3 = 1; lv3 <= 4; lv3++) {
                                if (!$("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                    }
                }
            }
            return msg;
        }

        function ValidSubmit2() {
            var msg = '';
            var lv1 = 0;
            var lv2 = 0;
            var lv3 = 0;

            for (lv1 = 5; lv1 <= 7; lv1++) {
                if (lv1 == 5) {
                    for (lv2 = 1; lv2 <= 13; lv2++) {
                        if (lv2 == 1) {
                            for (lv3 = 1; lv3 <= 9; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 2) {
                            for (lv3 = 1; lv3 <= 2; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 3) {
                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 4) {
                            for (lv3 = 1; lv3 <= 7; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 5) {
                            for (lv3 = 1; lv3 <= 8; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 6) {
                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 7) {
                            for (lv3 = 1; lv3 <= 7; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 8) {
                            for (lv3 = 1; lv3 <= 5; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 9) {
                            for (lv3 = 1; lv3 < 2; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 10) {
                            for (lv3 = 1; lv3 < 2; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 11) {
                            for (lv3 = 1; lv3 <= 6; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 12) {
                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 13) {
                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                    }
                }
                if (lv1 == 7) {
                    for (lv2 = 1; lv2 <= 2; lv2++) {
                        if (lv2 == 1) {
                            for (lv3 = 1; lv3 < 2; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                        if (lv2 == 2) {
                            for (lv3 = 1; lv3 <= 4; lv3++) {
                                if (($("input[name='rda_" + lv1 + "_" + lv2 + "_" + lv3 + "']:checked").val() == 'Y') && ($("input[name='txtrs_" + lv1 + "_" + lv2 + "_" + lv3 + "']").val() == '')) {
                                    msg += "、" + lv1 + "." + lv2 + "." + lv3;
                                }
                            }
                        }
                    }
                }
            }
            return msg;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                        <span id="sp_Name" class="font-size4 font-title"></span>
                    </div>
                    <div class="right">
                        <span class="font-normal"></span>
                    </div>
                </div>

                <div id="tab-container" class='easytabH'>
                    <ul class="menubar">
                        <li><a href="#tabs1">Assignment</a></li>
                        <li><a id="a_forums" href="javascript:void(0);" target="_self" data-target="#tabs-ajax-js">Forums</a></li>
                    </ul>
                    <div class='panel-container'>
                        <div id="tabs1">

                            <div class="margin5T textright">
                                <select class="submenuselect inputex font-size1" style="width: 100px;">
                                    <option selected disabled value="def">Go To</option>
                                    <option value="500">TOP</option>
                                    <option value="501">5.1 General</option>
                                    <option value="502">5.2 Clinical Evaluation</option>
                                    <option value="503">5.3 Chemical, Physical, and Biological Properties</option>
                                    <option value="504">5.4 Sterilization and Microbial Contamination</option>
                                    <option value="505">5.5 Considerations of Environment and Conditions of Use</option>
                                    <option value="506">5.6 Protection against Electrical, Mechanical, and Thermal Risks</option>
                                    <option value="507">5.7 Active Medical Devices and IVD Medical Devices and Medical Devices Connected to Thermal Risks</option>
                                    <option value="508">5.8 Medical Devices and IVD Medical Devices that Incorporate Software or are Software as a Medical Device</option>
                                    <option value="509">5.9 Medical Devices and IVD Medical Devices with a Diagnostic or Measuring Function</option>
                                    <option value="510">5.10 Labeling</option>
                                    <option value="511">5.11 Protection against Radiation </option>
                                    <option value="512">5.12 Protection against the Risks posed by Medical Devices and IVD Medical Devices intended by the Manufacturer for use by Lay Users </option>
                                    <option value="513">5.13 Medical Devices and IVD Medical Devices Incorporating Materials of Biological Origin </option>
                                    <option value="700">7.0 Essential Principles Applicable to IVD Medical Devices 7.1 Chemical, Physical and Biological Properties</option>
                                    <option value="702">7.2 Performance Characteristics </option>
                                    <option value="999">END</option>
                                </select>
                                <a href="<%= ResolveUrl("~/doc/Assignment2_0825.zip") %>" target="_blank" class="genbtnS">Download</a>
                            </div>

                            <!-- 5.1 start -->
                            <div id="goto501" class="font-size3 font-black font-bold margin10T">
                                5.1 General
                            </div>
                            <div>
                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.1 Medical devices and IVD medical devices should achieve the performance intended by their manufacturer and should be designed and manufactured in such a way that, during intended conditions of use, they are suitable for their intended purpose. They should be safe and perform as intended, should have risks that are acceptable when weighed against the benefits to the patient, and should not compromise the clinical condition or the safety of patients, or the safety and health of users or, where applicable, other persons.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.2 Manufacturers should establish, implement, document and maintain a risk management system to ensure the ongoing quality, safety and performance of the medical device and IVD medical device. Risk management should be understood as a continuous iterative process throughout the entire lifecycle of a medical device and IVD medical device, requiring regular systematic updating. In carrying out risk management manufacturers should:<br>
                                    a) establish and document a risk management plan covering each medical device and IVD medical device;<br>
                                    b) identify and analyze the known and foreseeable hazards associated with each medical device and IVD medical device;<br>
                                    c) estimate and evaluate the risks associated with, and occurring during, the intended use and during reasonably foreseeable misuse;<br>
                                    d) eliminate or control the risks referred to in point (c) in accordance with the requirements of points 5.1.3 and 5.1.4 below;<br>
                                    e) evaluate the impact of information from the production and postproduction phases, on the overall risk, benefit-risk determination and risk acceptability. This evaluation should include the impact of the presence of previously unrecognized hazards or hazardous situations, the acceptability of the estimated risk(s) arising from a hazardous situation, and changes to the generally acknowledged state of the art.<br>
                                    f) based on the evaluation of the impact of the information referred to in point (e), if necessary amend control measures in line with the requirements of points 5.1.3 and 5.1.4 below.<br>
                                    5.1.2 Manufacturers should establish, implement, document and maintain a risk management system to ensure the ongoing quality, safety and performance of the medical device and IVD medical device. Risk management should be understood as a continuous iterative process throughout the entire lifecycle of a medical device and IVD medical device, requiring regular systematic updating. In carrying out risk management manufacturers should:<br>
                                    a) establish and document a risk management plan covering each medical device and IVD medical device;<br>
                                    b) identify and analyze the known and foreseeable hazards associated with each medical device and IVD medical device;<br>
                                    c) estimate and evaluate the risks associated with, and occurring during, the intended use and during reasonably foreseeable misuse;<br>
                                    d) eliminate or control the risks referred to in point (c) in accordance with the requirements of points 5.1.3 and 5.1.4 below;<br>
                                    e) evaluate the impact of information from the production and postproduction phases, on the overall risk, benefit-risk determination and risk acceptability. This evaluation should include the impact of the presence of previously unrecognized hazards or hazardous situations, the acceptability of the estimated risk(s) arising from a hazardous situation, and changes to the generally acknowledged state of the art.<br>
                                    f) based on the evaluation of the impact of the information referred to in point (e), if necessary amend control measures in line with the requirements of points 5.1.3 and 5.1.4 below.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.3 Risk control measures adopted by manufacturers for the design and manufacture of the medical device and IVD medical device should conform to safety principles, taking account of the generally acknowledged state of the art. When risk reduction is required, manufacturers should control risks so that the residual risk associated with each hazard as well as the overall residual risk is judged acceptable. In selecting the most appropriate solutions, manufacturers should, in the following order of priority:<br>
                                    a) eliminate or appropriately reduce risks through safe design and manufacture;<br>
                                    b) where appropriate, take adequate protection measures, including alarms if necessary, in relation to risks that cannot be eliminated; and<br>
                                    c) provide information for safety (warnings/precautions/contra-indications) and, where appropriate, training to users.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.4 The manufacturer should inform users of any relevant residual risks.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.5 In eliminating or reducing risks related to use, the manufacturer should:<br>
                                    a) appropriately reduce the risks related to the features of the medical device and IVD medical device and the environment in which the medical device and IVD medical device are intended to be used (e.g. ergonomic/usability features, tolerance to dust and humidity) and<br>
                                    b) give consideration to the technical knowledge, experience, education, training and use environment and, where applicable, the medical and physical conditions of intended users.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.6 The characteristics and performance of a medical device and IVD medical device should not be adversely affected to such a degree that the health or safety of the patient and the user and, where applicable, of other persons are compromised during the expected life of the device, as specified by the manufacturer, when the medical device and IVD medical device is subjected to the stresses which can occur during normal conditions of use and has been properly maintained and calibrated (if applicable) in accordance with the manufacturer's instructions.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_6" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_6" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_6" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_6" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_6" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_6" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_6" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.7 Medical devices and IVD medical devices should be designed, manufactured and packaged in such a way that their characteristics and performance, including the integrity and cleanliness of the product and when used in accordance with the intended use, are not adversely affected by transport and storage (for example, through shock, vibrations, and fluctuations of temperature and humidity), taking account of the instructions and information provided by the manufacturer. The performance, safety, and sterility of the medical device and IVD medical device should be sufficiently maintained throughout any shelf-life specified by the manufacturer.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_7" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_7" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_7" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_7" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_7" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_7" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_7" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.8 Medical devices and IVD medical devices should have acceptable stability during their shelf-life, during the time of use after being opened (for IVDs, including after being installed in the instrument), and during transportation or dispatch (for IVDs, including samples).
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_8" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_8" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_8" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_8" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_8" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_8" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_8" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.1.9 All known and foreseeable risks, and any undesirable side-effects, should be minimized and be acceptable when weighed against the evaluated benefits arising from the achieved performance of the device during intended conditions of use taking into account the generally acknowledged state of the art.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_1_9" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_1_9" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_1_9" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_1_9" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_1_9" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_1_9" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_1_9" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.1 end -->

                            <div id="goto502" class="font-size3 font-black font-bold margin20T">
                                5.2 Clinical Evaluation
                            </div>
                            <!-- 5.2 start -->
                            <div>
                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.2.1 Where appropriate and depending on jurisdictional requirements, a clinical evaluation may be required. A clinical evaluation should assess clinical data to establish that a favorable benefit-risk determination exists for the medical device and IVD medical device in the form of one or more of the following:<br>
                                    <i class="fa fa-arrow-right" aria-hidden="true"></i>clinical investigation reports (for IVDs, clinical performance evaluation reports)<br>
                                    <i class="fa fa-arrow-right" aria-hidden="true"></i>published scientific literature/reviews<br>
                                    <i class="fa fa-arrow-right" aria-hidden="true"></i>clinical experience
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_2_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_2_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_2_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_2_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_2_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_2_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_2_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.2.2 Clinical investigations should be conducted in accordance with the ethical principles that have their origin in the Declaration of Helsinki. These principles protect the rights, safety and well-being of human subjects, which are the most important considerations and shall prevail over interests of science and society. These principles shall be understood, observed, and applied at every step in the clinical investigation. In addition, some countries may have specific regulatory requirements for pre-study protocol review, informed consent, and for IVD medical devices, use of leftover specimens.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_2_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_2_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_2_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_2_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_2_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_2_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_2_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.2 end -->

                            <div id="goto503" class="font-size3 font-black font-bold margin20T">
                                5.3 Chemical, Physical, and Biological Properties
                            </div>
                            <!-- 5.3 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.3.1 Regarding chemical, physical, and biological properties of a medical device and IVD medical device, particular attention should be paid to the following:<br>
                                    a) the choice of materials and substances used, particularly with respect to:<br>
                                    - toxicity;<br>
                                    - biocompatibility; and<br>
                                    -flammability;<br>
                                    b) the impact of processes on material properties;<br>
                                    c) where appropriate, the results of biophysical or modelling research whose validity of which has been demonstrated beforehand;<br>
                                    d) the mechanical properties of the materials used, reflecting, where appropriate, matters such as strength, ductility, fracture resistance, wear resistance and fatigue resistance;<br>
                                    e) surface properties; and<br>
                                    f) the confirmation that the device meets any defined chemical and/or physical specifications.<br>
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_3_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_3_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_3_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_3_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_3_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_3_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_3_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.3.2 Medical devices and IVD medical devices should be designed, manufactured and packaged in such a way as to minimize the risk posed by contaminants and residues to users and patients, taking account of the intended purpose of the medical device and IVD medical device, and to the persons involved in the transport, storage and use of the medical device and IVD medical device. Particular attention should be paid to tissues of users and patients exposed to those contaminants and residues and to the duration and frequency of exposure.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_3_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_3_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_3_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_3_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_3_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_3_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_3_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.3.3 The medical device and IVD medical device should be designed and manufactured in such a way as to appropriately reduce the risks posed by substance egress (including leaching and/or evaporation), degradation products, processing residues, etc. Special attention should be given to leaking or leaching of substances, which are carcinogenic, mutagenic or toxic to reproduction.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_3_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_3_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_3_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_3_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_3_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_3_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_3_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.3.4 The medical device and IVD medical device should be designed and manufactured in such a way as to appropriately reduce the risks posed by the unintentional ingress of substances into the device, taking into account the medical device and IVD medical device and the nature of the environment in which it is intended to be used.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_3_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_3_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_3_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_3_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_3_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_3_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_3_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.3.5 Medical devices and IVD medical devices and their manufacturing processes should be designed in such a way as to eliminate or to appropriately reduce the risk of infection to users and all other persons who may come in contact with the medical device and IVD medical device. The design should:<br>
                                    a) allow for easy and safe handling;<br>
                                    b) appropriately reduce any microbial leakage from the medical device and IVD medical device and/or microbial exposure during use;<br>
                                    c) prevent microbial contamination of the medical device and IVD medical device or its content (e.g., specimens); and/or<br>
                                    d) appropriately reduce the risks from unintended exposure (e.g., cuts and pricks (such as needle stick injuries), eye splashes, etc.).<br>
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_3_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_3_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_3_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_3_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_3_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_3_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_3_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.3 end -->

                            <div id="goto504" class="font-size3 font-black font-bold margin20T">
                                5.4 Sterilization and Microbial Contamination
                            </div>
                            <!-- 5.4 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.4.1 Where necessary, medical devices and IVD medical devices should be designed to facilitate their safe cleaning, disinfection, sterilization, and re-sterilization by the user, as appropriate.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_4_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_4_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_4_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_4_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_4_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_4_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_4_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.4.2 Medical devices and IVD medical devices labeled as having a specific microbial state should be designed, manufactured and packaged to ensure that they remain in that state when placed on the market and remain so under the transport and storage conditions specified by the manufacturer.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_4_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_4_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_4_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_4_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_4_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_4_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_4_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.4.3 Medical devices and IVD medical devices, delivered in a sterile state should be designed, manufactured and packaged in accordance with appropriate procedures, to ensure that they are sterile when placed on the market and that, unless the packaging which is intended to maintain their sterile condition is damaged, they remain sterile, under the transport and storage conditions specified by the manufacturer, until that packaging is opened at the point of use. It should be ensured that the integrity of that packaging is clearly evident to the final user (for example, through the use of tamper-proof packaging).
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_4_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_4_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_4_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_4_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_4_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_4_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_4_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.4.4 Medical devices and IVD medical devices labelled as sterile should be processed, manufactured, packaged, and sterilized by means of appropriate, validated methods. The shelf-life of these medical devices and IVD medical devices should be determined by validated methods.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_4_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_4_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_4_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_4_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_4_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_4_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_4_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.4.5 Medical devices and IVD medical devices intended to be sterilized, either by the manufacturer or user, should be manufactured and packaged in appropriate and controlled conditions and facilities.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_4_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_4_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_4_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_4_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_4_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_4_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_4_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.4.6 Where the medical devices and IVD medical devices are provided non-sterile and are intended to be sterilized prior to use:<br>
                                    a) the packaging system should minimize the risk of microbial contamination and should be suitable taking account of the method of sterilization indicated by the manufacturer; and<br>
                                    b) the method of sterilization indicated by the manufacturer should be validated.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_4_6" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_4_6" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_4_6" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_4_6" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_4_6" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_4_6" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_4_6" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.4.7 For medical devices and IVD medical devices placed on the market in both sterile and non-sterile conditions, the label should clearly distinguish between these versions.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_4_7" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_4_7" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_4_7" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_4_7" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_4_7" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_4_7" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_4_7" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.4 end -->

                            <div id="goto505" class="font-size3 font-black font-bold margin20T">
                                5.5 Considerations of Environment and Conditions of Use
                            </div>
                            <!-- 5.5 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.1 If the medical device or IVD medical device is intended to be used in combination with other medical devices or IVD medical devices and/or equipment, the whole combination, including the connection system should be safe and should not impair the specified performance of the medical device or IVD medical device. Any known restrictions on use applying to such combinations should be indicated on the label and/or in the instructions for use. Any connections which the user has to handle, such as fluid, gas transfer, electrical or mechanical coupling, should be designed and manufactured in such a way as to remove or appropriately reduce all possible risks, including incorrect connections or safety hazards.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.2 Medical devices and IVD medical devices should be designed and manufactured in consideration of the intended environment and conditions of use, and in such a way as to remove or appropriately reduce the:<br>
                                    a) risks of injury to the users or other persons in connection with its physical and ergonomic/usability features;<br>
                                    b) risks of user error due to the design of the medical device or IVD medical device user interface, ergonomic/usability features, and the environment in which the medical device or IVD medical device is intended to be used;<br>
                                    c) risks connected with reasonably foreseeable external influences or environmental conditions, such as magnetic fields, external electrical and electromagnetic effects, electrostatic discharge, radiation associated with diagnostic or therapeutic procedures, pressure, humidity, temperature, and/or variations in pressure and acceleration;<br>
                                    d) risks associated with the use of the medical device or IVD medical device when it comes into contact with materials, liquids, and substances, including gases, to which it is exposed during intended conditions of use;<br>
                                    e) risks associated with the possible negative interaction between software and the information technology (IT) environment within which it operates and interacts;<br>
                                    f) environmental risks from unexpected egress of substances from the medical device or IVD medical device during use, taking into account the medical device or IVD medical device and the nature of the environment in which it is intended to be used;<br>
                                    g) the risk of incorrect identification of specimens/samples/data and the risk of erroneous results due to, for example, confusing color and/or numeric coding on specimen receptacles, removable parts and/or accessories used to perform the analysis, test, or assay as intended; and<br>
                                    h) the risks of interference with other medical devices or IVD medical devices normally used in diagnosis, monitoring or treatment.<br>
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.3 Medical devices and IVD medical devices should be designed and manufactured in such a way as to remove or appropriately reduce the risks of fire or explosion during normal use and in single fault condition. Particular attention should be paid to medical devices and IVD medical devices whose intended use includes exposure to or in association with flammable or explosive substances or substances which could cause combustion.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.4 Medical devices and IVD medical devices should be designed and manufactured in such a way that adjustment, calibration, and maintenance can be done safely and effectively. Specifically,<br>
                                    a) When maintenance is not possible, for example, with implants, the risks from ageing of materials, etc. should be appropriately reduced.<br>
                                    b) When adjustment and calibration are not possible, for example, with certain kinds of thermometers, the risks from loss of accuracy of any measuring or control mechanism are appropriately reduced.<br>
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.5 Medical devices and IVD medical devices that are intended to be operated together with other medical devices or IVD medical devices or products should be designed and manufactured in such a way that the interoperability and compatibility are reliable and safe.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.6 Medical devices and IVD medical devices should be designed and manufactured in such a way as to appropriately reduce the risk of unauthorized access that could hamper the device from functioning as intended or impose a safety concern.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_6" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_6" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_6" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_6" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_6" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_6" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_6" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.7 Any measurement, monitoring or display scale functions of medical devices and IVD medical devices should be designed and manufactured in line with ergonomic/usability principles, taking account of the intended purpose, users and the environmental conditions in which the medical devices and IVD medical devices are intended to be used.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_7" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_7" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_7" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_7" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_7" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_7" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_7" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.5.8 Medical devices and IVD medical devices should be designed and manufactured in such a way as to facilitate their safe disposal or recycling and the safe disposal or recycling of related waste substances by the user, patient or other person. The instructions for use should identify safe disposal or recycling procedures and measures.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_5_8" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_5_8" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_5_8" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_5_8" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_5_8" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_5_8" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_5_8" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.5 end -->

                            <div id="goto506" class="font-size3 font-black font-bold margin20T">
                                5.6 Protection against Electrical, Mechanical, and Thermal Risks
                            </div>
                            <!-- 5.6 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.6.1 Medical devices and IVD medical devices should be designed and manufactured in such a way as to protect users against mechanical risks connected with, for example, resistance to movement, instability, and moving parts.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_6_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_6_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_6_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_6_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_6_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_6_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_6_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.6.2 Medical devices and IVD medical devices should be designed and manufactured in such a way as to appropriately reduce the risks arising from vibration generated by the medical devices or IVD medical devices, taking account of technical progress and of the means available for limiting vibrations, particularly at source, unless the vibrations are part of the specified performance.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_6_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_6_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_6_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_6_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_6_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_6_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_6_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.6.3 Medical devices and IVD medical devices should be designed and manufactured in such a way as to appropriately reduce the risks arising from the noise emitted, taking account of technical progress and of the means available to reduce noise, particularly at source, unless the noise emitted is part of the specified performance.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_6_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_6_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_6_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_6_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_6_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_6_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_6_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.6.4 Medical devices and IVD medical devices should be designed and manufactured in such a way as to appropriately reduce the risk related to the failure of any parts within the device that are intended to be connected or reconnected before or during use.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_6_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_6_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_6_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_6_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_6_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_6_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_6_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.6.5 Accessible parts of medical devices and IVD medical devices (excluding the parts or areas intended to supply heat or reach given temperatures) and their surroundings should not attain potentially dangerous temperatures under normal use.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_6_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_6_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_6_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_6_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_6_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_6_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_6_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.6 end -->

                            <div id="goto507" class="font-size3 font-black font-bold margin20T">
                                5.7 Active Medical Devices and IVD Medical Devices and Medical Devices Connected to Thermal Risks
                            </div>
                            <!-- 5.7 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.7.1 For active medical devices and IVD medical devices, in the event of a single fault condition, appropriate means should be adopted to eliminate or appropriately reduce consequent risks.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_7_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_7_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_7_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_7_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_7_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_7_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_7_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.7.2 Medical devices and IVD medical devices where the safety of the patient depends on an internal power supply should be equipped with a means of determining the state of the power supply and an appropriate warning or indication for when the capacity of the power supply becomes critical.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_7_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_7_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_7_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_7_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_7_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_7_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_7_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.7.3 Medical devices and IVD medical devices where the safety of the patient depends on an external power supply should include an alarm system to signal any power failure.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_7_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_7_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_7_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_7_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_7_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_7_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_7_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.7.4 Medical devices and IVD medical devices intended to monitor one or more clinical parameters of a patient should be equipped with appropriate alarm systems to alert the user of situations which could lead to death or severe deterioration of the patient's state of health.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_7_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_7_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_7_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_7_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_7_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_7_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_7_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.7.5 Medical devices and IVD medical devices should be designed and manufactured in such a way as to appropriately reduce the risks of creating electromagnetic interference which could impair the operation of any devices or equipment in the intended environment.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_7_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_7_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_7_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_7_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_7_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_7_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_7_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.7.6 Medical devices and IVD medical devices should be designed and manufactured in such a way as to provide a level of intrinsic immunity to electromagnetic interference such that is adequate to enable them to operate as intended.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_7_6" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_7_6" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_7_6" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_7_6" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_7_6" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_7_6" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_7_6" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.7.7 Medical devices and IVD medical devices should be designed and manufactured in such a way as to appropriately reduce the risk of accidental electric shocks to the user or any other person, both during normal use of the medical device or IVD medical device and in the event of a single fault condition in the medical device or IVD medical device, provided the medical device or IVD medical device is installed and maintained as indicated by the manufacturer.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_7_7" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_7_7" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_7_7" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_7_7" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_7_7" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_7_7" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_7_7" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.7 end -->

                            <div id="goto508" class="font-size3 font-black font-bold margin20T">
                                5.8 Medical Devices and IVD Medical Devices that Incorporate Software or are Software as a Medical Device
                            </div>
                            <!-- 5.8 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.8.1 Medical devices and IVD medical devices that incorporate electronic programmable systems, including software, or are software as a medical device, should be designed to ensure accuracy, reliability, precision, safety, and performance in line with their intended use. In the event of a single fault condition, appropriate means should be adopted to eliminate or appropriately reduce consequent risks or impairment of performance.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_8_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_8_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_8_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_8_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_8_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_8_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_8_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.8.2 For medical devices and IVD medical devices that incorporate software or are software as a medical device, the software should be developed, manufactured and maintained in accordance with the state of the art taking into account the principles of development life cycle (e.g., rapid development cycles, frequent changes, the cumulative effect of changes), risk management (e.g., changes to system, environment, and data), including information security (e.g., safely implement updates), verification and validation (e.g., change management process).
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_8_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_8_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_8_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_8_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_8_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_8_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_8_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.8.3 Software that is intended to be used in combination with mobile computing platforms should be designed and developed taking into account the platform itself (e.g. size and contrast ratio of the screen, connectivity, memory, etc.) and the external factors related to their use (varying environment as regards level of light or noise).
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_8_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_8_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_8_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_8_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_8_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_8_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_8_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.8.4 Manufacturers should set out minimum requirements concerning hardware, IT networks characteristics and IT security measures, including protection against unauthorized access, necessary to run the software as intended.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_8_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_8_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_8_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_8_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_8_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_8_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_8_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.8.5 The medical device and IVD medical device should be designed, manufactured and maintained in such a way as to provide an adequate level of cybersecurity against attempts to gain unauthorized access.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_8_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_8_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_8_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_8_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_8_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_8_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_8_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.8 end -->

                            <div id="goto509" class="font-size3 font-black font-bold margin20T">
                                5.9 Medical Devices and IVD Medical Devices with a Diagnostic or Measuring Function
                            </div>
                            <!-- 5.9 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.9.1 Medical devices and IVD medical devices with a diagnostic or measuring (including monitoring) function should be designed and manufactured in such a way as to provide, among other performance characteristics, sufficient accuracy, precision and stability for their intended purpose, based on appropriate scientific and technical methods.<br>
                                    a) Where applicable, the limits of accuracy should be indicated by the manufacturer.<br>
                                    b) Whenever possible, values expressed numerically should be in commonly accepted, standardized units, and understood by users of the medical device or IVD medical device. While generally supporting the convergence on the global use of internationally standardized measurement units, considerations of safety, user familiarity and established clinical practice may justify the use of other recognized measurement units.<br>
                                    c) The function of the controls and indicators should be clearly specified on the medical device and IVD medical device. Where a medical device or IVD medical device bears instructions required for its operation or indicates operating or adjustment parameters by means of a visual system, such information should be understandable to the user and, as appropriate, the patient.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_9_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_9_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_9_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_9_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_9_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_9_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_9_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.9 end -->

                            <div id="goto510" class="font-size3 font-black font-bold margin20T">
                                5.10 Labeling
                            </div>
                            <!-- 5.10 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    The following principle is a general recommendation for labeling. For additional guidance on the contents of the labeling, please refer to IMDRF/GRRP WG/N52.<br>
                                    5.10.1 Medical devices and IVD medical devices should be accompanied by the information needed to distinctively identify the medical device or IVD medical device and its manufacturer. Each medical device and IVD medical device should also be accompanied by, or direct the user to any safety and performance information relevant to the user, or any other person, as appropriate. Such information may appear on the medical device or IVD medical device itself, on the packaging or in the instructions for use, or be readily accessible through electronic means (such as a website), and should be easily understood by the intended user.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_10_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_10_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_10_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_10_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_10_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_10_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_10_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.10 end -->

                            <div id="goto511" class="font-size3 font-black font-bold margin20T">
                                5.11 Protection against Radiation
                            </div>
                            <!-- 5.11 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.11.1 Medical devices and IVD medical devices should be designed, manufactured and packaged in such a way that exposure of users, other persons, or where appropriate, patients, to radiation is appropriately reduced in a manner that is compatible with the intended purpose, whilst not restricting the application of appropriate specified levels for diagnostic and therapeutic purposes.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_11_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_11_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_11_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_11_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_11_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_11_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_11_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.11.2 The operating instructions for medical devices and IVD medical devices emitting hazardous or potentially hazardous radiation should contain detailed information as to the nature of the emitted radiation, the means of protecting the users, other persons, or where appropriate, patients, and ways of avoiding misuse and of appropriately reducing the risks inherent to transport, storage and installation.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_11_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_11_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_11_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_11_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_11_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_11_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_11_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.11.3 Where medical devices and IVD medical devices are intended to emit hazardous, or potentially hazardous, radiation, they should be fitted, where possible, with visual displays and/or audible warnings of such emissions.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_11_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_11_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_11_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_11_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_11_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_11_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_11_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.11.4 Medical devices and IVD medical devices should be designed and manufactured in such a way that that the exposure of users, other persons, or where appropriate, patients, to the emission of unintended, stray or scattered radiation is appropriately reduced. Where possible and appropriate, methods should be selected which reduce the exposure to radiation of users, other persons, or where appropriate, patients, who may be affected.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_11_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_11_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_11_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_11_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_11_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_11_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_11_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.11.5 For medical devices and IVD medical devices emitting hazardous or potentially hazardous radiation and that require installation, information regarding the acceptance and performance testing, the acceptance criteria, and the maintenance procedure should be specified in the operating instructions.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_11_5" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_11_5" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_11_5" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_11_5" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_11_5" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_11_5" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_11_5" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.11.6 Where medical devices and IVD medical devices are intended to emit hazardous, or potentially hazardous, radiation, accessible to user, they should be designed and manufactured in such a way as to ensure that the quantity, geometry, energy distribution (or quality), and other key characteristics of the radiation emitted can be appropriately controlled and adjusted and, where appropriate, monitored during use. Such medical devices and IVD medical devices should be designed and manufactured to ensure reproducibility of relevant variable parameters within an acceptable tolerance.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_11_6" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_11_6" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_11_6" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_11_6" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_11_6" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_11_6" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_11_6" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.11 end -->

                            <div id="goto512" class="font-size3 font-black font-bold margin20T">
                                5.12 Protection against the Risks posed by Medical Devices and IVD Medical Devices intended by the Manufacturer for use by Lay Users
                            </div>
                            <!-- 5.12 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.12.1 Medical devices and IVD medical devices for use by lay users (such as self-testing or near-patient testing intended for use by lay users) should be designed and manufactured in such a way that they perform appropriately for their intended use/purpose taking into account the skills and the means available to lay users and the influence resulting from variation that can be reasonably anticipated in the lay user's technique and environment. The information and instructions provided by the manufacturer should be easy for the lay user to understand and apply when using the medical device or IVD medical device and interpreting the results.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_12_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_12_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_12_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_12_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_12_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_12_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_12_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.12.2 Medical devices and IVD medical devices for use by lay users (such as self-testing or near-patient testing intended for use by lay users) should be designed and manufactured in such a way as to:<br>
                                    a) ensure that the medical device and IVD medical device can be used safely and accurately by the intended user per instructions for use. When the risks associated with the instructions for use cannot be mitigated to appropriate levels, these risks may be mitigated through training.<br>
                                    b) appropriately reduce the risk of error by the intended user in the handling of the medical device or IVD medical device and, if applicable, in the interpretation of the results.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_12_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_12_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_12_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_12_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_12_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_12_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_12_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.12.3 Medical devices and IVD medical devices for use by lay users (such as self-testing or near-patient testing intended for use by lay users) should, where appropriate, include means by which the lay user:<br>
                                    a) can verify that, at the time of use, the medical device or IVD medical device will perform as intended by the manufacturer, and<br>
                                    b) is warned if the medical device or IVD medical device has failed to operate as intended or to provide a valid result.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_12_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_12_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_12_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_12_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_12_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_12_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_12_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.12 end -->

                            <div id="goto513" class="font-size3 font-black font-bold margin20T">
                                5.13 Medical Devices and IVD Medical Devices Incorporating Materials of Biological Origin
                            </div>
                            <!-- 5.13 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.13.1 For medical devices and IVD medical devices that include tissues, cells, or substances of animal, plant, or bacterial origin or their derivatives, which are non-viable or rendered non-viable the following should apply:<br>
                                    a) where appropriate, taking into account the animal species, tissues and cells of animal origin, or their derivatives, should originate from animals that have been subjected to veterinary controls that are adapted to the intended use of the tissues.<br>
                                    Information on the geographical origin of the animals may need to be retained by manufacturers depending on jurisdictional requirements.<br>
                                    b) sourcing, processing, preservation, testing and handling of tissues, cells and substances of animal origin, or their derivatives, should be carried out so as to provide safety for patients, users and, where applicable, other persons. In particular, safety with regards to viruses and other transmissible agents should be addressed by implementation of validated state of the art methods of elimination or inactivation in the course of the manufacturing process, except when the use of such methods would lead to unacceptable degradation compromising the medical device or IVD medical device.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_13_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_13_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_13_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_13_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_13_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_13_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_13_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.13.2 For Regulatory Authorities, which regulate products manufactured utilizing tissues, cells, or substances of human origin or their derivatives as medical devices or IVD medical devices, the following should apply:<br>
                                    a) donation, procurement and testing of the tissues and cells should be done in accordance with jurisdictional requirements; and<br>
                                    b) processing, preservation and any other handling of those tissues and cells or their derivatives should be carried out so as to provide safety for patients, users and, where applicable, other persons. In particular, safety with regard to viruses and other transmissible agents should be addressed by appropriate methods of sourcing and by implementation of validated state of the art methods of elimination or inactivation in the course of the manufacturing process.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_13_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_13_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_13_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_13_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_13_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_13_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_13_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    5.13.3 For medical devices and IVD medical devices manufactured utilizing biological substances other than those referred to in Sections 5.13.1 and 5.13.2 (for example, materials of plant or bacterial origin), the processing, preservation, testing and handling of those substances should be carried out so as to provide safety for patients, users and, where applicable, other persons, including in the waste disposal chain. In particular, safety with regards to viruses and other transmissible agents should be addressed by appropriate methods of sourcing and by implementation of validated state of the art methods of elimination or inactivation in the course of the manufacturing process. Other requirements can apply in specific regulatory jurisdictions.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_5_13_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_5_13_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_5_13_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_5_13_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_5_13_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_5_13_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_5_13_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 5.13 end -->

                            <div id="goto700" class="font-size3 font-black font-bold margin20T">
                                7.0 Essential Principles Applicable to IVD Medical Devices<br>
                                7.1 Chemical, Physical and Biological Properties
                            </div>
                            <!-- 7.0 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    7.1.1 With regards to chemical, physical, and biological properties for IVD medical devices, attention should be paid to the possibility of impairment of analytical performance due to physical and/or chemical incompatibility between the materials used and the specimens, analyte or marker to be detected and measured (such as biological tissues, cells, body fluids and micro-organisms), taking account of the intended purpose of the device.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_7_1_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_7_1_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_7_1_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_7_1_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_7_1_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_7_1_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_7_1_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 7.0 end -->

                            <div id="goto702" class="font-size3 font-black font-bold margin20T">
                                7.2 Performance Characteristics
                            </div>
                            <!-- 7.2 start -->
                            <div>

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    7.2.1 IVD medical devices should achieve the analytical and clinical performances, as stated by the manufacturer that are applicable to the intended use/purpose, taking into account the intended patient population, the intended user, and the setting of intended use. These performance characteristics should be established using suitable, validated, state of the art methods. For example:<br>
                                    a) The analytical performance can include, but is not limited to,<br>
                                    a. Traceability of calibrators and controls<br>
                                    b. Accuracy of measurement (trueness and precision)<br>
                                    c. Analytical sensitivity/Limit of detection<br>
                                    d. Analytical specificity<br>
                                    e. Measuring interval/range<br>
                                    f. Specimen stability<br>
                                    b) The clinical performance, for example diagnostic/clinical sensitivity, diagnostic/clinical specificity, positive predictive value, negative predictive value, likelihood ratios, and expected values in normal and affected populations.<br>
                                    c) Validated control procedures to assure the user that the IVD medical device is performing as intended, and therefore the results are suitable for the intended use.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_7_2_1" value="Y" type="radio">
                                                Yes
                                    <input name="rda_7_2_1" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_7_2_1" value="Y" type="radio">
                                                Yes
                                    <input name="rds_7_2_1" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_7_2_1" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_7_2_1" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_7_2_1" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    7.2.2 Where the performance of an IVD medical device depends on the use of calibrators or control materials, the traceability of values assigned to such calibrators or control materials should be ensured through available reference measurement procedures or available reference materials of a higher order.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_7_2_2" value="Y" type="radio">
                                                Yes
                                    <input name="rda_7_2_2" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_7_2_2" value="Y" type="radio">
                                                Yes
                                    <input name="rds_7_2_2" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_7_2_2" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_7_2_2" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_7_2_2" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    7.2.3 Wherever possible, values expressed numerically should be in commonly accepted, standardized units and understood by the users of the IVD medical device.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_7_2_3" value="Y" type="radio">
                                                Yes
                                    <input name="rda_7_2_3" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_7_2_3" value="Y" type="radio">
                                                Yes
                                    <input name="rds_7_2_3" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_7_2_3" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_7_2_3" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_7_2_3" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->

                                <!-- in start -->
                                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                                    7.2.4 The performance characteristics of the IVD medical device should be evaluated according to the intended use statement which may include the following:<br>
                                    a) intended user, for example, lay user, laboratory professional;<br>
                                    b) intended use environment, for example, patient home, emergency units, ambulances, healthcare centers, laboratory;<br>
                                    c) relevant populations, for example, pediatric, adult, pregnant women, individuals with signs and symptoms of a specific disease, patients undergoing differentia diagnosis, blood donors, etc. Populations evaluated should represent, where appropriate, ethnically, gender, and genetically diverse populations so as to be representative of the population(s) where the device is intended to be marketed. For infectious diseases, it is recommended that the populations selected have similar prevalence rates.
                                </div>
                                <!-- BoxRadiusAu -->
                                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                                    <div class="tableStyle width100">
                                        <div class="trStyle">
                                            <div class="tdStyle width50">
                                                <span class="font-title">Applicability:</span>
                                                <input name="rda_7_2_4" value="Y" type="radio">
                                                Yes
                                    <input name="rda_7_2_4" value="N" type="radio">
                                                No
                                            </div>
                                            <div class="tdStyle">
                                                <span class="font-title">Sharing my answer:</span>
                                                <input name="rds_7_2_4" value="Y" type="radio">
                                                Yes
                                    <input name="rds_7_2_4" value="N" type="radio">
                                                No
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <input name="txtrs_7_2_4" type="text" class="inputex width100" placeholder="Relevant Standards">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="tableStyle width100 margin5T">
                                        <div class="trStyle">
                                            <div class="tdStyle">
                                                <textarea name="txtjf_7_2_4" rows="3" cols="" class="inputex width100" placeholder="Justification(optional)"></textarea>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="sharingansbtn">Show sharing answer</div>
                                    <div class="sharinganstb stripeMeCS margin5T">
                                        <table id="tablist_7_2_4" width="100%">
                                            <thead>
                                                <tr>
                                                    <th>User</th>
                                                    <th width="100">Applicability</th>
                                                    <th>Relevant Standards</th>
                                                    <th width="40%">Justification</th>
                                                </tr>
                                            </thead>
                                            <tbody></tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- BoxRadiusAd -->
                                <!-- in end -->
                            </div>
                            <!-- 7.2 end -->

                            <div id="gotoend" class="twocol margin10TB">
                                <div class="right"><a id="subbtn" href="javascript:void(0);" class="genbtn">Submit</a> </div>
                            </div>
                        </div>
                        <!-- tabs1 -->
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

    <div class="backTop">
        <select class="submenuselect inputex">
            <option selected disabled value="def">Go To</option>
            <option value="500">TOP</option>
            <option value="501">5.1</option>
            <option value="502">5.2</option>
            <option value="503">5.3</option>
            <option value="504">5.4</option>
            <option value="505">5.5</option>
            <option value="506">5.6</option>
            <option value="507">5.7</option>
            <option value="508">5.8</option>
            <option value="509">5.9</option>
            <option value="510">5.10</option>
            <option value="511">5.11</option>
            <option value="512">5.12</option>
            <option value="513">5.13</option>
            <option value="700">7.0</option>
            <option value="702">7.2</option>
            <option value="999">END</option>
        </select>
    </div>
</asp:Content>