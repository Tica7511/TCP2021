<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FAQ.aspx.cs" Inherits="WebPage_FAQ" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container margin15T">
    <div id="Insidemaincontent">

        <!-- 所有網站內容放在此以下 -->

        <div class="filetitlewrapper">
            <span class="filetitle font-size5">FAQ</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="twocol">

            <div class="right font-black margin10T">
                <i class="fa fa-plus-square-o IconCa" aria-hidden="true"></i><a href="#" id="collapse1open">Open</a>
                <i class="fa fa-minus-square-o IconCa" aria-hidden="true"></i><a href="#" id="collapse1close">Close</a>
            </div><!-- right -->
        </div><!-- twocol -->

        <div id="collapse1" class="margin10B">
            <!-- start -->
            <div>
                <div class="collapseTitle font-size3 font-black font-bold margin10T">1.	Is this workshop free?</div>
                <div>
                    <!-- in start -->
                    <div class="BoxRadiusA BoxBorderSa padding10ALL margin10T">
                        <span class="font-size4 IconCb font-bold">Yes.</span>  There is no registration fee for the workshop
                    </div><!-- BoxRadiusA -->

                    <!-- in end -->
                </div>
            </div>
            <!-- end -->


            <!-- start -->
            <div>
                <div class="collapseTitle font-size3 font-black font-bold margin10T">2.	Is it possible to extend it to regulators in other countries?</div>
                <div>
                    <!-- in start -->
                    <div class="BoxRadiusA BoxBorderSa padding10ALL margin10T">
                        <span class="font-size4 IconCb font-bold">Yes.</span>
                        We welcome regulators from APEC member economies and non-APEC member economies. Please provide their emails to <a href="mailto:TFDAMDCOE@GMAIL.COM">TFDAMDCOE@GMAIL.COM</a>  . We will send information to them.
                    </div><!-- BoxRadiusA -->

                    <!-- in end -->
                </div>
            </div>
            <!-- end -->


            <!-- start -->
            <div>
                <div class="collapseTitle font-size3 font-black font-bold margin10T">3.	What do I need to prepare for the workshop?</div>
                <div>
                    <!-- in start -->
                    <div class="BoxRadiusA BoxBorderSa padding10ALL margin10T">
                        <ul>
                            <li>Please download and read the guidances from TFDA CoE website at <a href="https://tfdamdcoe.itri.org.tw/training.html" target="_blank">https://tfdamdcoe.itri.org.tw/training.html</a>  These guidances are training materials for the workshop.</li>
                            <li>We will request one participant from each regulatory authority to introduce the medical device regulation of its country. The PowerPoint template will be sent out in early August and we expect to receive the pre-record presentation slides on August 21.</li>
                            <li>The practice of EP checklist will be open for participants from August 28 to September 11. Please remember to do the assignment and interact with other trainees.</li>
                        </ul>

                    </div><!-- BoxRadiusA -->

                    <!-- in end -->
                </div>
            </div>
            <!-- end -->



            <!-- start -->
            <div>
                <div class="collapseTitle font-size3 font-black font-bold margin10T">4.	How many people could register for the workshop from one organization?</div>
                <div>
                    <!-- in start -->
                    <div class="BoxRadiusA BoxBorderSa padding10ALL margin10T">
                        We expect at most 2 to 3 participants from one organization, and in total 40-60 participants for the workshop. However, the number of participants is limited. Priority will be considered to regulators. The selection of workshop participants will be made after the registration closing date on July 26. The confirmation letter will be sent out on August 2.
                    </div><!-- BoxRadiusA -->

                    <!-- in end -->
                </div>
            </div>
            <!-- end -->


            <!-- start -->
            <div>
                <div class="collapseTitle font-size3 font-black font-bold margin10T">5.	How could I register for the workshop?</div>
                <div>
                    <!-- in start -->
                    <div class="BoxRadiusA BoxBorderSa padding10ALL margin10T">
                        You could register for the workshop on TFDA CoE website at:  <a href="https://tfdamdcoe.itri.org.tw/Registration.html">https://tfdamdcoe.itri.org.tw/Registration.html</a>
                    </div><!-- BoxRadiusA -->

                    <!-- in end -->
                </div>
            </div>
            <!-- end -->
        </div><!-- collapse1 -->
        <!-- 所有網站內容放在此以上 -->
    </div><!-- Insidemaincontent -->
    </div>

<!-- 本頁面使用的JS -->
<script type="text/javascript">
    $(document).ready(function(){
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
            $("#collapse1").trigger("open")
        });
        $("#collapse1close").click(function(){
            $("#collapse1").trigger("close")
        });
    });
</script>
</asp:Content>

