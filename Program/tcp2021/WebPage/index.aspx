<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="WebPage_index" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container margin15T">
    <div id="Insidemaincontent">
        <!-- 所有網站內容放在此以下 -->
        <!--<span class="font-normal"><a id="MainContent" href="#MainContent" title="內容" accesskey="C" tabindex="">:::</a></span>-->

        <div class="filetitlewrapper">
            <span class="filetitle font-size5">About Workshop</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="lineheight03 margin10T">
            The 2021 APEC Medical Devices Regulatory Science Center of Excellence Workshop focuses on training and education related to pre-market submission of medical devices. The concept of using essential principles to perform the conformity assessment of medical devices will be promoted. Through this workshop, it is expected that all member economies will gain a greater understanding of international best practices, learn to implement harmonized approaches, seek to facilitate regulatory convergence for medical devices within APEC economies, and this in turn may benefit the health and well-being of people in the Asia-Pacific region.
        </div>

        <div class="filetitlewrapper margin10T">
            <span class="filetitle font-size5">Target Audience</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="lineheight03 margin10T">
            <ul>
                <li>Regulators from APEC member economies and non-member economies</li>
                <li>Industry managers (or equivalent position) who have experience in product application submission</li>
                <li>Academic researchers or industry managers who have experience in product development</li>
            </ul>

        </div>

        <div class="filetitlewrapper margin10T">
            <span class="filetitle font-size5">Venue</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="lineheight03 margin10T">
            The workshop will be held virtually by online courses, with the addition of website tools and resources utilized for the training exercises.
        </div>

        <div class="filetitlewrapper margin10T">
            <span class="filetitle font-size5">Certificate Requirements</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="lineheight03 margin10T">
            Each trainee is expected to complete 5 online courses, training exercises, and questionnaires. The requirements are:
            <ul>
                <li>Completion of the total hours of all 5 online courses</li>
                <li>Submission of answers to training exercises, i.e., Essential Principles conformity checklists for case studies (MD/IVD)</li>
                <li>Completion of all questionnaires</li>
            </ul>
        </div>


        <div class="BoxRadiusB BoxBorderDa padding10ALL IconCc font-bold margin10T">
            There is no registration fee for participating in the workshop.
        </div>

        <div class="filetitlewrapper margin10T">
            <span class="filetitle font-size5">CoE Hosting Institution</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="row margin10T">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <div class="BoxBorderSa BoxRadiusA BoxShadowD textcenter padding10ALL">
                    <img alt="logo-fda" src="<%= ResolveUrl("~/images/logo-fda.png") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">Taiwan Food and Drug Administration</div>
                </div>
            </div><!-- col -->
        </div><!-- row -->

        <div class="filetitlewrapper margin10T">
            <span class="filetitle font-size5">Co-Organizer</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="row margin10T">
            <div class="col-lg-12 col-md-12 col-sm-12">
                <div class="BoxBorderSa BoxRadiusA BoxShadowD textcenter padding10ALL">
                    <img alt="logo-apec" src="<%= ResolveUrl("~/images/logo-apec.png") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">The APEC LSIF Regulatory Harmonization Steering Committee</div>
                </div>
            </div><!-- col -->
        </div><!-- row -->

        <div class="filetitlewrapper margin10T">
            <span class="filetitle font-size5">Program Committee</span>
            <!--<span class="itemright">麵包屑</span>-->
        </div>

        <div class="row margin10T">
            <div class="col-lg-6 col-md-6 col-sm-12 margin20B">
                <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL equalheightblock">
                    <img alt="logo-pmda" src="<%= ResolveUrl("~/images/logo-pmda.png") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">Pharmaceuticals and Medical Devices Agency</div>
                </div>
            </div><!-- col -->
            <div class="col-lg-6 col-md-6 col-sm-12 margin20B">
                <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL equalheightblock">
                    <img alt="logo-jira" src="<%= ResolveUrl("~/images/logo-jira.png") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">Japan Medical Imaging and Radiological Systems Industries </div>
                </div>
            </div><!-- col -->

            <div class="col-lg-6 col-md-6 col-sm-12 margin20B">
                <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL equalheightblock">
                    <img alt="logo-advamed" src="<%= ResolveUrl("~/images/logo-advamed.png") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">Advanced Medical Technology Association</div>
                </div>
            </div><!-- col -->

            <div class="col-lg-6 col-md-6 col-sm-12 margin20B">
                <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL equalheightblock">
                    <img alt="logo-tmbia" src="<%= ResolveUrl("~/images/logo-tmbia.png") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">Taiwan Medical and Biotech Industry Association</div>
                </div>
            </div><!-- col -->

            <div class="col-lg-6 col-md-6 col-sm-12 margin20B">
                <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL equalheightblock">
                    <img alt="logo-tamta" src="<%= ResolveUrl("~/images/logo-tamta.jpg") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">Taiwan Advanced Medical Technology Association</div>
                </div>
            </div><!-- col -->

            <div class="col-lg-6 col-md-6 col-sm-12 margin20B">
                <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL equalheightblock">
                    <img alt="logo-itri" src="<%= ResolveUrl("~/images/logo-itri.jpg") %>" class="img-responsive imgcenter imgmaxheight" />
                    <div class="font-bold margin5T">Industrial Technology Research Institute</div>
                </div>
            </div><!-- col -->
        </div><!-- row -->




        <!-- 所有網站內容放在此以上 -->
    </div><!-- Insidemaincontent -->
    </div>

    <!-- Magnific Popup -->
    <div id="intropopup" class="magpopup magSizeM mfp-hide">
        <div class="magpopupTitle" style="background: #fff; border-bottom: 0;"></div>
        <div class="padding10ALL">
    
    
            <div class="margin10T">
                <div class="BoxBorderSa BoxRadiusA BoxShadowA textcenter padding10ALL equalheightblock">
                    <div class="font-bold font-size4 margin5T">FAQ</div>
                    <a href="FAQ.html" target="_blank">
                        <img alt="indexFAQ" src="<%= ResolveUrl("~/images/indexFAQ.jpg") %>" class="img-responsive imgcenter" />
                    </a>
                </div>
            </div>
    
            <div class="twocol margin10T">
                <div class="right"><a href="#" class="genbtn closemagnificPopup" title="">Close</a></div>
            </div><!-- twocol -->
        </div><!-- padding10ALL -->
    
    </div><!--magpopup -->

<script type="text/javascript">
    $(document).ready(function(){
        $('.equalheightblock').matchHeight({
            byRow: true,//若為false,則所有區塊等高
            property: 'height',//使用min-height會出問題
            target: null,//設定等高對象:$('.sidebar')
            remove: false
        });


        /*
        $.magnificPopup.open({
            items: {
                src: '#intropopup'//要自動播放的ID
            },
            type: 'inline'
        });
        */


    });
</script>
</asp:Content>

