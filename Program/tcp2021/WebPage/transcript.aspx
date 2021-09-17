<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="transcript.aspx.cs" Inherits="WebPage_transcript" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            getData();

            $('.equalheightblock').matchHeight({
                byRow: true,//若為false,則所有區塊等高
                property: 'height',//使用min-height會出問題
                target: null,//設定等高對象:$('.sidebar')
                remove: false
            });
        });

        function getData() {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Handler/GetTranscript.aspx",
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
                        $("#sp_courseNum1").empty();
                        $("#sp_courseNum2").empty();
                        $("#sp_assignmentNum1").empty();
                        $("#sp_assignmentNum2").empty();
                        $("#sp_questionnairesNum").empty();
                        $("#div_Champ").empty();
						if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) { 
                                $("#sp_courseNum1").html($(this).children("mcCount").text().trim());
                                $("#sp_courseNum2").html($(this).children("cCount").text().trim());
                                $("#sp_assignmentNum1").html($(this).children("maCount").text().trim());
                                $("#sp_assignmentNum2").html($(this).children("aCount").text().trim());
                                $("#sp_questionnairesNum").html($(this).children("qCount").text().trim());
                                if ($(this).children("allCount").text().trim() == 'Y')
                                    $("#div_Champ").append('<span class="IconSizeA IconCc"><i class="fa fa-trophy" aria-hidden="true"></i></span>');
                                else
                                    $("#div_Champ").append('<span style="font-size: 2em;" class="IconCc">keep going</span>');
							});
                        }
					}
				}
			});
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container margin15T">	

   
   <div id="Insidemaincontent">
       <!-- 所有網站內容放在此以下 -->
       <div class="filetitlewrapper">
           <span class="filetitle font-size5">My Transcript</span>
           <span class="itemright"></span>
       </div>

       <div class="paddingMVRL"  id="tranarea">

            <div class="row margin20TB">
                <div class="col-lg-3 col-md-3 col-sm-6 margin20B">
                    <div class="BoxRadiusAu padding10ALL BoxBgCa font-size6 textcenter">
                        <i class="fa fa-film font-white" aria-hidden="true"></i>
                    </div>
                    <div class="BoxRadiusAd padding10ALL BoxShadowA textcenter equalheightblock">
                        <div>
                            <span id="sp_courseNum1" class="IconSizeB IconCa"></span> / <span id="sp_courseNum2"></span>
                        </div>
                        <div class="font-size3">Online Courses</div>
                    </div>
                </div><!-- col -->

                <div class="col-lg-3 col-md-3 col-sm-6 margin20B">
                    <div class="BoxRadiusAu padding10ALL BoxBgCb font-size6 textcenter">
                        <i class="fa fa-pencil font-white" aria-hidden="true"></i>
                    </div>
                    <div class="BoxRadiusAd padding10ALL BoxShadowA textcenter equalheightblock">
                        <div>
                            <span id="sp_assignmentNum1" class="IconSizeB IconCb"></span> / <span id="sp_assignmentNum2"></span> 
                        </div>
                        <div class="font-size3">Assignment</div>
                    </div>
                </div><!-- col -->

                <div class="col-lg-3 col-md-3 col-sm-6 margin20B">
                    <div class="BoxRadiusAu padding10ALL BoxBgCf font-size6 textcenter">
                        <i class="fa fa-check-square-o font-white" aria-hidden="true"></i>
                    </div>
                    <div class="BoxRadiusAd padding10ALL BoxShadowA textcenter equalheightblock">
                        <div>
                            <span id="sp_questionnairesNum" class="IconSizeB IconCf"></span> / 1
                        </div>
                        <div class="font-size3">Questionnaires</div>
                    </div>
                </div><!-- col -->

                <div class="col-lg-3 col-md-3 col-sm-6 margin20B">
                    <div class="BoxRadiusAu padding10ALL BoxBgCc font-size6 textcenter">
                        <i class="fa fa-star font-white" aria-hidden="true"></i>
                    </div>
                    <div class="BoxRadiusAd padding10ALL BoxShadowA textcenter equalheightblock">
                        <div id="div_Champ" class="padding20TB">
                            
                        </div>
                        <div class="font-size3">Certificate</div>
                    </div>
                </div><!-- col -->
            </div><!-- row -->

       </div><!-- paddingMVRL -->


       <!-- 所有網站內容放在此以上 -->
   </div><!-- Insidemaincontent -->
   
   </div><!-- conainer -->

</asp:Content>

