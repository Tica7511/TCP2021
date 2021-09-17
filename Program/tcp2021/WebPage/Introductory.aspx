<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Introductory.aspx.cs" Inherits="WebPage_Introductory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container margin15T">	

   
   <div id="Insidemaincontent">
       <!-- 所有網站內容放在此以下 -->
       <div class="filetitlewrapper">
           <span class="filetitle font-size5">Welcoming Remarks</span>
           <!--<span class="itemright">麵包屑</span>-->
       </div>
       <div class="lineheight03 font-size3">
            <img src="<%= ResolveUrl("~/images/Shih-Chung.png") %>" class="introimg BoxShadowB img-rounded">
           <p>&nbsp;&nbsp;&nbsp;&nbsp;Hi, everyone. I am Shih-Chung Chen, Minister of Health and Welfare, also serving as chair of the LSIF Executive Board. On behalf of Chinese Taipei, it is my honor to welcome all of you to the 2021 APEC Medical Devices Regulatory Science Center of Excellence Workshop, hosted by the Taiwan FDA.</p>
           <p>&nbsp;&nbsp;&nbsp;&nbsp;Since the COVID-19 outbreak that emerged last year, the world has been confronted with a global health crisis. While vaccines were swiftly developed, we nevertheless have to learn to coexist with the pandemic, which brings changes to the lifestyle of peoples, with many international events already shifting online.</p>
           <p>&nbsp;&nbsp;&nbsp;&nbsp;In order to prepare for the next wave of pandemic, the international community has spared no efforts in developing promising drugs and medical devices. However, as the regulatory framework varies across APEC member economies, it has become a challenge for regulatory authorities to introduce the latest technologies while ensuring user safety and product effectiveness.</p>
           <p>&nbsp;&nbsp;&nbsp;&nbsp;Seeking to advance regulatory convergence in the field of medical products across the APEC region, over the past years, the Regulatory Harmonization Steering Committee under APEC LSIF has been organizing training programs through Regulatory Science Centers of Excellence. With the endorsement from RHSC last year, TFDA has hosted annual online workshops for two consecutive years, in which experts from Chinese Taipei and Japan introduced standards in premarket regulation and shared their insights. Such events serve to foster regulatory harmonization and trust-based cooperation among public health authorities, and contribute to better aligned regulatory requirements among member economies, which ultimately facilitate more seamless trade of medical devices across APEC and lead to improved health and well-being for people in the Asia-Pacific region.</p>
           <p>&nbsp;&nbsp;&nbsp;&nbsp;I would like to express my gratitude to representatives of national health authorities and industry professionals, who have taken time out of their busy schedules to be here, in an effort to enhance international premarket regulatory harmonization. My thanks also go to all trainers, trainees and staff who are joining us.</p>
           <p>&nbsp;&nbsp;&nbsp;&nbsp;Finally, I would like to wish the workshop a resounding success, and wish you all health and happiness. Thank you.</p>
           <p class="textright">
               Minister of Health and Welfare<br>
               Dr. Shih-Chung Chen
           </p>

       </div>

       <!-- 所有網站內容放在此以上 -->
   </div><!-- Insidemaincontent -->
   
   </div><!-- conainer -->
</asp:Content>

