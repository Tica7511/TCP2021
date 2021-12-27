<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="newsview.aspx.cs" Inherits="Admin_newsview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../tinymce/tinymce.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        tinymce.init({
            selector: "textarea",
            language: "zh_TW",
            //menubar: false, //上方工具列顯示or隱藏
            file_browser_callback: function (field_name, url, type, win) {
                if (type == "image") {
                    tinymce.activeEditor.windowManager.close();
                    tinymce.activeEditor.windowManager.open({
                        title: "圖片上傳",
                        url: '<%= ResolveUrl("~/tinymce/ImageUpload/upload.aspx") %>',
                        width: 350,
                        height: 120
                    });
                }
            },
            plugins: ["advlist autolink lists image link charmap print preview searchreplace visualblocks code fullscreen insertdatetime table contextmenu paste pagebreak textcolor image"],
            font_formats: "新細明體=新細明體;標楷體=標楷體;微軟正黑體=微軟正黑體;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Comic Sans MS=comic sans ms,sans-serif;Times New Roman=times new roman,times;",
            pagebreak_separator: "<!--pagebreak-->",
            image_advtab: true, //圖片進階選項
            relative_urls: false,
            remove_script_host: false,
            convert_urls: true,
            toolbar1: "undo redo | bold italic underline | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link pagebreak table image | forecolor backcolor | fontselect fontsizeselect",
            fontsize_formats: "8pt 10pt 12pt 14pt 18pt 24pt 36pt 42pt 60pt 72pt"
        });

        $(document).ready(function () {
            GetDDL();

            if ($.getQueryString("id") != "") {
                GetDetail();
            }
            else {
                var ThisDate = new Date();
                var hh = ThisDate.getHours().toString();
                var mm = ThisDate.getMinutes().toString();

                while (hh.length < 2) {
                    hh = '0' + hh;
                }
                while (mm.length < 2) {
                    mm = '0' + mm;
                }
                $("#nDate").val($.datepicker.formatDate('yy/mm/dd', new Date()));
                $("#nDateHH").val(hh);
                $("#nDateMM").val(mm);
            }                

            $(document).on("click", "a[name='subbtn']", function () {
                $("#errMsg").empty();
                var msg = '';
                if ($("#nTitle").val() == "")
                    msg += "請輸入【標題】<br>";
                if ($("#nDate").val() == "" || $("#nDateHH").val() == "" || $("#nDateMM").val() == "") {
                    msg += "請輸入完整的【發表時間】\n";
                }
                else {
                    if (!ValidDate($("#nDate").val()))
                        msg += "【發表時間】日期格式不正確\n";
                    if (!ValidTime($("#nDateHH").val()))
                        msg += "【發表時間】小時格式不正確\n";
                    if (!ValidTime($("#nDateMM").val()))
                        msg += "【發表時間】分鐘格式不正確\n";
                }
                    
                if ($("#nSort").val() == "")
                    msg += "請選擇【排序】<br>";

                if (msg != "") {
                    $("#errMsg").html("Error message: <br>" + msg);
                    return false;
                }

                mode = ($.getQueryString("id") == "") ? "new" : "mod";
                // '<' & '>' 做全形處理
                tinyMCE.activeEditor.dom.addClass(tinyMCE.activeEditor.dom.select('img'), 'img-responsive');
                var content_tmp = tinyMCE.get("nContent").getContent().trim().replace(/&lt;/g, "＜").replace(/&gt;/g, "＞");

                // Get form
                var form = $('#form1')[0];

                // Create an FormData object 
                var data = new FormData(form);

                // If you want to add an extra field for the FormData
                data.append("id", $.getQueryString("id"));
                data.append("nGuid", $("#tmpGuid").val());
                data.append("mode", mode);
                data.append("nSort", $("#nSort").val());
                data.append("nDate", insertsqlDate($("#nDate").val()) + $("#nDateHH").val() + $("#nDateMM").val());
                data.append("nContent", encodeURIComponent(content_tmp));
                data.append("nStatus", $("input[name='rdbtn']:checked").val());
                data.append("DelImgStatus", $("#DelImgStatus").val());

                $.ajax({
                    type: "POST",
                    async: false, //在沒有返回值之前,不會執行下一步動作
                    url: "BackEnd/AddNews.aspx",
                    data: data,
                    processData: false,
                    contentType: false,
                    cache: false,
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
                            location.href = "newslist.aspx";
                        }
                    }
                });
            });

            // 取消 button
            $(document).on("click", "a[name='cancelbtn']", function () {
                if (confirm("確定取消?")) {
                    location.href = "newslist.aspx";

                    // 關閉瀏覽器分頁
                    //window.opener = null;
                    //window.open("", "_self");
                    //window.close();
                }
            });

            //時間 => 小時 防呆用
            $(document).on("blur", "input[name='txt_hh']", function () {
                var v = this.value;

                while (v.length < 2) {
                    v = '0' + v;
                }
                this.value = v;

                if (parseInt(this.value) < 0) {
                    this.value = '00';
                }

                if (parseInt(this.value) > 23) {
                    this.value = '23';
                }
            });

            //時間 => 分鐘 防呆用
            $(document).on("blur", "input[name='txt_mm']", function () {
                var v = this.value;

                while (v.length < 2) {
                    v = '0' + v;
                }
                this.value = v;

                if (parseInt(this.value) < 0) {
                    this.value = '00';
                }

                if (parseInt(this.value) > 59) {
                    this.value = '59';
                }
            });
        });// end js

        //驗證 開放時間/關閉時間 日期格式是否有誤
        function ValidDate(str) {
            var status = true;
            var ValidAry = str.split('/');
            if (ValidAry.length < 2)
                status = false;
            else {
                // 年
                if (parseInt(ValidAry[0]) < 1 || parseInt(ValidAry[0]) > 9999)
                    status = false;
                // 月
                if (parseInt(ValidAry[1]) < 1 || parseInt(ValidAry[1]) > 12)
                    status = false;
                else {
                    if (ValidAry[1].length != 2)
                        status = false;
                }

                if (ValidAry[2] != null) {
                    // 日
                    if (parseInt(ValidAry[2]) < 1 || parseInt(ValidAry[2]) > 31)
                        status = false;
                    else {
                        if (ValidAry[2].length != 2)
                            status = false;
                    }
                }
            }
            return status;
        }

        //驗證 小時/分鐘 的字串長度不可小於2
        function ValidTime(str) {
            var status = true;
            if (str.length < 2)
                status = false;

            return status;
        }

        function GetDetail() {
            $("#errMsg").empty();
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "BackEnd/GetNews.aspx",
                data: {
                    type: "data",
                    nid: $.getQueryString("id")
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
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                $("#tmpGuid").val($(this).children("N_Guid").text().trim());
                                $("#nSort").val($(this).children("N_Sort").text().trim());
                                $("#nDate").val(getDate($(this).children("N_Date").text().trim()));
                                $("#nDateHH").val(getHH($(this).children("N_Date").text().trim()));
                                $("#nDateMM").val(getMM($(this).children("N_Date").text().trim()));
                                $("#nTitle").val($(this).children("N_Title").text().trim());
                                // 內容
                                var content_tmp = $(this).children("N_Content").text().trim();
                                if ($("#tmpBrowser").val() == "internetexplorer")
                                    tinymce.activeEditor.setContent(content_tmp);
                                else
                                    $("#nContent").val(content_tmp);
                                if ($(this).children("N_Status").text().trim() == 'A')
                                    $("#rd_up").prop("checked", true);
                                else
                                    $("#rd_down").prop("checked", true);
                            });
                        }
                    }
                }
            });
        }

        function GetDDL() {

            var mode = ($.getQueryString("id") == "") ? "new" : "mod";

            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "BackEnd/GetNewsSort.aspx",
                data: {
                    mode: mode,
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
                                $("#nSort").append($("<option></option>").attr("value", $(this).children("N_Sort").text().trim()).text($(this).children("N_Sort").text().trim()));
                            });
                        }
                    }
                }
            });
        }

        function insertsqlDate(fulldate) {
            var farray = new Array();
            farray = fulldate.split("/");
            var yyyy = farray[0];
            var mm = farray[1];
            var dd = farray[2];

            return yyyy + mm + dd;
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <input type="hidden" id="tmpBrowser" value="<%= BrowserName %>" />
    <input id="tmpGuid" type="hidden" />
    <div class="container margin15T">

       <div class="filetitlewrapper">
           <span class="filetitle font-size6">最新消息</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>


       <div class="twocol margin10T">
           <div class="left">
               <span class="font-size4 font-bold font-title">新聞資訊</span>
           </div><!-- left -->
           <div class="right">
               <a href="javascript:void(0);" name="cancelbtn" class="genbtn">取消</a>
               <a href="javascript:void(0);" name="subbtn" class="genbtn">儲存</a>
           </div><!-- right -->
       </div><!-- twocol -->


       <div class="gentable margin10T">
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                   <td align="right" nowrap><div class="font-title titlebackicon">新聞名稱</div></td>
                   <td colspan="5">
                       <input id="nTitle" name="nTitle" type="text" class="inputex width100" title="">
                   </td>
               </tr>


               <tr>
                   <td align="right" nowrap class="width10"><div class="font-title titlebackicon">發表時間</div></td>
                   <td class="width40">
                       <input id="nDate" type="text" class="inputex Jdatepicker" title="">&emsp;
                       <input id="nDateHH" name="txt_hh" type="number" min="0" max="23" class="inputex width15" title="" /> : 
                       <input id="nDateMM" name="txt_mm" type="number" min="0" max="59" class="inputex width15" title="" />
                   </td>
                   <td align="right" nowrap class="width10"><div class="font-title titlebackicon">顯示</div></td>
                   <td class="width40">
                       <input id="rd_up" name="rdbtn" checked="checked" value="A" type="radio"> 上架 <input name="rdbtn" id="rd_down" value="D" type="radio"> 下架
                   </td>
               </tr>
               <tr>
                   <td align="right" nowrap class="width10"><div class="font-title titlebackicon">排序</div></td>
                   <td class="width40">
                       <select id="nSort" name="txt_sort" class="inputex width15"></select>
                   </td>
               </tr>

           </table>
       </div>

       <div class="twocol margin10T">
           <div class="left">
               <span class="font-size4 font-bold font-title">新聞內容</span>
           </div><!-- left -->
           <div class="right">

           </div><!-- right -->
       </div><!-- twocol -->

       <textarea id="nContent" rows="30" cols="" class="width100 TB_Content"></textarea>
       <div id="errMsg" style="color:red;"></div>

       <div class="twocol margin10TB">
           <div class="left">

           </div><!-- left -->
           <div class="right">
               <a href="javascript:void(0);" name="cancelbtn" class="genbtn">取消</a>
               <a href="javascript:void(0);" name="subbtn" class="genbtn">儲存</a>
           </div><!-- right -->
       </div><!-- twocol -->
     
   </div><!-- conainer -->
</asp:Content>

