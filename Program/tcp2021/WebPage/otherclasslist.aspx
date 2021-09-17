<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageOther.master" AutoEventWireup="true" CodeFile="otherclasslist.aspx.cs" Inherits="WebPage_otherclasslist" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            getData();
        });

        function getData() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Handler/GetOtherClassList.aspx",
                data: {
                    type: "list",
                    cguid: "",
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
                                var openDate = $(this).children("OC_OpenDate").text().trim();
                                var closeDate = $(this).children("OC_CloseDate").text().trim()
                                divstr += '<div class="row BoxShadowA margin20T"><div class="col-lg-10 col-md-9 col-sm-8 BoxBgWa BoxBorderSa equalheightblock padding10ALL movieticketL">';
                                divstr += '<div class="font-size3">' + $(this).children("OC_Name").text().trim() + '</div>';
                                divstr += '<div class="margin5T"><i class="fa fa-user-circle-o IconCa" aria-hidden="true"></i> ' + $(this).children("OC_TeacherName").text().trim() + '</div></div>';
                                if ((IsDateSection1(ValidDateInterval(getDate(openDate), getHH(openDate), getMM(openDate)))) && (IsDateSection2(ValidDateInterval(getDate(closeDate), getHH(closeDate), getMM(closeDate))))) {
                                    if ($(this).children("MC_IsFinish").text().trim() != 'Y') {
                                        divstr += '<div class="col-lg-2 col-md-3 col-sm-4 BoxBgCa BoxBorderSa equalheightblock padding10ALL movieticketR"><div class="textcenter font-white">';
                                        divstr += '<a name="classview" target="_blank" aid="' + $(this).children("OC_Guid").text().trim() + '" href="otherclassview.aspx?guid='
                                            + $(this).children("OC_Guid").text().trim() + '"><div class="font-size9"><i class="fa fa-video-camera" aria-hidden="true"></i></div><div class="font-size3">Play</div></a></div></div></div>';
                                    }
                                    else {
                                        divstr += '<div class="col-lg-2 col-md-3 col-sm-4 BoxBgCb BoxBorderSa equalheightblock padding10ALL movieticketR"><div class="textcenter font-white">';
                                        divstr += '<a name="classview" target="_blank" aid="' + $(this).children("OC_Guid").text().trim() + '" href="otherclassview.aspx?guid='
                                            + $(this).children("OC_Guid").text().trim() + '"><div class="font-size9"><i class="fa fa-check-square-o" aria-hidden="true"></i></div><div class="font-size3">Finished</div></a></div></div></div>';
                                    }
                                }
                                else {
                                    divstr += '<div class="col-lg-2 col-md-3 col-sm-4 BoxBgCc BoxBorderSa equalheightblock padding10ALL movieticketR"><div class="textcenter font-white">';
                                    divstr += '<div class="textcenter font-white"><div class="font-size9"><i class="fa fa-lock" aria-hidden="true"></i></div><div class="font-size3">Lock</div></div></div></div>';
                                }
                                divstr += '</div>';
                            });
                        }

                        $("#div_content").append(divstr);
                    }
                }
            });
        }

        //取得開放 時間/關閉時間 的DATETIME格式
        function ValidDateInterval(str, strHH, strMM) {
            var ValidAry = str.split('/');

            var realMonth = (parseInt(ValidAry[1]) - 1).toString().trim();

            var realDate = new Date(ValidAry[0], realMonth, ValidAry[2], strHH, strMM);

            return realDate;
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

        function IsDateSection1(str) {
            var status = true;

            var date = new Date();

            if (str > date)
                status = false;

            return status;
        }

        function IsDateSection2(str) {
            var status = true;

            var date = new Date();

            if (str < date)
                status = false;

            return status;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container margin15T">
        <div id="Insidemaincontent">
            <!-- 所有網站內容放在此以下 -->
            <div class="filetitlewrapper">
                <span class="filetitle font-size5">Online Courses</span>
                <span class="itemright"></span>
            </div>

            <div id="div_content" class="paddingMVRL margin10B">
            </div>
            <!-- paddingMVRL -->

            <!-- 所有網站內容放在此以上 -->
        </div>
        <!-- Insidemaincontent -->
    </div>
</asp:Content>