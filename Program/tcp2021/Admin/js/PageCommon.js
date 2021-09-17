// JavaScript Document
$(document).ready(MainFunction);//主程式:所有JS程式放在此
//主程式內容
	function MainFunction(){
	clonemenu();//RWD選單處理
	
	$('.itemhint').powerTip({placement:'e',smartPlacement:true,});//powertip:tooltip
	$('.itemhinthold').powerTip({placement:'e',smartPlacement:true,mouseOnToPopup:'true'});//tooltip可點選
	
	//datepicker
	$(".Jdatepicker").datetimepicker({
		format:'Y/m/d',
		timepicker:false,
		withoutBottomPanel: true,
		scrollInput:false,//取消input滾動調整日期功能
		//yearEnd:2022,//下拉選單最末年份
		});
	
	//Magnific Popup
	$('.open-popup-link').magnificPopup({
  		type:'inline',
  		midClick: false, // 是否使用滑鼠中鍵
  		closeOnBgClick:true,//點擊背景關閉視窗
  		showCloseBtn:true,//隱藏關閉按鈕
  		fixedContentPos:true,//彈出視窗是否固定在畫面上
  		mainClass: 'mfp-fade',//加入CSS淡入淡出效果
  		tClose: '關閉',//翻譯字串
	});

	/*  Magnific Popup自動播放 
	$.magnificPopup.open({
    	items: {
        	src: '#test-popup'//要自動播放的ID 
    	},
    	type: 'inline'
     });
	*/
	//Magnific Popup關閉動作
	$(".closemagnificPopup").click(function(){
		$.magnificPopup.close();
	})



	//網站內容預設為桌機版(no-js)下狀態,RWD平板、手機內容以動態方式取代加入,故平板、手機內容需在JS內以變數方式設定
	var Htmlsidemenu = '<i class="fa fa-bars" aria-hidden="true" id="toggle-sidebar"></i>';
	//設定斷點:判斷螢幕尺寸決定內容
	//桌機狀態:瀏覽器大於 980
	$.breakpoint({
        condition: function () {
            return window.matchMedia('all and (min-width:981px)').matches;
        },
        enter: function () {
            $(".superfishmenu").show();
			$("#opensidemenu").html("");
			
        },
    });
	
	//平板手機狀態:瀏覽器介於 980~480
	$.breakpoint({
        condition: function () {
            return window.matchMedia('all and (max-width:980px) and (min-width:480px)').matches;
        },
        enter: function () {
            $(".superfishmenu").hide();
			$("#opensidemenu").html(Htmlsidemenu);

        },

    });
	
	//手機狀態:瀏覽器小於 480 且為橫式
	$.breakpoint({
	condition: function () {
            return window.matchMedia('all and (max-width:479px) and (orientation:landscape)').matches;
        },
        enter: function () {
            $(".superfishmenu").hide();
			$("#opensidemenu").html(Htmlsidemenu);
		
        },
	 });
	 
	 //手機狀態:尺寸小於 480 且為直立 orientation:portrait
	$.breakpoint({
        condition: function () {
            return window.matchMedia('all and (max-width:479px) and (orientation:portrait)').matches;
        },
        enter: function () {
            $(".superfishmenu").hide();
			$("#opensidemenu").html(Htmlsidemenu);

        },

    });
	
	}//MainFunction

	
//RWD選單處理:桌機使用superfish，手機平板使用simplerSidebar，而simplerSidebar內的選單為複製主選單內容。
	function clonemenu(){
	//複製選單到sidebar
	var clonemenu = $(".superfishmenu > ul").clone(false);
	//移除superfish的id與class並給予新id
	clonemenu.appendTo($("#sidebar-wrapper")).attr("id", "sidemenu");
	//啟動下拉選單superfish
	$(".superfishmenu > ul").superfish({delay:300,}).supposition();
	//啟動mmenu
	$("#sidebar-wrapper").mmenu({
		//設定下拉選單為直接向下展開,而非滑動
		slidingSubmenus:false,
		});
	var mmenuswitch = $("#sidebar-wrapper").data( "mmenu" ); 
	  
	  //由於開關是動態加入(利用JS加入),故要使用動態binding的方式加入函式動作
	  $(document).on("click", "#toggle-sidebar", function(){
		  mmenuswitch.open();
		});
	  
	//利用 設定滑動關閉選單
	$("#sidebar-wrapper").swipe({
	swipe:function(event, direction, distance, duration, fingerCount) {//事件，方向，距離（像素為單位），時間，手指數量
		if(direction == "left")//當向上滑動手指時令當前頁面記數器加1
			{mmenuswitch.close();}
		}
	});
	//外部連結處理
	var clonetopmenu = $("#HeaderOtherLink").clone(false);
	clonetopmenu.remove("#HeaderOtherLink").appendTo($("#HeaderOtherLinkCopy"));
	
	}//clonemenu END

