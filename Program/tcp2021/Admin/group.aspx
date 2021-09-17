<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="group.aspx.cs" Inherits="Admin_group" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            getData(0);

            $(document).on("click", "#subbtn", function () {
                $("#errMsg").empty();
                var msg = '';
                if ($("#txt_Name").val() == "")
                    msg += "請輸入【組別名稱】\n";

                if (msg != "") {
                    alert("Error message: \n" + msg);
                    return false;
                }

                var str = '';
                if (($("input[name='rdbtn']:checked").val() == 'D') && ($("#flag").val() == 'mod'))
                    str = confirm('下架組別將會連同組員一同下架，確定儲存嗎?');
                else
                    str = confirm('確定儲存嗎?');

                if (str) {
                    $.ajax({
                        type: "POST",
                        async: false, //在沒有返回值之前,不會執行下一步動作
                        url: "BackEnd/AddGroup.aspx",
                        data: {
                            mode: $("#flag").val(),
                            gguid: $("#Gguid").val(),
                            name: $("#txt_Name").val(),
                            status: $("input[name='rdbtn']:checked").val(),
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
                                $.magnificPopup.close();
                                location.href = "group.aspx";
                            }
                        }
                    });
                }
            });

            $(document).on("click", "#newbtn", function () {
                $("#txt_Name").val("");
                $("input[name='rdbtn'][value='A']").prop("checked", true);
                $("#flag").val("new");

                doOpenMagPopup();
            });

            $(document).on("click", "a[name='editbtn']", function () {
                $("#Gguid").val($(this).attr("aid"));
                $("#txt_Name").val($(this).attr("aname"));
                $("input[name='rdbtn'][value='" + $(this).attr("astatus") + "']").prop("checked", true);
                $("#flag").val("mod");

                doOpenMagPopup();
            });
        });

        function getData(p) {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Admin/BackEnd/GetGroupList.aspx",
                data: {
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
                                var status = $(this).children("G_Status").text().trim();
                                tabstr += '<tr>'
                                tabstr += '<td class="" align="center">' + $(this).children("G_Name").text().trim() + '</td>';
                                if (status == 'A')
                                    tabstr += '<td class="" align="center">上架</td>';
                                else
                                    tabstr += '<td class="" align="center">下架</td>';
                                tabstr += '<td align="center">';
                                tabstr += '<a name="editbtn" aid="' + $(this).children("G_Guid").text().trim() + '" aname="' + $(this).children("G_Name").text().trim() + '" astatus="' + status + '" href="javascript:void(0);">編輯</a>'
                                tabstr += '</td></tr>';
                            });
                        }
                        else
                            tabstr += '<tr><td colspan="3">查詢無資料</td></tr>';
                        $("#tablist tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock";
                        Page.Option.FunctionName = "getData";
                        Page.CreatePage(p, $("total", data).text());
                    }
                }
            });
        }

        function doOpenMagPopup() {
            $.magnificPopup.open({
                items: {
                    src: '#teambox'
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <input type="hidden" id="Gguid" />
    <input type="hidden" id="flag" />
    <div class="container margin15T">

       <div class="filetitlewrapper">
           <span class="filetitle font-size6">組別管理</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>

       <div class="twocol margin20T">
           <div class="left">
               <span class="font-size4 font-bold font-title">組別清單</span>
           </div><!-- left -->
           <div class="right">
                <a id="newbtn" href="javascript:void(0);" class="genbtnS">新增</a>
           </div><!-- right -->
       </div><!-- twocol -->


       <div class="stripeMe margin5T" style="overflow-x: auto">
           <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
               <thead>
                    <tr>
                        <th nowrap>組別名稱</th>
                        <th nowrap>顯示</th>
                        <th nowrap>功能</th>
                    </tr>
               </thead>
               <tbody></tbody>
           </table>
       </div><!-- stripeMe -->
         <div class="margin10B margin10T textcenter">
	        <div id="pageblock"></div>
	    </div>
     
   </div><!-- conainer -->

    <!-- Magnific Popup -->
    <div id="teambox" class="magpopup magSizeS mfp-hide">
      <div class="magpopupTitle">組別管理</div>
      <div class="padding10ALL">
          <div class="gentable margin10T">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                      <td width="100" align="right" nowrap><div class="font-title titlebackicon">組別名稱</div></td>
                      <td >
                          <input id="txt_Name" type="text" class="inputex width100" title="">
                      </td>
                  </tr>
                  <tr>
                      <td align="right" nowrap><div class="font-title titlebackicon">顯示</div></td>
                      <td >
                          <input id="rd_up" name="rdbtn" checked="checked" value="A" type="radio"> 上架 <input name="rdbtn" id="rd_down" value="D" type="radio"> 下架
                      </td>
                  </tr>
              </table>
          </div>
      	<div class="twocol">
        	<div class="right">
                <a id="cancelbtn" href="javascript:void(0);" class="genbtn closemagnificPopup">取消</a>
                <a id="subbtn" href="javascript:void(0);" class="genbtn">儲存</a>
        	</div>
        </div><!-- twocol -->
      </div><!-- padding10ALL -->
    
    </div><!--magpopup -->
</asp:Content>

