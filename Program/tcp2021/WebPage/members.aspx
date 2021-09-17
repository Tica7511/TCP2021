<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="members.aspx.cs" Inherits="WebPage_members" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {
            if ($("#Competence").val() == '03') {
                $("#a_tab3").hide();

            }

            //getForums();
            getData(0);
            getSelfData();

            //$("#pageblock").hide();

            //table換頁滑動到頁面最上方
            $(document).on("click", ".pagestylegen", function () {
                $('html,body').animate({ scrollTop: 0 }, 'slow');
            });

            //tab1
            //$(document).on("click", "#a_tab1", function () {
            //    getForums();
            //    $("#pageblock").hide();
            //});
            //tab2
            $(document).on("click", "#a_tab2", function () {
                getData(0);
                $("#pageblock").show();
            });
            //tab3
            $(document).on("click", "#a_tab3", function () {
                $("#pageblock").hide();
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
			    	url: "../Handler/AddForums.aspx",
			    	data: {
			    		guid: "",
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
			    	url: "../Handler/AddForums.aspx",
			    	data: {
			    		guid: $("#Cguid").val(),
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
                $("#Cguid").val($(this).attr("aid"));
                e.preventDefault();
                $(".emoji-wysiwyg-editor").html('');
                doOpenReplyPopup();
            });

            $("#imgPath").change(function () {
                readURL(this);
            });

            $(document).on("click", "#cancelbtn", function () {
                if (confirm("Confirm the cancellation?")) {
					location.href = "members.aspx";
				}
            });

            $(document).on("click", "#subbtn", function () {
                // Get form
				var form = $('#form1')[0];

				// Create an FormData object 
				var data = new FormData(form);

				// If you want to add an extra field for the FormData
				data.append("introduction", $("#txt_introduction").val());
                data.append('fileUpload', $("#imgPath").get(0).files[0]);

				$.ajax({
					type: "POST",
					async: false, //在沒有返回值之前,不會執行下一步動作
					url: "../Handler/AddMember.aspx",
					data: data,
					processData: false,
					contentType: false,
					cache: false,
					error: function (xhr) {
						alert("Error: " + xhr.status);
						console.log(xhr.responseText);
					},
					success: function (data) {
						if ($(data).find("Error").length > 0) {
							alert($(data).find("Error").attr("Message"));
						}
                        else {
                            alert($("Response", data).text());
                            location.href = "members.aspx";
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
                open: function() {
                    this.slideDown(100);//動畫效果
                },
                close: function() {
                    this.slideUp(100);//動畫效果
                },
            });
        
            $("#collapse1").trigger("open") // 預設全開啟
            //$("#collapse1").trigger("close") // 預設全關閉(default)
            $("#collapse1 div:nth-child(1) div.collapseTitle a").trigger("open") // 控制第幾個開啟
        
            //全部收合展開按鈕動作
            $("#collapse1open").click(function(){
                $("#collapse1").trigger("open");
                return false;
            });
            $("#collapse1close").click(function(){
                $("#collapse1").trigger("close");
                return false;
            });
        
        
        
            $("#collapse2").collapse({
                query: 'div.collapseTitle',//收合標題樣式名
                persist: false,//是否記憶收合,需配合jquery.collapse_storage.js
                open: function() {
                    this.slideDown(100);//動畫效果
                },
                close: function() {
                    this.slideUp(100);//動畫效果
                },
            });
        
            $("#collapse2").trigger("open") // 預設全開啟
            //$("#collapse1").trigger("close") // 預設全關閉(default)
            $("#collapse2 div:nth-child(1) div.collapseTitle a").trigger("open") // 控制第幾個開啟
        
            //全部收合展開按鈕動作
            $("#collapse2open").click(function(){
                $("#collapse2").trigger("open");
                return false;
            });
            $("#collapse2close").click(function(){
                $("#collapse2").trigger("close");
                return false;
            });
        
        
        
            $('#tab-container').easytabs({
                //defaultTab:"li:nth-child(2)",//預設開啟第二個頁籤
                updateHash: false,//停止切換頁籤跳轉到內容
            });


        });

        function doOpenCommentPopup() {
            $.magnificPopup.open({
                items: {
                    src: '#popComment'
                },
                type:'inline',
  	        	midClick: false, // 是否使用滑鼠中鍵
  	        	closeOnBgClick:true,//點擊背景關閉視窗
  	        	showCloseBtn:true,//隱藏關閉按鈕
  	        	fixedContentPos:true,//彈出視窗是否固定在畫面上
  	        	mainClass: 'mfp-fade',//加入CSS淡入淡出效果
  	        	tClose: '關閉',//翻譯字串
            });
        }

        function doOpenReplyPopup() {
            $.magnificPopup.open({
                items: {
                    src: '#popReply'
                },
                type:'inline',
  	        	midClick: false, // 是否使用滑鼠中鍵
  	        	closeOnBgClick:true,//點擊背景關閉視窗
  	        	showCloseBtn:true,//隱藏關閉按鈕
  	        	fixedContentPos:true,//彈出視窗是否固定在畫面上
  	        	mainClass: 'mfp-fade',//加入CSS淡入淡出效果
  	        	tClose: '關閉',//翻譯字串
            });
        }

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#PopupImg').attr('src', e.target.result);
                }

                reader.readAsDataURL(input.files[0]); // convert to base64 string
            }
        }

        function getData(p) {
			$.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Handler/GetMember.aspx",
                data: {
                    type: "list",
                    PageNo: p,
					PageSize: Page.Option.PageSize,
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
						$("#tabs2").empty();
						var tabstr = '';
						if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                tabstr += '<div class="BoxRadiusA BoxShadowA margin20T"><div class="row">';
                                tabstr += '<div class="col-lg-3 col-md-3 col-sm-4">';
                                tabstr += '<img class="img-responsive imgcenter img-rounded imgH" src="../DOWNLOAD.aspx?type=01&v=' +
                                    $(this).children("EncodeGuid").text().trim() + '" onerror="javascript:this.src=' + "'../images/default-people.jpg'" + ';" >';
                                tabstr += '</div>';
                                tabstr += '<div class="col-lg-9 col-md-9 col-sm-8"><div class="padding10ALL font-size3 lineheight02">';
                                tabstr += '<div class="font-size3 font-title">' + $(this).children("M_Name").text().trim() + '</div>';
                                tabstr += $(this).children("M_Introduction").text().trim();
                                tabstr += '</div></div></div></div>';
							});
						}
						$("#tabs2").append(tabstr);
                        Page.Option.Selector = "#pageblock";
                        Page.Option.FunctionName = "getData";
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }

        function getSelfData() {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Handler/GetMember.aspx",
                data: {
                    type: "data",
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
                                var introstr = $(this).children("M_Introduction").text().trim();
                                $("#PopupImg").attr("src", "../DOWNLOAD.aspx?type=01&v=" + $(this).children("EncodeGuid").text().trim());
                                if (introstr != '')
                                    $("#txt_introduction").val(introstr);
                                else
                                    $("#txt_introduction").attr("placeholder", "Please introduce your name, job title, department, organization, and you experience and how long you have been working in the related field. You are encouraged to tell us your hobby and what you would like to let us know.")
							});
                        }
					}
				}
			});
        }

        function getForums() {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Handler/GetForums.aspx",
                data: {
                    type: "comment",
                    guid: "",
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
                                tabstr += '<div class="margin5T lineheight02">' + $(this).children("FM_Content").text().trim() + '</div>';
                                tabstr += '<div class="twocol margin5T">';
                                tabstr += '<div class="right"><a name="popreply" href="javascript:void(0);" class="genbtnS" aid="' + $(this).children("FM_Guid").text().trim() + '">Reply</a></div>';
                                tabstr += '</div>';

                                $.ajax({
			                    	type: "POST",
			                    	async: false, //在沒有返回值之前,不會執行下一步動作
			                    	url: "../Handler/GetForums.aspx",
                                    data: {
                                        type: "reply",
                                        guid: $(this).children("FM_Guid").text().trim(),
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
                                                    replystr += '<div class="margin5T lineheight02">' + $(this).children("FM_Content").text().trim() + '</div></div>';
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
                            tabstr += '<div class="left"><span class="font-title font-bold">There is no comment down below</span></div>'
						$("#forumsList").append(tabstr);
					}
				}
			});
        }
        
        $(function() {
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <input type="hidden" id="Competence" value="<%= usercompetence %>" />
    <div class="container margin15T">
    <div id="Insidemaincontent">
       <!-- 所有網站內容放在此以下 -->
       <input type="hidden" id="Cguid" />
       <div class="filetitlewrapper margin20T">
           <span class="filetitle font-size5">Members</span>
           <span class="itemright"></span>
       </div>

       <div class="paddingMVRL margin10TB">



           <div id="tab-container" class='easytabH'>
               <ul class="menubar">
                   <%--<li><a id="a_tab1" href="#tabs1">Forums</a></li>--%>
                   <li><a id="a_tab2" href="#tabs2">Members</a></li>
                   <li><a id="a_tab3" href="#tabs3">My information</a></li>
               </ul>
               <div class='panel-container'>
                   <%--<div id="tabs1">
                       <div class="textright"><a id="popupcomment" href="javascript:void(0);" class="genbtn">Comment</a></div>

                       <div id="forumsList"></div>

                   </div><!-- tabs1 -->--%>
                   <div>
                       <div id="tabs2">

                       </div><!-- tabs2 -->
                       <div class="margin10B margin10T textcenter">
				           <div id="pageblock"></div>
				       </div>
                   </div>

                   <div id="tabs3">

                       <div class="OchiFixTable width100 TitleLength07">
                           <div class="OchiRow">
                               <div class="OchiCell OchiTitle TitleSetWidth">photo</div>
                               <div class="OchiCell width100">
                                   <img id="PopupImg" onerror="javascript:this.src='../images/default-people.jpg';" height="80" />
                                   <div class="margin5T">
                                       <input id="imgPath" type="file" />
                                   </div>
                               </div>
                           </div><!-- OchiRow -->
                           <div class="OchiRow">
                               <div class="OchiCell OchiTitle TitleSetWidth">Introduction</div>
                               <div class="OchiCell width100">
                                   <textarea id="txt_introduction" rows="8" cols="" class="inputex width100"></textarea>
                               </div>
                           </div><!-- OchiRow -->
                       </div>

                       <div class="twocol margin10T">
                           <div class="right">
                               <a id="cancelbtn" href="javascript:void(0);" class="genbtn" title="">Cancel</a>
                               <a id="subbtn" href="javascript:void(0);" class="genbtn" title="">Save</a>
                           </div>
                       </div><!-- twocol -->

                   </div><!-- tabs3 -->
               </div><!-- panel-container -->
           </div><!-- tab-container -->


       </div><!-- paddingMVRL -->

       <!-- 所有網站內容放在此以上 -->
   </div><!-- Insidemaincontent -->
   </div>

<div id="popComment" class="magpopup magSizeM mfp-hide">
    <div class="magpopupTitle">Comment</div>
    <div class="padding10ALL">
        <p class="lead emoji-picker-container">
            <textarea id="txt_comment" class="form-control textarea-control" rows="5" style="height: 200px;" placeholder="Please type something here" data-emojiable="true" data-emoji-input="unicode"></textarea>
        </p>


        <div class="twocol margin10T">
            <div class="left">
                <span id="errMsg" style="color:red;"></span>
            </div>
            <div class="right">
                <a href="javascript:void(0);" class="genbtn closemagnificPopup">Cancel</a>
                <a id="csubbtn" href="javascript:void(0);" class="genbtn">Send</a>
            </div>
        </div><!-- twocol -->

    </div><!-- padding10ALL -->

</div><!--magpopup -->

<div id="popReply" class="magpopup magSizeM mfp-hide">
    <div class="magpopupTitle">Reply</div>
    <div class="padding10ALL">
        <p class="lead emoji-picker-container">
            <textarea id="txt_reply" class="form-control textarea-control" rows="5" style="height: 200px;" placeholder="Please type something here" data-emojiable="true" data-emoji-input="unicode"></textarea>
        </p>


        <div class="twocol margin10T">
            <div class="left">
                <span id="errMsg2" style="color:red;"></span>
            </div>
            <div class="right">
                <a href="javascript:void(0);" class="genbtn closemagnificPopup">Cancel</a>
                <a id="rsubbtn" href="javascript:void(0);" class="genbtn">Send</a>
            </div>
        </div><!-- twocol -->

    </div><!-- padding10ALL -->

</div><!--magpopup -->

<!-- 本頁面使用的JS -->
<script type="text/javascript" src="<%= ResolveUrl("~/js/config.js") %>"></script><!-- Emoji -->
<script type="text/javascript" src="<%= ResolveUrl("~/js/util.js") %>"></script><!-- Emoji -->
<script type="text/javascript" src="<%= ResolveUrl("~/js/jquery.emojiarea.js") %>"></script><!-- Emoji -->
<script type="text/javascript" src="<%= ResolveUrl("~/js/emoji-picker.js") %>"></script><!-- Emoji -->

</asp:Content>

