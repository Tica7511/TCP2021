<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="lessonview.aspx.cs" Inherits="Admin_lessonview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        $(document).ready(function () {

            if ($.getQueryString("guid") != '')
                getData();
            else {
                alert("參數錯誤!將返回前頁");
                location.href = "lessonlist.aspx";
            }      

            //儲存
            $(document).on("click", "#subbtn", function () {
                var msg = '';

                if ($("#txt_name").val() == '')
                    msg += "請輸入【名稱】\n"
                if ($("#txt_opdate").val() == "" || $("#txt_ophh").val() == "" || $("#txt_opmm").val() == "")
                    msg += "請輸入完整的【開放時間】\n";
                else {
                    if (!ValidDate($("#txt_opdate").val()))
                        msg += "【開放時間】日期格式不正確\n";
                    if (!ValidTime($("#txt_ophh").val()))
                        msg += "【開放時間】小時格式不正確\n";
                    if (!ValidTime($("#txt_opmm").val()))
                        msg += "【開放時間】分鐘格式不正確\n";
                }
                if ($("#txt_csdate").val() == "" || $("#txt_cshh").val() == "" || $("#txt_csmm").val() == "")
                    msg += "請輸入完整的【關閉時間】\n";
                else {
                    if (!ValidDate($("#txt_csdate").val()))
                        msg += "【關閉時間】日期格式不正確\n";
                    if (!ValidTime($("#txt_cshh").val()))
                        msg += "【關閉時間】小時格式不正確\n";
                    if (!ValidTime($("#txt_csmm").val()))
                        msg += "【關閉時間】分鐘格式不正確\n";
                }
                if ($("#txt_opdate").val() != "" && $("#txt_ophh").val() != "" && $("#txt_opmm").val() != "" && $("#txt_csdate").val() != "" && $("#txt_cshh").val() != "" && $("#txt_csmm").val() != "")
                    if (ValidDate($("#txt_opdate").val()) && ValidDate($("#txt_csdate").val()))
                        if (ValidDateInterval($("#txt_opdate").val(), $("#txt_ophh").val(), $("#txt_opmm").val()) >= ValidDateInterval($("#txt_csdate").val(), $("#txt_cshh").val(), $("#txt_csmm").val()))
                            msg += "【關閉時間】必須晚於【開放時間】\n";


				if (msg != "") {
                    alert(msg);
					return false;
				}

                $.ajax({
			    	type: "POST",
			    	async: false, //在沒有返回值之前,不會執行下一步動作
			    	url: "BackEnd/AddAssignment.aspx",
			    	data: {
			    		aguid: $.getQueryString("guid"),
                        name: $("#txt_name").val(),
                        opdate: insertsqlDate($("#txt_opdate").val()) + $("#txt_ophh").val() + $("#txt_opmm").val(),
                        csdate: insertsqlDate($("#txt_csdate").val()) + $("#txt_cshh").val() + $("#txt_csmm").val(),
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
                            location.href = "lessonlist.aspx";
			    		}
			    	}
			    });
            });

            //取消
            $(document).on("click", "#cancelbtn", function () {
                if (confirm("確定取消?")) {
					location.href = "lessonlist.aspx";
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

        });

        function getData() {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "BackEnd/GetAssignment.aspx",
                data: {
                    type: "data",
                    aguid: $.getQueryString("guid"),
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
                                $("#txt_name").val($(this).children("A_Name").text().trim());
                                $("#txt_opdate").val(getDate($(this).children("A_OpenDate").text().trim()));
                                $("#txt_ophh").val(getHH($(this).children("A_OpenDate").text().trim()));
                                $("#txt_opmm").val(getMM($(this).children("A_OpenDate").text().trim()));
                                $("#txt_csdate").val(getDate($(this).children("A_CloseDate").text().trim()));
                                $("#txt_cshh").val(getHH($(this).children("A_CloseDate").text().trim()));
                                $("#txt_csmm").val(getMM($(this).children("A_CloseDate").text().trim()));
                                $("#exportbtn").attr("href", "../EXPORTEXCEL.aspx?type=assignment&v=" + $(this).children("EncodeGuid").text().trim())
							});
                        }
					}
				}
			});
        }

        //取得開放 時間/關閉時間 的DATETIME格式
        function ValidDateInterval(str, strHH, strMM) {
            var ValidAry = str.split('/');

            var realDate = new Date(ValidAry[0], ValidAry[1], ValidAry[2], strHH, strMM);

            return realDate;
        }

        //驗證 小時/分鐘 的字串長度不可小於2
        function ValidTime(str) {
            var status = true;
            if (str.length < 2)
                status = false;

            return status;
        }

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
    <div class="container margin15T">

       <div class="filetitlewrapper">
           <span class="filetitle font-size6">作業管理</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>


       <div class="twocol">
           <div class="left">
               <span class="font-size4 font-bold font-title">作業基本資料</span>
           </div><!-- left -->
           <div class="right">

           </div><!-- right -->
       </div><!-- twocol -->

       <div class="gentable">
           <table width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                   <td align="right" nowrap><div class="font-title titlebackicon">名稱</div></td>
                   <td colspan="3">
                       <input id="txt_name" type="text" class="inputex width100" title="">
                   </td>
               </tr>
               <tr>
                   <td align="right" nowrap class="width10"><div class="font-title titlebackicon">開放時間</div></td>
                   <td class="width40">
                       <input id="txt_opdate" type="text" class="inputex Jdatepicker" title="" />&emsp;
                       <input id="txt_ophh" name="txt_hh" type="number" min="0" max="23" class="inputex width15" title="" /> : 
                       <input id="txt_opmm" name="txt_mm" type="number" min="0" max="59" class="inputex width15" title="" />
                   </td>
                   <td align="right" nowrap class="width10"><div class="font-title titlebackicon">關閉時間</div></td>
                   <td class="width40">
                       <input id="txt_csdate" type="text" class="inputex Jdatepicker" title="" />&emsp;
                       <input id="txt_cshh"  name="txt_hh" type="number" min="0" max="23" class="inputex width15" title="" /> : 
                       <input id="txt_csmm"  name="txt_mm" type="number" min="0" max="59" class="inputex width15" title="" />
                   </td>
               </tr>
           </table>
       </div>

       <div class="twocol margin10TB">
           <div class="left">

           </div><!-- left -->
           <div class="right">
               <a id="cancelbtn" href="javascript:void(0);" class="genbtn">取消</a>
               <a id="exportbtn" href="javascript:void(0);" class="genbtn">匯出會員答案</a>
               <a id="subbtn" href="javascript:void(0);" class="genbtn">儲存</a>
           </div><!-- right -->
       </div><!-- twocol -->
   </div><!-- conainer -->
</asp:Content>

