<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="otherclassview.aspx.cs" Inherits="Admin_otherclassview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            getSort();
            if ($.getQueryString("guid") != '') {
                getData();
            }
            getFileList(0);
            getMemberClassList(0);
            getForumsData(0);
            $("#txt_embedcode").attr("placeholder", '嵌入碼要像此範例: <iframe src="..."></iframe> 並且請將src內的 width,height 個別設置成 "940", "529" ');

            //儲存
            $(document).on("click", "a[name='subbtn']", function () {
                var msg = '';
				if ($("#txt_name").val() == "")
					msg += "請輸入【課程名稱】\n";
				if ($("#txt_embedcode").val() == "")
                    msg += "請輸入【影片嵌入碼】\n";
                //else
                //    if (!MatchRegex($("#txt_name").val()))
                //        msg += "【影片嵌入碼】格式不正確\n";
                if ($("#txt_teachername").val() == "")
                    msg += "請輸入【講師名稱】\n";
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
                if ($("#txt_sort").val() == "")
                    msg += "請選擇【排序】\n";
                if (msg != "") {
                    alert("Error message: \n" + msg);
					return false;
                }

                var mode = ($.getQueryString("guid") == "") ? "new" : "mod";

				// Get form
				var form = $('#form1')[0];

				// Create an FormData object 
				var data = new FormData(form);

				// If you want to add an extra field for the FormData
				data.append("guid", $.getQueryString("guid"));
				data.append("name", $("#txt_name").val());
				data.append("embedcode", encodeURIComponent($("#txt_embedcode").val()));
				data.append("teachername", $("#txt_teachername").val());
				data.append("opdate", insertsqlDate($("#txt_opdate").val()) + $("#txt_ophh").val() + $("#txt_opmm").val());
				data.append("csdate", insertsqlDate($("#txt_csdate").val()) + $("#txt_cshh").val() + $("#txt_csmm").val());
				data.append("sort", $("#txt_sort").val());
				data.append("status", $("input[name='rdbtn']:checked").val());
                data.append("mode", mode);

				$.ajax({
					type: "POST",
					async: false, //在沒有返回值之前,不會執行下一步動作
					url: "BackEnd/AddOtherClass.aspx",
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
                            location.href = "classlist.aspx";
						}
					}
				});

            });

            $(document).on("click", "a[name='cancelbtn']", function () {
                if (confirm("確定取消?")) {
					location.href = "classlist.aspx";
				}
            });

            //刪除檔案
            $(document).on("click", "a[name='delbtn']", function () {
                if (confirm("確定刪除?")) {
                    $.ajax({
			        	type: "POST",
			        	async: false, //在沒有返回值之前,不會執行下一步動作
			        	url: "BackEnd/DeleteFile.aspx",
                        data: {
                            gid: $.getQueryString("guid"),
                            encryname: $(this).attr("aid"),
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
                                getFileList(0);
			        		}
			        	}
			        });
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

            //會員觀看紀錄編輯開窗
            $(document).on("click", "a[name='editbtn']", function () {
                $("#Mguid").val($(this).attr("aid"));
                $("#sp_Mname").html($(this).attr("aname"));
                $("#div_radiobtn").empty();
                if ($("span[name='sp_" + $("#Mguid").val() + "']").text() != "完成")
                    $("#div_radiobtn").append('<input name="rd_IsFinish" value="Y" type="radio" /> 完成 <input name="rd_IsFinish" checked="checked" value="N" type="radio" /> 未完成');
                else
                    $("#div_radiobtn").append('<input name="rd_IsFinish" checked="checked" value="Y" type="radio" /> 完成 <input name="rd_IsFinish" value="N" type="radio" /> 未完成');
                doOpenViewPopup();
            });

            //更改觀看紀錄
            $(document).on("click", "#afsubbtn", function () {
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "BackEnd/UpdateMemberClass.aspx",
                    data: {
                        cguid: $.getQueryString("guid"),
                        mguid: $("#Mguid").val(),
                        isfinish: $("input[name='rd_IsFinish']:checked").val(),
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
                            var finish = $("input[name='rd_IsFinish']:checked").val();
                            alert($("Response", data).text());
                            if (finish == 'Y')
                                $("span[name='sp_" + $("#Mguid").val() + "']").html('完成');
                            else
                                $("span[name='sp_" + $("#Mguid").val() + "']").html('未完成');
                            $.magnificPopup.close();
			        	}
                    },
                });
            });

            //取消
            $(document).on("click", "#afcancelbtn", function () {
                $.magnificPopup.close();
            });

            //留言紀錄編輯開窗
            $(document).on("click", "a[name='editFbtn']", function () {
                $("#errMsg").html('');
                $("#Fguid").val($(this).attr("aid"));
                $(".emoji-wysiwyg-editor").html($("span[name='cn_" + $("#Fguid").val() + "']").text());
                doOpenMagPopup();                
            });

            //留言紀錄儲存
            $(document).on("click", "#asubbtn", function () {
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
			    	url: "BackEnd/AddClassForums.aspx",
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
                            getForumsData(0);
                            $.magnificPopup.close();                            
                            //location.href = "members.aspx";
			    		}
			    	}
			    });
            });

            //刪除資料列
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
			        	url: "BackEnd/DeleteClassForums.aspx",
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
                                getForumsData(0);
			        		}
			        	}
			        });
                }
            });

            $(document).on("change", "input[name='fileName']", function () {
                $("#filelist").empty();
                var fp = $("input[name='fileName']");
                var lg = fp[0].files.length; // get length
                var items = fp[0].files;
                var fragment = "";

                if (lg > 0) {
                    for (var i = 0; i < lg; i++) {
                        var fileName = items[i].name; // get file name
 
                        // append li to UL tag to display File info
                        fragment += "<label>" + (i+1) + ". " + fileName + "</label></br>";
                    }
 
                    $("#filelist").append(fragment);
                }
            })

            //取消
            $(document).on("click", "#cancelbtn", function () {
                $.magnificPopup.close();
            });
        });

        //function MatchRegex(str) {
        //    var status = true;

        //    var regexStr = new RegExp('/^(?:(https?|ftp):\/\/)?((?:[a-zA-Z0-9.\-]+\.)+(?:[a-zA-Z0-9]{2,4}))((?:/[\w+=%&.~\-]*)*)\??([\w+=%&.~\-]*)$/');
        //    if (regexStr.test(str) == false)
        //        status = false;

        //    return status;
        //}

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

        function getData() {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "BackEnd/GetOtherClassList.aspx",
                data: {
                    type: "data",
                    cguid: $.getQueryString("guid"),
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
                                $("#txt_name").val($(this).children("OC_Name").text().trim());
                                $("#txt_embedcode").val($(this).children("EncodeEmbedCode").text().trim());
                                $("#txt_teachername").val($(this).children("OC_TeacherName").text().trim());
                                $("#txt_opdate").val(getDate($(this).children("OC_OpenDate").text().trim()));
                                $("#txt_ophh").val(getHH($(this).children("OC_OpenDate").text().trim()));
                                $("#txt_opmm").val(getMM($(this).children("OC_OpenDate").text().trim()));
                                $("#txt_csdate").val(getDate($(this).children("OC_CloseDate").text().trim()));
                                $("#txt_cshh").val(getHH($(this).children("OC_CloseDate").text().trim()));
                                $("#txt_csmm").val(getMM($(this).children("OC_CloseDate").text().trim()));
                                $("#txt_sort").val($(this).children("OC_Sort").text().trim());
                                $("#Csort").val($(this).children("OC_Sort").text().trim());
                                if ($(this).children("OC_Status").text().trim() == 'A')
                                    $("#rd_up").prop("checked", true);
                                else
                                    $("#rd_down").prop("checked", true);
							});
                        }
					}
				}
			});
        }

        function getFileList(p) {
            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "BackEnd/GetFileList.aspx",
                data: {
                    cguid: $.getQueryString("guid"),
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
						$("#tablistFile tbody").empty();
						var tabstr = '';
						if ($(data).find("data_item").length > 0) {
                            $(data).find("data_item").each(function (i) {
                                tabstr += '<tr>'
                                tabstr += '<td class="" align="center">' + $(this).children("itemNo").text().trim() + '</td>';
                                tabstr += '<td class="" align="center">';
                                tabstr += '<a href="../DOWNLOAD.aspx?type=02&v=' + $(this).children("EncodeGuid").text().trim() + '&encryname=' + $(this).children("File_Encryname").text().trim() + '">' + $(this).children("File_Orgname").text().trim() + '</a>';
                                tabstr += '</td>';
                                tabstr += '<td align="center">' + $(this).children("contentDate").text().trim() + '&nbsp;' + $(this).children("contentTime").text().trim() + '</td>';
                                tabstr += '<td align="center">';
                                tabstr += '<a name="delbtn" aid="' + $(this).children("File_Encryname").text().trim() + '" atype="' + $(this).children("File_Type").text().trim() + '" href="javascript:void(0);">刪除</a>';
                                tabstr += '</tr>';
							});
                        }
                        else
							tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
						$("#tablistFile tbody").append(tabstr);
                        Page.Option.Selector = "#pageblockFile";
                        Page.Option.FunctionName = "getFileList";
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }

        function getSort() {

            var mode = ($.getQueryString("guid") == "") ? "new" : "mod";

            $.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "BackEnd/GetOtherClassSort.aspx",
                data: {
                    mode: mode,
                    cguid: $.getQueryString("guid"),
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
                                $("#txt_sort").append($("<option></option>").attr("value", $(this).children("OC_Sort").text().trim()).text($(this).children("OC_Sort").text().trim()));
							});
                        }
					}
				}
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

        function getMemberClassList(p) {
			$.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetMemberClassList.aspx",
                data: {
                    cguid: $.getQueryString("guid"),
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
                                tabstr += '<td class="" align="center">' + $(this).children("itemNo").text().trim() + '</td>';
                                tabstr += '<td class="" align="center">' + $(this).children("M_Name").text().trim() + '</td>';
                                if ($(this).children("MC_IsFinish").text().trim() != "Y")
                                    tabstr += '<td align="center"><span aid="N" name="sp_' + $(this).children("MC_Mguid").text().trim() + '">未完成</span></td>';
                                else
                                    tabstr += '<td align="center"><span aid="Y" name="sp_' + $(this).children("MC_Mguid").text().trim() + '">完成</span></td>';
                                tabstr += '<td align="center"><a name="editbtn" aname="' + $(this).children("M_Name").text().trim() + '" aid="' + $(this).children("MC_Mguid").text().trim() + '" href="javascript:void(0);">編輯</a></td>';
                                tabstr += '</tr>';
							});
                        }
                        else
							tabstr += '<tr><td colspan="4">查詢無資料</td></tr>';
						$("#tablist tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock";
                        Page.Option.FunctionName = "getMemberClassList";
						Page.CreatePage(p, $("total", data).text());
					}
				}
			});
        }

        function getForumsData(p) {
			$.ajax({
				type: "POST",
				async: false, //在沒有返回值之前,不會執行下一步動作
				url: "../Admin/BackEnd/GetClassForumsList.aspx",
                data: {
                    cguid: $.getQueryString("guid"),
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
                                tabstr += '<td class="" align="center">' + $(this).children("itemNo").text().trim() + '</td>';
                                tabstr += '<td class="" align="center">' + $(this).children("M_Name").text().trim() + '</td>';
                                tabstr += '<td><span name="cn_' + $(this).children("CF_Guid").text().trim() + '">' + $(this).children("CF_Content").text().trim() + '</td>';
                                tabstr += '<td align="center">' + $(this).children("contentDate").text().trim() + '&nbsp;' + $(this).children("contentTime").text().trim() + '</td>';
                                tabstr += '<td align="center">';
                                tabstr += '<div class="margin5B"><a name="editFbtn" aid="' + $(this).children("CF_Guid").text().trim() + '" href="javascript:void(0);">編輯</a></div>';
                                tabstr += '<a name="delFbtn" aid="' + $(this).children("CF_Guid").text().trim() + '" atype="' + $(this).children("CF_Type").text().trim() + '" href="javascript:void(0);">刪除</a></td>';
                                tabstr += '</tr>';
							});
                        }
                        else
							tabstr += '<tr><td colspan="5">查詢無資料</td></tr>';
						$("#tablist2 tbody").append(tabstr);
                        Page.Option.Selector = "#pageblock2";
                        Page.Option.FunctionName = "getForumsData";
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

        function doOpenViewPopup() {
            $.magnificPopup.open({
                items: {
                    src: '#viewblock'
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


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <input type="hidden" id="Mguid" />
    <input type="hidden" id="Fguid" />
    <div class="filetitlewrapper">
        <span class="filetitle font-size6">線上課程</span>
        <!--<span class="itemright">麵包屑</span>-->
    </div>

    <div class="twocol margin10TB">
        <div class="left">

        </div><!-- left -->
        <div class="right">
            <a name="cancelbtn" href="javascript:void(0);" class="genbtn">取消</a>
            <a name="subbtn" href="javascript:void(0);" class="genbtn">儲存</a>
        </div><!-- right -->
    </div><!-- twocol -->

    <div class="twocol">
        <div class="left">
            <span class="font-size4 font-bold font-title">線上課程基本資料</span>
        </div><!-- left -->
        <div class="right">

        </div><!-- right -->
    </div><!-- twocol -->

    <div class="gentable">
        <table id="tablistX" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon">課程名稱</div></td>
                <td colspan="3">
                    <input id="txt_name" type="text" class="inputex width100" title="">
                </td>
            </tr>
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon">影片嵌入碼</div></td>
                <td colspan="3">
                    <input id="txt_embedcode" type="text" class="inputex width100" title="">
                </td>
            </tr>
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon">講師名稱</div></td>
                <td colspan="3">
                    <input id="txt_teachername" type="text" class="inputex width100" title="">
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
            <tr>
                <td align="right" nowrap class="width10"><div class="font-title titlebackicon">排序</div></td>
                <td class="width40">
                    <select id="txt_sort" name="txt_sort" class="inputex width15"></select>
                </td>
                <td align="right" nowrap class="width10"><div class="font-title titlebackicon">顯示</div></td>
                <td class="width40">
                    <input id="rd_up" name="rdbtn" checked="checked" value="A" type="radio"> 上架 <input name="rdbtn" id="rd_down" value="D" type="radio"> 下架
                </td>
            </tr>
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon">附件上傳</div></td>
                <td colspan="3">
                    <input name="fileName" type="file" multiple>
                    <%--<a id="a_file" style="display:none"></a>
                    <a id="delbtn" href="javascript:void(0);" class="genbtn" style="display:none">刪除</a>--%>
                </td>
            </tr>
            <tr>
                <td align="right" nowrap><div class="font-title titlebackicon" style="display:none">附件上傳</div></td>
                <td id="filelist">
                    
                </td>
            </tr>
        </table>
    </div>

    <div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">檔案列表</span>
        </div><!-- left -->
        <div class="right">

        </div><!-- right -->
    </div><!-- twocol -->

    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablistFile" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap width="50">序號</th>
                    <th nowrap>檔案名稱</th>
                    <th nowrap width="230">上傳日期</th>
                    <th nowrap width="80">功能</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
	        <div id="pageblockFile"></div>
	    </div>
    </div><!-- stripeMe -->


    <div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">會員觀看紀錄</span>
        </div><!-- left -->
        <div class="right">

        </div><!-- right -->
    </div><!-- twocol -->

    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap width="50">序號</th>
                    <th nowrap>會員</th>
                    <th nowrap width="100">觀看紀錄</th>
                    <th nowrap width="80">功能</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
        <div class="margin10B margin10T textcenter">
	        <div id="pageblock"></div>
	    </div>
    </div><!-- stripeMe -->

    <div class="twocol margin20T">
        <div class="left">
            <span class="font-size4 font-bold font-title">留言紀錄</span>
        </div><!-- left -->
        <div class="right">

        </div><!-- right -->
    </div><!-- twocol -->


    <div class="stripeMe margin5T" style="overflow-x: auto">
        <table id="tablist2" width="100%" border="0" cellspacing="0" cellpadding="0">
            <thead>
                <tr>
                    <th nowrap width="50">序號</th>
                    <th nowrap>留言人</th>
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


    <div class="twocol margin10TB">
        <div class="left">

        </div><!-- left -->
        <div class="right">
            <a name="cancelbtn" href="javascript:void(0);" class="genbtn">取消</a>
            <a name="subbtn" href="javascript:void(0);" class="genbtn">儲存</a>
        </div><!-- right -->
    </div><!-- twocol -->

<!-- Magnific Popup -->
<div id="messageblock" class="magpopup magSizeM mfp-hide">
  <div class="magpopupTitle">留言記錄編輯</div>
  <div class="padding10ALL">

      <p class="lead emoji-picker-container">
          <textarea id="txt_Content" class="form-control textarea-control" rows="5" style="height: 200px;" placeholder="Textarea with emoji Unicode input" data-emojiable="true" data-emoji-input="unicode" ></textarea>
      </p>

      <div class="twocol margin10T">
          <div class="left">
              <span id="errMsg" style="color:red;"></span>
          </div>
          <div class="right">
              <a id="acancelbtn" href="javascript:void(0);" class="genbtn closemagnificPopup">取消</a> 
              <a id="asubbtn" href="javascript:void(0);" class="genbtn">儲存</a>
          </div>
      </div><!-- twocol -->

  </div><!-- padding10ALL -->

</div><!--magpopup -->

<div id="viewblock" class="magpopup magSizeS mfp-hide">
    <div class="magpopupTitle">會員觀看紀錄編輯</div>
    <div class="padding10ALL">

        會員帳號:
        <span id="sp_Mname"></span>&emsp;
        
        <div style="display:inline" id="div_radiobtn">

        </div>

        <div class="twocol margin10T">
            <div class="right">
                <a id="afcancelbtn" href="javascript:void(0);" class="genbtn closemagnificPopup">取消</a> 
                <a id="afsubbtn" href="javascript:void(0); " class="genbtn">儲存</a>
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



