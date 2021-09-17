<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="questionnaires.aspx.cs" Inherits="WebPage_questionnaires" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            getData();

            //多選限制最多兩個選擇
            $(document).on("click", "input[name='rd_2_1']", function () {
                $("input[name='rd_2_1']").attr('disabled', true);
                if ($("input[name='rd_2_1']:checked").length >= 2) {
                    $("input[name='rd_2_1']:checked").attr('disabled', false);
                }
                else {
                    $("input[name='rd_2_1']").attr('disabled', false);
                }
            });

            //儲存
            $(document).on("click", "#subbtn", function () {
                var msg = CheckOption();

                if (msg != '') {
                    alert(msg);
                    return;
                }

                var form = $('#form1')[0];

                // Create an FormData object
                var data = new FormData(form);

                $.ajax({
                    type: "POST",
                    async: true, //在沒有返回值之前,不會執行下一步動作
                    url: "../Handler/AddQuestionnaires.aspx",
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
                        }
                    }
                });
            });
        });

        function getData() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Handler/GetQuestionnaires.aspx",
                data: {
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
                                if ($(this).children("Q_Number").text().trim() == '2_1') {
                                    var aryQuestion = $(this).children("Q_Content").text().trim().split(',');
                                    $.each(aryQuestion, function (key, value) {
                                        $("input[name='rd_2_1'][value='" + value + "']").prop("checked", true);
                                    });

                                    $("input[name='rd_2_1']").attr('disabled', true);
                                    if ($("input[name='rd_2_1']:checked").length >= 2) {
                                        $("input[name='rd_2_1']:checked").attr('disabled', false);
                                    }
                                    else {
                                        $("input[name='rd_2_1']").attr('disabled', false);
                                    }

                                }
                                else if ($(this).children("Q_Number").text().trim() == '3_6') {
                                    $("textarea[name='rd_3_6']").val($(this).children("Q_Content").text().trim());
                                }
                                else if ($(this).children("Q_Number").text().trim() == '4_1') {
                                    $("textarea[name='rd_4_1']").val($(this).children("Q_Content").text().trim());
                                }
                                else if ($(this).children("Q_Number").text().trim() == '4_2') {
                                    $("textarea[name='rd_4_2']").val($(this).children("Q_Content").text().trim());
                                }
                                else if ($(this).children("Q_Number").text().trim() == '5_1') {
                                    $("textarea[name='rd_5_1']").val($(this).children("Q_Content").text().trim());
                                }
                                else {
                                    $("input[name='rd_" + $(this).children("Q_Number").text().trim() + "'][value='" + $(this).children("Q_Content").text().trim() + "']").prop("checked", true);
                                }
                            });
                        }
                    }
                }
            });
        }

        function CheckOption() {
            var msg = '';
            var lv1 = 0;
            var lv2 = 0;
            var lv3 = 0;

            for (lv1 = 1; lv1 <= 5; lv1++) {
                if (lv1 == 1) {
                    for (lv2 = 1; lv2 <= 8; lv2++) {
                        if (lv2 == 1) {
                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                if (!$("input[name='rd_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "']").text() + " >> ";
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "_" + lv3 + "']").text() + "\n";
                                }
                            }
                        }
                        if (lv2 == 2) {
                            for (lv3 = 1; lv3 <= 2; lv3++) {
                                if (!$("input[name='rd_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "']").text() + " >> ";
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "_" + lv3 + "']").text() + "\n";
                                }
                            }
                        }
                        if (lv2 == 3) {
                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                if (!$("input[name='rd_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "']").text() + " >> ";
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "_" + lv3 + "']").text() + "\n";
                                }
                            }
                        }
                        if (lv2 == 4) {
                            for (lv3 = 1; lv3 <= 2; lv3++) {
                                if (!$("input[name='rd_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "']").text() + " >> ";
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "_" + lv3 + "']").text() + "\n";
                                }
                            }
                        }
                        if (lv2 == 5) {
                            for (lv3 = 1; lv3 <= 3; lv3++) {
                                if (!$("input[name='rd_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "']").text() + " >> ";
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "_" + lv3 + "']").text() + "\n";
                                }
                            }
                        }
                        if (lv2 == 6) {
                            for (lv3 = 1; lv3 <= 2; lv3++) {
                                if (!$("input[name='rd_" + lv1 + "_" + lv2 + "_" + lv3 + "']").is(":checked")) {
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "']").text() + " >> ";
                                    msg += $("span[name='sp_" + lv1 + "_" + lv2 + "_" + lv3 + "']").text() + "\n";
                                }
                            }
                        }
                    }
                }
                if (lv1 == 2) {
                    if ($("input.ckbtn[value=1]").is(":not(:checked)") && $("input.ckbtn[value=2]").is(":not(:checked)") && $("input.ckbtn[value=3]").is(":not(:checked)")
                        && $("input.ckbtn[value=4]").is(":not(:checked)") && $("input.ckbtn[value=5]").is(":not(:checked)")) {
                        msg += 'Part 2. Which online course and videoconferences of the workshop are most useful to you\n';
                    }
                }
                if (lv1 == 3) {
                    for (lv2 = 1; lv2 <= 5; lv2++) {
                        if (!$("input[name='rd_" + lv1 + "_" + lv2 + "']").is(":checked")) {
                            msg += $("span[name='sp_" + lv1 + "']").text() + " >> ";
                            msg += $("span[name='sp_" + lv1 + "_" + lv2 + "']").text() + "\n";
                        }
                    }
                }
            }

            if (msg != '') {
                msg = "Please select answer on :\n" + msg;
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
                <span class="filetitle font-size5">Questionnaires</span>
                <!--<span class="itemright">麵包屑</span>-->
            </div>

            <div class="paddingMVRL margin10B">

                <div class="BoxRadiusA BoxBorderSa padding10ALL lineheight02 margin10T">
                    Thank you for participating in the <span class="font-bold">2021 APEC Medical Devices Regulatory Science Center of Excellence Workshop</span>  hosted by Taiwan FDA. Please tick the relevant boxes below. Your feedback will help us make continuous improvements. We appreciate your time and effort.<br>
                    Note: Responses to the individual items are scored on a scale from 1 to 5.
               A score of 1 indicates “not satisfied at all” and a 5 indicates “extremely satisfied.”
                </div>

                <div class="font-size3 font-title margin20T">Part 1. Rating for online courses</div>
                <div class="margin10T stripeMeCS">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th rowspan="2" align="left"><span name="sp_1_1">Online course 2: Medical Device Session</span></th>
                            <th colspan="5">Score</th>
                        </tr>
                        <tr>
                            <th width="40">5</th>
                            <th width="40">4</th>
                            <th width="40">3</th>
                            <th width="40">2</th>
                            <th width="40">1</th>
                        </tr>
                        <tr>
                            <td><span name="sp_1_1_1">1.Adequacy of training materials </span></td>
                            <td align="center">
                                <input name="rd_1_1_1" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_1_1" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_1_1" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_1_1" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_1_1" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_1_2">2.Adequacy of the time allocation for this course </span></td>
                            <td align="center">
                                <input name="rd_1_1_2" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_1_2" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_1_2" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_1_2" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_1_2" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_1_3">3.Facilitation and presentation of the content </span></td>
                            <td align="center">
                                <input name="rd_1_1_3" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_1_3" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_1_3" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_1_3" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_1_3" type="radio" value="1" /></td>
                        </tr>
                    </table>
                </div>

                <div class="margin10T stripeMeCS">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th align="left" nowrap><span name="sp_1_2">Knowledge level of online course 2 </span></th>
                            <th class="font-debold font-size2">expert knowledge</th>
                            <th class="font-debold font-size2">good knowledge</th>
                            <th class="font-debold font-size2">working knowledge</th>
                            <th class="font-debold font-size2">limited knowledge</th>
                            <th class="font-debold font-size2">no knowledge</th>
                        </tr>
                        <tr>
                            <td><span name="sp_1_2_1">Pre-Program </span></td>
                            <td align="center">
                                <input name="rd_1_2_1" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_2_1" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_2_1" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_2_1" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_2_1" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_2_2">Post-Program </span></td>
                            <td align="center">
                                <input name="rd_1_2_2" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_2_2" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_2_2" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_2_2" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_2_2" type="radio" value="1" /></td>
                        </tr>
                    </table>
                </div>

                <div class="margin10T stripeMeCS">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th rowspan="2" align="left"><span name="sp_1_3">Online course 3: In Vitro Diagnostic Device Session </span></th>
                            <th colspan="5">Score</th>
                        </tr>
                        <tr>
                            <th width="40">5</th>
                            <th width="40">4</th>
                            <th width="40">3</th>
                            <th width="40">2</th>
                            <th width="40">1</th>
                        </tr>
                        <tr>
                            <td><span name="sp_1_3_1">1.Adequacy of training materials </span></td>
                            <td align="center">
                                <input name="rd_1_3_1" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_3_1" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_3_1" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_3_1" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_3_1" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_3_2">2.Adequacy of the time allocation for this course </span></td>
                            <td align="center">
                                <input name="rd_1_3_2" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_3_2" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_3_2" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_3_2" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_3_2" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_3_3">3.Facilitation and presentation of the content </span></td>
                            <td align="center">
                                <input name="rd_1_3_3" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_3_3" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_3_3" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_3_3" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_3_3" type="radio" value="1" /></td>
                        </tr>
                    </table>
                </div>

                <div class="margin10T stripeMeCS">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th align="left" nowrap><span name="sp_1_4">Knowledge level of online course 3 </span></th>
                            <th class="font-debold font-size2">expert knowledge</th>
                            <th class="font-debold font-size2">good knowledge</th>
                            <th class="font-debold font-size2">working knowledge</th>
                            <th class="font-debold font-size2">limited knowledge</th>
                            <th class="font-debold font-size2">no knowledge</th>
                        </tr>
                        <tr>
                            <td><span name="sp_1_4_1">Pre-Program </span></td>
                            <td align="center">
                                <input name="rd_1_4_1" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_4_1" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_4_1" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_4_1" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_4_1" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_4_2">Post-Program </span></td>
                            <td align="center">
                                <input name="rd_1_4_2" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_4_2" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_4_2" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_4_2" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_4_2" type="radio" value="1" /></td>
                        </tr>
                    </table>
                </div>

                <div class="margin10T stripeMeCS">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th rowspan="2" align="left"><span name="sp_1_5">Online course 4: Clinical Evaluation Session </span></th>
                            <th colspan="5">Score</th>
                        </tr>
                        <tr>
                            <th width="40">5</th>
                            <th width="40">4</th>
                            <th width="40">3</th>
                            <th width="40">2</th>
                            <th width="40">1</th>
                        </tr>
                        <tr>
                            <td><span name="sp_1_5_1">1.Adequacy of training materials </span></td>
                            <td align="center">
                                <input name="rd_1_5_1" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_5_1" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_5_1" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_5_1" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_5_1" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_5_2">2.Adequacy of the time allocation for this course </span></td>
                            <td align="center">
                                <input name="rd_1_5_2" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_5_2" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_5_2" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_5_2" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_5_2" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_5_3">3.Facilitation and presentation of the content </span></td>
                            <td align="center">
                                <input name="rd_1_5_3" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_5_3" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_5_3" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_5_3" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_5_3" type="radio" value="1" /></td>
                        </tr>
                    </table>
                </div>

                <div class="margin10T stripeMeCS">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th align="left" nowrap><span name="sp_1_6">Knowledge level of online course 4 </span></th>
                            <th class="font-debold font-size2">expert knowledge</th>
                            <th class="font-debold font-size2">good knowledge</th>
                            <th class="font-debold font-size2">working knowledge</th>
                            <th class="font-debold font-size2">limited knowledge</th>
                            <th class="font-debold font-size2">no knowledge</th>
                        </tr>
                        <tr>
                            <td><span name="sp_1_6_1">Pre-Program </span></td>
                            <td align="center">
                                <input name="rd_1_6_1" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_6_1" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_6_1" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_6_1" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_6_1" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_1_6_2">Post-Program </span></td>
                            <td align="center">
                                <input name="rd_1_6_2" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_1_6_2" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_1_6_2" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_1_6_2" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_1_6_2" type="radio" value="1" /></td>
                        </tr>
                    </table>
                </div>

                <div class="font-size3 font-title margin20T">Part 2. Which online course of the workshop are most useful to you? (maximum two options)</div>
                <div class="margin10T">
                    <div class="">
                        <input class="ckbtn" name="rd_2_1" type="checkbox" value="1" />
                        Online course 2: Medical Device Session</div>
                    <div class="margin5T">
                        <input class="ckbtn" name="rd_2_1" type="checkbox" value="2" />
                        Online course 3: In Vitro Diagnostic Device Session</div>
                    <div class="margin5T">
                        <input class="ckbtn" name="rd_2_1" type="checkbox" value="3" />
                        Online course 4: Clinical Evaluation Session</div>
                    <div class="margin5T">
                        <input class="ckbtn" name="rd_2_1" type="checkbox" value="4" />
                        Online course 5: Current harmonization status of pre-market regulation in APEC member economies</div>
                    <div class="margin5T">
                        <input class="ckbtn" name="rd_2_1" type="checkbox" value="5" />
                        Training Exercise</div>
                </div>

                <div class="font-size3 font-title margin20T"><span name="sp_3">Part 3. General satisfaction with the workshop </span></div>

                <div class="BoxRadiusA BoxBorderSa padding10ALL lineheight02 margin10T">
                    A score of 1 indicates “not satisfied at all” and a 5 indicates “extremely satisfied.”
                </div>

                <div class="margin10T stripeMeCS">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <th rowspan="2" align="left"></th>
                            <th colspan="5">Score</th>
                        </tr>
                        <tr>

                            <th width="40">5</th>
                            <th width="40">4</th>
                            <th width="40">3</th>
                            <th width="40">2</th>
                            <th width="40">1</th>
                        </tr>
                        <tr>
                            <td><span name="sp_3_1">1.Were level and amount of pre-training materials adequate? </span></td>
                            <td align="center">
                                <input name="rd_3_1" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_3_1" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_3_1" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_3_1" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_3_1" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_3_2">2.Were you satisfied with the training materials of this workshop? </span></td>
                            <td align="center">
                                <input name="rd_3_2" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_3_2" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_3_2" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_3_2" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_3_2" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_3_3">3.Did the workshop enhance your understanding of the use of essential principles to perform conformity assessment of medical devices? </span></td>
                            <td align="center">
                                <input name="rd_3_3" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_3_3" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_3_3" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_3_3" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_3_3" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_3_4">4.Were you satisfied with the length of this workshop? </span></td>
                            <td align="center">
                                <input name="rd_3_4" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_3_4" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_3_4" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_3_4" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_3_4" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td><span name="sp_3_5">5.Were your expectations for the workshop met? </span></td>
                            <td align="center">
                                <input name="rd_3_5" type="radio" value="5" /></td>
                            <td align="center">
                                <input name="rd_3_5" type="radio" value="4" /></td>
                            <td align="center">
                                <input name="rd_3_5" type="radio" value="3" /></td>
                            <td align="center">
                                <input name="rd_3_5" type="radio" value="2" /></td>
                            <td align="center">
                                <input name="rd_3_5" type="radio" value="1" /></td>
                        </tr>
                        <tr>
                            <td colspan="7">6.Any suggestions for improving the content of the workshop?</td>
                        </tr>
                        <tr>
                            <td colspan="7">
                                <textarea name="rd_3_6" rows="3" cols="" class="inputex width100" placeholder=""></textarea></td>
                        </tr>
                    </table>
                </div>

                <div class="font-size3 font-title margin20T">Part 4. Do you think topics/areas of the workshop can be added/deleted?</div>

                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                    1.Should be added to the workshop:
                </div>
                <!-- BoxRadiusAu -->
                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                    <textarea rows="3" name="rd_4_1" cols="" class="inputex width100" placeholder=""></textarea>
                </div>
                <!-- BoxRadiusAd -->

                <div class="BoxRadiusAu BoxBorderSa padding10ALL margin10T">
                    2.Should be deleted from the workshop:
                </div>
                <!-- BoxRadiusAu -->
                <div class="BoxRadiusAd BoxBorderSa BoxBgWc padding10ALL">
                    <textarea rows="3" name="rd_4_2" cols="" class="inputex width100" placeholder=""></textarea>
                </div>
                <!-- BoxRadiusAd -->

                <div class="font-size3 font-title margin20T">Part 5. Additional suggestions for the workshop:</div>
                <textarea rows="5" name="rd_5_1" cols="" class="inputex width100" placeholder=""></textarea>

                <div class="twocol margin10TB">
                    <div class="right"><a id="subbtn" href="javascript:void(0);" class="genbtn">Submit</a> </div>
                </div>
            </div>
            <!-- paddingMVRL -->

            <!-- 所有網站內容放在此以上 -->
        </div>
        <!-- Insidemaincontent -->
    </div>
</asp:Content>