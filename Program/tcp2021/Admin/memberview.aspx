<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="memberview.aspx.cs" Inherits="Admin_memberview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            //會員編輯
            if ($.getQueryString("guid") != '') {
                getGroup();
                getData();
            }
            //會員新增
            else {
                getGroup();
                $("#PopupImg").attr("src", "../images/default-people.jpg");
            }

            $("#imgPath").change(function () {
                readURL(this);
            });

            $(document).on("click", "#subbtn", function () {
                $("#errMsg").empty();
				var msg = '';
				if ($("#txt_email").val() == "")
					msg += "請輸入【信箱】<br>";
				if ($("#txt_name").val() == "")
					msg += "請輸入【姓名】<br>";
                if ($("#txt_birthday").val() == "")
                    msg += "請輸入【密碼】<br>";
                if ($("#sel_group").val() == '') {
                    if (($("#txt_competence").val() == '02') || ($("txt_competence").val() == '03')) {
                        msg += "請輸入【組別】<br>";
                    }
                }
                //else
                //    if (!ValidDate($("#txt_birthday").val()))
                //        msg += "【生日】日期格式不正確";

				if (msg != "") {
					$("#errMsg").html("Error message: <br>" + msg);
					return false;
				}

				var mode = ($.getQueryString("guid") == "") ? "new" : "mod";

				// Get form
				var form = $('#form1')[0];

				// Create an FormData object 
				var data = new FormData(form);

				// If you want to add an extra field for the FormData
				data.append("guid", $.getQueryString("guid"));
				data.append("account", $("#txt_email").val());
				data.append("name", $("#txt_name").val());
				data.append("password", encodeURIComponent($("#txt_birthday").val()));
				data.append("competence", $("#txt_competence").val());
                data.append("group", $("#sel_group").val());
                /*data.append("introduction", $("#txt_introduction").val());*/
                data.append("status", $("input[name='rdbtn']:checked").val());
                data.append("mode", mode);
                /*data.append('fileUpload', $("#imgPath").get(0).files[0]);*/

				$.ajax({
					type: "POST",
					async: false, //在沒有返回值之前,不會執行下一步動作
					url: "BackEnd/AddMember.aspx",
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
                            if ($("relogin", data).text() == 'Y')
                                location.href = "../Handler/logout.aspx";
                            else
                                location.href = "memberlist.aspx";
						}
					}
				});
            });

            $(document).on("click", "#cancelbtn", function () {
				if (confirm("確定取消?")) {
					location.href = "memberlist.aspx";
				}
            });

            $(document).on("change", "#txt_competence", function () {
                if ($(this).find(":selected").val().toString().trim() == '01') {
                    $("#sel_group").val("").change();
                    $("#sel_group").prop('disabled', true);
                }
                else {
                    $("#sel_group").prop('disabled', false);
                }
            });
        });

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

        function getPassword(str) {
            var ValidAry = str.split('/');
            return ValidAry[0] + ValidAry[1] + ValidAry[2];
        }

        function getData() {
            $("#errMsg").empty();
			$.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetMember.aspx",
                data: {
                    guid: $.getQueryString("guid"),
                    type: "data",
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
                                $("#txt_email").val($(this).children("M_Account").text().trim());
                                $("#txt_name").val($(this).children("M_Name").text().trim());
                                $("#txt_birthday").val($(this).children("M_Pwd").text().trim());
                                $("#txt_competence").val($(this).children("M_Competence").text().trim());
                                if ($(this).children("M_Competence").text().trim() == '01') {
                                    $("#sel_group").prop('disabled', true);
                                }
                                $("#sel_group").val($(this).children("M_Group").text().trim());
                                /*$("#PopupImg").attr("src", "../DOWNLOAD.aspx?type=01&v=" + $(this).children("EncodeGuid").text().trim());*/
                                /*$("#txt_introduction").val($(this).children("M_Introduction").text().trim());*/
                                if ($(this).children("M_Status").text().trim() == 'A')
                                    $("#rd_up").prop("checked", true);
                                else
                                    $("#rd_down").prop("checked", true);
							});
                        }
					}
				}
			});
        }

        function getGroup() {
            $.ajax({
                type: "POST",
                async: false, //在沒有返回值之前,不會執行下一步動作
                url: "../Admin/BackEnd/GetDLL.aspx",
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
                        $("#sel_group").append($("<option></option>").attr("value", "").text("請選擇"));
                        if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                $("#sel_group").append($("<option></option>").attr("value", $(this).children("G_Guid").text().trim()).text($(this).children("G_Name").text().trim()));
                            });
                        }
                    }
                }
            });
        }

        function getDate(fulldate) {
            var year = fulldate.substring("0", "4");
            var month = fulldate.substring("4", "6");
            var date = fulldate.substring("6", "8");

            return year + "/" + month + "/" + date;
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="filetitlewrapper">
        <span class="filetitle font-size6">會員管理</span>
        <!--<span class="itemright">麵包屑</span>-->
    </div>

    <div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">會員基本資料</span>
        </div><!-- left -->
        <div class="right">

        </div><!-- right -->
    </div><!-- twocol -->

    <div class="gentable">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon">信箱</div></td>
                <td>
                    <input id="txt_email" type="text" class="inputex width100" title="信箱" />
                </td>
                <td align="right" nowrap class="width10"><div class="font-title titlebackicon">顯示</div></td>
                <td class="width40">
                    <input id="rd_up" name="rdbtn" checked="checked" value="A" type="radio"> 上架 <input name="rdbtn" id="rd_down" value="D" type="radio"> 下架
                </td>
            </tr>
            <tr>
                <td align="right" nowrap class="width10"><div class="font-title titlebackicon">姓名</div></td>
                <td class="width40">
                    <input id="txt_name" type="text" class="inputex width100" title="姓名" />
                </td>
                <td align="right" nowrap class="width10"><div class="font-title titlebackicon">密碼</div></td>
                <td class="width40">
                    <input id="txt_birthday" type="text" class="inputex width100" title="密碼" />
                </td>
            </tr>
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon">身份</div></td>
                <td>
                    <select id="txt_competence" class="inputex width100">
                        <option value="02" selected="selected">會員</option>
                        <option value="03">會員組長</option>
                        <option value="01">管理者</option>
                    </select>
                </td>
                <td align="right" nowrap><div class="font-title titlebackicon">組別</div></td>
                <td>
                    <select id="sel_group" class="inputex width100">
                    </select>
                </td>
            </tr>
            <%--<tr>
                <td align="right" nowrap><div class="font-title titlebackicon">照片</div></td>
                <td colspan="3">
                    <img id="PopupImg" onerror="javascript:this.src='../images/default-people.jpg';" height="150" />
                    <div class="margin5T">
                        <input id="imgPath" type="file" />
                    </div>
                </td>

            </tr>
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon">簡介</div></td>
                <td colspan="3">
                    <textarea id="txt_introduction" rows="8" cols="" class="inputex width100"></textarea>
                </td>

            </tr>--%>

        </table>
    </div>


    <div class="twocol margin10TB">
        <div class="left">
            <span id="errMsg" style="color:red;"></span>
        </div><!-- left -->
        <div class="right">
            <a id="cancelbtn" href="javascript:void(0);" class="genbtn">取消</a>
            <a id="subbtn" href="javascript:void(0);" class="genbtn">儲存</a>
        </div><!-- right -->
    </div><!-- twocol -->
</asp:Content>

