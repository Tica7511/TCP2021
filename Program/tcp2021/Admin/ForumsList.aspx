<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="ForumsList.aspx.cs" Inherits="Admin_ForumsList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            getForums1Data(0);
            getForums2Data(0);

            //table換頁滑動到頁面最上方
            //$(document).on("click", ".pagestylegen", function () {
            //    $('html,body').animate({ scrollTop: 0 }, 'slow');
            //});

            //作業一留言紀錄編輯開窗
            $(document).on("click", "a[name='editFbtn']", function () {
                $("#errMsg").html('');
                $("#Fguid").val($(this).attr("aid"));
                $(".emoji-wysiwyg-editor").html($("span[name='cn_" + $("#Fguid").val() + "']").text());
                doOpenMagPopup();                
            });

            //作業一留言紀錄儲存
            $(document).on("click", "#subbtn", function () {
                var msg = '';
				if ($(".emoji-wysiwyg-editor").text() == '')
					msg += "留言不可為空白";

				if (msg != "") {
					$("#errMsg").html(msg);
					return false;
				}

                $.ajax({
			    	type: "POST",
			    	async: false, //在沒有返回值之前,不會執行下一步動作
			    	url: "BackEnd/AddAssignmentForums.aspx",
			    	data: {
			    		guid: $("#Fguid").val(),
			    		cguid: $.getQueryString("guid"),
			    		content: $(".emoji-wysiwyg-editor").text(),
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
                            getForums1Data(0);
                            $.magnificPopup.close();                            
                            //location.href = "members.aspx";
			    		}
			    	}
			    });
            });

            //作業一刪除資料列
            $(document).on("click", "a[name='delFbtn']", function () {
                var str = '';
                if ($(this).attr("atype") == '01')
                    str = confirm('目前刪除的是留言，刪除後會一並將底下回覆都刪除，確定刪除嗎?');
                else 
                    str = confirm('確定刪除嗎?');

                if (str) {
                    $.ajax({
			        	type: "POST",
			        	async: false, //在沒有返回值之前,不會執行下一步動作
			        	url: "BackEnd/DeleteAssignmentForums.aspx",
                        data: {
                            guid: $(this).attr("aid"),
                            type: $(this).attr("atype"),
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
                                alert($("Response", data).text());
                                getForums1Data(0);
			        		}
			        	}
			        });
                }
            });

            //作業二留言紀錄編輯開窗
            $(document).on("click", "a[name='editFbtn2']", function () {
                $("#errMsg2").html('');
                $("#Fguid").val($(this).attr("aid"));
                $(".emoji-wysiwyg-editor").html($("span[name='cn_" + $("#Fguid").val() + "']").text());
                doOpenMagPopup2();                
            });

            //作業二留言紀錄儲存
            $(document).on("click", "#subbtn2", function () {
                var msg = '';
				if ($(".emoji-wysiwyg-editor").text() == '')
					msg += "留言不可為空白";

				if (msg != "") {
					$("#errMsg").html(msg);
					return false;
				}

                $.ajax({
			    	type: "POST",
			    	async: false, //在沒有返回值之前,不會執行下一步動作
			    	url: "BackEnd/AddAssignmentForums.aspx",
			    	data: {
			    		guid: $("#Fguid").val(),
			    		cguid: $.getQueryString("guid"),
			    		content: $(".emoji-wysiwyg-editor").text(),
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
                            getForums2Data(0);
                            $.magnificPopup.close();                            
                            //location.href = "members.aspx";
			    		}
			    	}
			    });
            });

            //作業二刪除資料列
            $(document).on("click", "a[name='delFbtn2']", function () {
                var str = '';
                if ($(this).attr("atype") == '01')
                    str = confirm('目前刪除的是留言，刪除後會一並將底下回覆都刪除，確定刪除嗎?');
                else 
                    str = confirm('確定刪除嗎?');

                if (str) {
                    $.ajax({
			        	type: "POST",
			        	async: false, //在沒有返回值之前,不會執行下一步動作
			        	url: "BackEnd/DeleteAssignmentForums.aspx",
                        data: {
                            guid: $(this).attr("aid"),
                            type: $(this).attr("atype"),
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
                                alert($("Response", data).text());
                                getForums2Data(0);
			        		}
			        	}
			        });
                }
            });

            //取消
            $(document).on("click", "#cancelbtn", function () {
                $.magnificPopup.close();
            });

            //取消
            $(document).on("click", "#cancelbtn2", function () {
                $.magnificPopup.close();
            });

            $('#tab-container').easytabs({
                //defaultTab:"li:nth-child(2)",//預設開啟第二個頁籤
                updateHash: false,//停止切換頁籤跳轉到內容
            });
        });

        function getForums1Data(p) {
			$.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetAssignmentForumsList.aspx",
                data: {
                    sort: '1',
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
						$("#tablist tbody").empty();
						var tabstr = '';
						if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                tabstr += '<tr>'
                                tabstr += '<td class="" align="center">' + $(this).children("M_Name").text().trim() + '</td>';
                                tabstr += '<td><span name="cn_' + $(this).children("AF_Guid").text().trim() + '">' + $(this).children("AF_Content").text().trim() + '</td>';
                                tabstr += '<td align="center">' + $(this).children("contentDate").text().trim() + '&nbsp;' + $(this).children("contentTime").text().trim() + '</td>';
                                tabstr += '<td align="center">';
                                tabstr += '<div class="margin5B"><a name="editFbtn" aid="' + $(this).children("AF_Guid").text().trim() + '" href="javascript:void(0);">編輯</a></div>';
                                tabstr += '<a name="delFbtn" aid="' + $(this).children("AF_Guid").text().trim() + '" atype="' + $(this).children("AF_Type").text().trim() + '" href="javascript:void(0);">刪除</a></td>';
                                tabstr += '</tr>';
							});
                        }
                        else
							tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
						$("#tablist tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock";
                        Page.Option.FunctionName = "getForums1Data";
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }

        function getForums2Data(p) {
			$.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetAssignmentForumsList.aspx",
                data: {
                    sort: '2',
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
						$("#tablist2 tbody").empty();
						var tabstr = '';
						if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                tabstr += '<tr>'
                                tabstr += '<td class="" align="center">' + $(this).children("M_Name").text().trim() + '</td>';
                                tabstr += '<td><span name="cn_' + $(this).children("AF_Guid").text().trim() + '">' + $(this).children("AF_Content").text().trim() + '</td>';
                                tabstr += '<td align="center">' + $(this).children("contentDate").text().trim() + '&nbsp;' + $(this).children("contentTime").text().trim() + '</td>';
                                tabstr += '<td align="center">';
                                tabstr += '<div class="margin5B"><a name="editFbtn2" aid="' + $(this).children("AF_Guid").text().trim() + '" href="javascript:void(0);">編輯</a></div>';
                                tabstr += '<a name="delFbtn2" aid="' + $(this).children("AF_Guid").text().trim() + '" atype="' + $(this).children("AF_Type").text().trim() + '" href="javascript:void(0);">刪除</a></td>';
                                tabstr += '</tr>';
							});
                        }
                        else
							tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
						$("#tablist2 tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock2";
                        Page.Option.FunctionName = "getForums2Data";
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }

        function doOpenMagPopup() {
            $.magnificPopup.open({
                items: {
                    src: '#messageblock'
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

        function doOpenMagPopup2() {
            $.magnificPopup.open({
                items: {
                    src: '#messageblock2'
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

        $(function() {
            // Initializes and creates emoji set from sprite sheet
            window.emojiPicker = new EmojiPicker({
                emojiable_selector: '[data-emojiable=true]',
                assetsPath: 'images/',
                popupButtonClasses: 'fa fa-smile-o',
            });
            // Finds all elements with `emojiable_selector` and converts them to rich emoji input fields
            // You may want to delay this step if you have dynamically created input fields that appear later in the loading process
            // It can be called as many times as necessary; previously converted input fields will not be converted again
            window.emojiPicker.discover();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <input type="hidden" id="Fguid" />
    <div class="filetitlewrapper">
        <span class="filetitle font-size6">留言版</span>
        <!--<span class="itemright">麵包屑</span>-->
    </div>

    <div class="font-size4 font-bold font-title margin10T">作業一</div>

    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap width="200">留言人</th>
                    <th nowrap>留言內容</th>
                    <th nowrap width="230">留言時間</th>
                    <th nowrap width="80">功能</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
	        <div id="pageblock"></div>
	    </div>
    </div><!-- stripeMe -->   
    <br />
    
    <div class="font-size4 font-bold font-title">作業二</div>

    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist2" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap width="200">留言人</th>
                    <th nowrap>留言內容</th>
                    <th nowrap width="230">留言時間</th>
                    <th nowrap width="80">功能</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
	        <div id="pageblock2"></div>
	    </div>
    </div><!-- stripeMe -->

<!-- Magnific Popup -->
<div id="messageblock" class="magpopup magSizeM mfp-hide">
  <div class="magpopupTitle">訊息內容</div>
  <div class="padding10ALL">

      <p class="lead emoji-picker-container">
          <textarea id="txt_Content" class="form-control textarea-control" rows="5" style="height: 200px;" placeholder="Textarea with emoji Unicode input" data-emojiable="true" data-emoji-input="unicode" ></textarea>
      </p>

      <div class="twocol margin10T">
          <div class="left">
              <span id="errMsg" style="color:red;"></span>
          </div>
          <div class="right">
              <a id="cancelbtn" href="javascript:void(0);" class="genbtn">取消</a> 
              <a id="subbtn" href="javascript:void(0);" class="genbtn">儲存</a>
          </div>
      </div><!-- twocol -->


  </div><!-- padding10ALL -->

</div><!--magpopup -->

<div id="messageblock2" class="magpopup magSizeM mfp-hide">
  <div class="magpopupTitle">訊息內容</div>
  <div class="padding10ALL">

      <p class="lead emoji-picker-container">
          <textarea id="txt_Content2" class="form-control textarea-control" rows="5" style="height: 200px;" placeholder="Textarea with emoji Unicode input" data-emojiable="true" data-emoji-input="unicode" ></textarea>
      </p>

      <div class="twocol margin10T">
          <div class="left">
              <span id="errMsg2" style="color:red;"></span>
          </div>
          <div class="right">
              <a id="cancelbtn2" href="javascript:void(0);" class="genbtn">取消</a> 
              <a id="subbtn2" href="javascript:void(0);" class="genbtn">儲存</a>
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

